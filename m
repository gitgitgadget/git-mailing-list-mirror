From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] vim ftplugin
Date: Sat, 10 Feb 2007 20:19:47 +0530
Message-ID: <45CDDB8B.1000405@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090700020000050109040902"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 15:50:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtY9-0001tR-Gq
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbXBJOt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbXBJOt6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:49:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:7265 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451AbXBJOt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:49:58 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1098472nze
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 06:49:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=AsqC/PRsc6Fb9eK+UrYqLNwMhKDTW4+lRMcFJVRSMPVAykPJtr8cAao3ObquqszbGkFd4lUQGU0UuoO6ynxCWeE6/4GSUHUlpB4EIgCmzBRSOGW0HI+pHI0OLG6LDfEndR6nJl56cEDpovnx8j/u0X9yhUtLUiCsC+wWVkDyjGY=
Received: by 10.35.68.16 with SMTP id v16mr28197940pyk.1171118997229;
        Sat, 10 Feb 2007 06:49:57 -0800 (PST)
Received: from ?192.168.2.69? ( [59.96.40.183])
        by mx.google.com with ESMTP id f55sm7839728pyh.2007.02.10.06.49.55;
        Sat, 10 Feb 2007 06:49:56 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39225>

This is a multi-part message in MIME format.
--------------090700020000050109040902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is need for the ftplugin found at
http://madism.org/~madcoder/dotfiles/vim/ftplugin/git.vim



--------------090700020000050109040902
Content-Type: text/plain;
 name="k"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k"

--- /tmp/git.vim	2007-02-10 19:58:12.000000000 +0530
+++ /home/kvaneesh/.vim/ftplugin/git.vim	2007-02-10 20:08:41.000000000 +0530
@@ -16,8 +16,8 @@
     " drop everything until '#  (will commit)' and the next empty line
     while i <= line('$')
         let line = getline(i)
-        if line =~ '^#\s*(will commit)$'
-            let i = i + 2
+        if line =~ '^#\s*Changes to be committed:$'
+            let i = i + 3
             break
         endif
 


--------------090700020000050109040902--
