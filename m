From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Q: supplying large sets of path to git commands
Date: Fri, 16 Oct 2009 14:40:23 +0400
Message-ID: <85647ef50910160340s5b608d9cmb13679d7c6a987cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 12:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MykMW-00012S-0J
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 12:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868AbZJPKlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 06:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbZJPKlA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 06:41:00 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:41253 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZJPKk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 06:40:59 -0400
Received: by gxk8 with SMTP id 8so2030904gxk.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ZGL5MNOr/7TktWujlYyrPyPhYTR0SPgiyrrEf2JKBg0=;
        b=pR0nbtMn4gLzaHrduC3clNFFphjv2lGWAhV0iwYOjJ5DmCdTxBvtYI56v8qZwwEYXc
         HH5UACtvHGwOmmumHJkmsBY68wnoOBMPMODVLavFyqZ94z8rSsWH0hkntlJd5HBOcbOE
         b9m++f9h0SZx2jNUjhlq6IYx78BqhSlxQHMME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VcPXjDNucCBGByB/q3Kh1mxq9gooIKq9fSj0REPyWVjftgGv56BSYIxBhfzKyw3QEj
         d391f+dIoK6g//iNUJGAybYLiaIwArFw2sEItuDe0wtk4SQ1ZuYF8G8gehJ8VXQ6XypI
         O4R4Sf3/oDAUCcgcHZ3dtKCSAGuBrCil306yc=
Received: by 10.100.55.18 with SMTP id d18mr1559381ana.80.1255689623487; Fri, 
	16 Oct 2009 03:40:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130474>

Some git commands like git check-attr supports receiving paths from
stdin. For other commands like "git diff" and "git commit --only" I
have not found a way to supply a lot of paths (say 1000). Is there a
standard way pass a additional paths to git commands that works on
windows and unix? It would be nice to have --stdin option for all
commands that might receive a set of paths. Or even better would
something like "--options-from-stdin" and
"--options-from-file=file.txt" as a possible last argument specified
on the command line.

Constantine
