From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH] qgit: add some installation instruction
Date: Sat, 04 Feb 2006 15:32:19 +0100
Message-ID: <43E4BAF3.3040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 15:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5OTX-0004w9-RC
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 15:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWBDOc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 09:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWBDOc2
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 09:32:28 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:63397 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932266AbWBDOc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 09:32:28 -0500
Received: by uproxy.gmail.com with SMTP id h2so198035ugf
        for <git@vger.kernel.org>; Sat, 04 Feb 2006 06:32:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Jyo8y7cmzFC8mfXiZo4dDvBBQBw8ETw8xbdNjTaRD+6QTTfQlcQ2Zo+V5qo/KHOlifOxvl0gvjrBUc74FqPcWSfYIWhzBPHVRZbc/dwDeRETJ/ovhxwWYj2THbplKuohV+aw/IdIiiIH1FEOUxYV8NkwQyzblroSC3sY2DzqQjI=
Received: by 10.48.108.11 with SMTP id g11mr773498nfc;
        Sat, 04 Feb 2006 06:32:25 -0800 (PST)
Received: from ?10.0.0.13? ( [151.56.32.149])
        by mx.gmail.com with ESMTP id m15sm1513572nfc.2006.02.04.06.32.24;
        Sat, 04 Feb 2006 06:32:25 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.6-7.4.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git mailing list <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15595>

With this I would start to post possible patches for list review.

I am planning to post only a very limited number of patches that could be interesting or
that modify someone else work (like in this case, the new Pavel build system).

Is not my intention to add noise to the list, so I will try to keep the patches to the minimum.

In any case, please, Junio, feel free to express any concern about this and I will stop as soon
as started!

Thanks
Marco

-- >8 --

Document how to strip debug information and better explaing when to reconfigure
the build environment.


Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

diff --git a/README b/README
index 0869c0c..f32dce4 100644
--- a/README
+++ b/README
@@ -23,10 +23,11 @@ which is used to locate Qt. Version 0.15
  also work.

  To compile qgit, unpack the tar file (you probably have done it
-already), run "./configure", "make" and "make install". You may need to
-get root permissions for the later. You can run "configure" with full
-path from another empty directory if you want qgit to be compiled in a
-separate directory.
+already), run "./configure", "make" and "make install" or "make install-strip"
+to have debug information removed and install a much smaller bin.
+You may need to get root permissions for the later. You can run "configure"
+with full path from another empty directory if you want qgit to be compiled
+in a separate directory.

  If there is another qgit executable in PATH, "make install" will
  overwrite it. Otherwise, qgit will be installed in /usr/local/bin. You
@@ -41,6 +42,8 @@ Automake, preferably the latest versions
  Only in case you clone the public qgit repository you may need to run
  "autoreconf -i" the first time to create the ./configure file. Do not need
  to run it on a released tarball.
+You may need to run "autoreconf -i" also when pulling revisions that modify
+some build system file, as "configure.ac".


  Command line arguments

---
