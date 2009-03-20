From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Status of GIT for Fedora 10 + gitweb's look
Date: Fri, 20 Mar 2009 16:18:08 -0000
Message-ID: <B041B86F1FF246ACBD68051753788FBE@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 17:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkhRk-0005R8-Bp
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 17:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbZCTQST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 12:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbZCTQST
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 12:18:19 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:51416 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbZCTQSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 12:18:18 -0400
Received: by ewy9 with SMTP id 9so792106ewy.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=5t+FgvCVFReqgqFRuKgYq+hYvJR04GQ+UJLn2olAGkU=;
        b=FkBkvG5S5+I7XUaEGMTgUis4Rkq2f5pSOy9yAZ6Za0dWuLOIJLIY5oT0K5Fnqp5iXZ
         +50Q74A0ZJ3gbZA/cTNVBPfQp0SAu2Cj7GJHudxHvFn2dH5SBc358hDhNBPvG87yqAND
         i55F1UQbAXA5HPilWpB7nFn1nLyfDdn6ukw+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=k1XsgTopNMN3qfYPGkBkKKIfZD3CBTQFtpZE/K+Mg54YYrKT+gS+7EPpLRupo+k8U6
         Q3uaMGUVnsfr0EzKkgRyQfwH6WmmhnGDZsGacnLB+eiBjxwTJq6HF2Alk0SNm9vg+d4Q
         UdwUlUUtUog5hCfy4FKNPriQBuUfZ3Vjh6fNQ=
Received: by 10.216.54.198 with SMTP id i48mr1501630wec.144.1237565895726;
        Fri, 20 Mar 2009 09:18:15 -0700 (PDT)
Received: from HPLAPTOP (aarongray.demon.co.uk [80.177.163.94])
        by mx.google.com with ESMTPS id f8sm3864740nfh.42.2009.03.20.09.18.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Mar 2009 09:18:15 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113975>

I tried installing Git on F10 and got the following :-

[root@localhost ~]# rpm -Uvh git-1.6.2.1-1.fc9.i386.rpm
error: Failed dependencies:
        perl-Git = 1.6.2.1-1.fc9 is needed by git-1.6.2.1-1.fc9.i386
        git = 1.6.0.6-3.fc10 is needed by (installed) 
perl-Git-1.6.0.6-3.fc10.i386
        git = 1.6.0.6-3.fc10 is needed by (installed) 
git-svn-1.6.0.6-3.fc10.i386
        git = 1.6.0.6-3.fc10 is needed by (installed) 
git-daemon-1.6.0.6-3.fc10.i386
        git = 1.6.0.6-3.fc10 is needed by (installed) 
gitweb-1.6.0.6-3.fc10.i386


Can I install from source I could only find F9 SRPMS.

What I am really after knowing is gitweb on the latest version 1.6.2.1 
anything like the nice HTML layout on http://git.kernel.org/ or do I have to 
do the html formatting myself in the perl code ?

Many thanks in advance,

Aaron
