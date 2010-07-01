From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: git reflog delete / manpage confusion
Date: Thu, 1 Jul 2010 15:08:04 +0530
Message-ID: <AANLkTik3bApuScgjXtr-VjhmY4NIuakoX_RZaYLqqpwL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 11:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGDl-0005IS-KW
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab0GAJiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:38:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39415 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0GAJiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:38:07 -0400
Received: by gxk23 with SMTP id 23so918444gxk.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=84C8wHjQlfkVRbsEsTywGed0ZgQuJ2pAcjxp/qtO+OQ=;
        b=f9IdSXpWCN0tRfBDjSLocAulAWeAhiJHGEn6ktnh6sx9FSxCEHJClQyfTlYqLlht/+
         BPTz3ZvRrh1t7uOMcOH3ILSLtpMQgTxD0Uv57B5xRyasbg2pmwcN9LhbVZLeznVvqmel
         x51tAboX4djnMQPXI6u/TyY6yjQ7t5FF0AO+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EAqW4GXi/ZXHOWuM+a7UqK70mcQ9v2EDgt28TIvy86oI4XPHmyiJtyW2kdsrSi2eQn
         YONA69MosBefRI9X1tftNrsBCqNIl2HtWu3irwsWSiPHNasr8p0RM2EYmAHFVJ+RzB1A
         uykm+qyTfkJ8UXrPsh8hoCZhAZ2v25rbZd9vo=
Received: by 10.91.46.19 with SMTP id y19mr8192417agj.133.1277977084471; Thu, 
	01 Jul 2010 02:38:04 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Thu, 1 Jul 2010 02:38:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150021>

git reflog delete HEAD{4} indeed deletes  HEAD{5} or N+1 ; is there a
bug manpage or my interpretation ?

>From Manpage
To delete single entries from the reflog, use the subcommand "delete"
and specify the exact entry (e.g. "git
       reflog delete master@{2}").

-Mahesh
