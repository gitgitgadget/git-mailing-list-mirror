From: Frank Li <lznuaa@gmail.com>
Subject: git.exe diff-index --cached --raw HEAD can not show unmerged file at 
	delete conflict case.
Date: Fri, 27 Feb 2009 22:53:19 +0800
Message-ID: <1976ea660902270653p3b144231h86b98244173d09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 15:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld472-0000LH-SD
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 15:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbZB0OxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 09:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755141AbZB0OxY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 09:53:24 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:39697 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbZB0OxY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 09:53:24 -0500
Received: by ewy25 with SMTP id 25so1230057ewy.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=kcK4Yf4Y3xoZ3z7/jKgihXX60Bo6EJ4ZHQ/GCf8k1Jg=;
        b=tVywexEeMpl2Db/HqRTdW+DwQNhSVXrdBTZeISUVq503MXML0mkwYvzvbInF4fq6P0
         Z3UEgaHw/E7JC+ju0BNQfDiFA7GpVIP5RIlq+IfO54iuGAsIgywz6bR+yedDRZ8dKRDo
         4ZkPw/23m/AfZxWpbZW9k593M23ONQnAuIg9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Imztx0yHtIw2t0ikg59Nu9QZXhOKd3yKRuE4jn7hLDxtw9J1lB7sTW7ZwPGDB3iY9I
         LkOy670efxGc/wGti3vweD4thAOeqTWFFmUl2+EcDLoW5YBcmtPiQkqwLGCxbafzXm3g
         8xswsRuWjmCqu29hb+6eamg2p4WGUu/+YsP/M=
Received: by 10.142.116.12 with SMTP id o12mr1301068wfc.332.1235746399920; 
	Fri, 27 Feb 2009 06:53:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111675>

$ git ls-files -u
100644 658b87c67a68f0b17a835c66ab735e4bbcc5b3ab 1       rb1.txt
100644 e776c70dbc6ea929021515cf4d45a207a2f56517  3       rb1.txt


but use git.exe diff-index  --cached --raw HEAD
show nothing.
