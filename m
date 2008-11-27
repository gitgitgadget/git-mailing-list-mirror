From: William Pursell <bill.pursell@gmail.com>
Subject: summaries in git add --patch
Date: Thu, 27 Nov 2008 21:10:05 +0000
Message-ID: <492F0CAD.3010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5o9E-0004Uv-2q
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYK0VKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbYK0VKM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:10:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:55687 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbYK0VKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:10:10 -0500
Received: by nf-out-0910.google.com with SMTP id d3so627488nfc.21
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=q8chtgUagIlF/2Mq0yTCNpI3ytFDGlN+hIeTEihJEYA=;
        b=TjOL5vxJqqb8ROHRiZmTpFWNjz+qRVOnOt2DA8DFwiP9AXAkeuIgfjA73yjcoZwDdV
         09OsebsavM6u3wISwWpedB4U9fI+lOaV03jujsh0o8xnxW1fImoAqEyFkJjbI6Hq9B80
         sHhufrb8sz4zbRj3KKPBwGS8g2div7SolL/2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=l91Wa/QwSaEKmZsWrYA7glOaqCCtzXawNefYYnkI6YBkix6hb2nT1bfXEXkcPBXYQj
         jgpdkLfKON1ZRQxHRFRTyaDui1FljdOyvkvYRYwfWXtjJ4O5lq7L4PQeTcGY7hTlsTVe
         JGqOLBA6SdU0ug856x8LzxXGJFxj66bczD17w=
Received: by 10.210.40.10 with SMTP id n10mr7948994ebn.102.1227820208935;
        Thu, 27 Nov 2008 13:10:08 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id i6sm344682gve.2.2008.11.27.13.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 13:10:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101824>


I just implemented a command to give a brief summary
of the patches in the current file.  Please note that
I am just rediscovering perl after having abandoned it
years ago, so any criticism is appreciated. 5 patches
to follow.  (From aa14a0c3f)

Here's a screen shot:


Stage this hunk [y,n,a,l,d,k,K,j,J,e,?]? l
'*' indicates current hunk.  '+' stage, '-' don't stage
  0+: @@ -8,9 +8,9 @@ Aani
  1 : @@ -48,7 +48,7 @@ abandonable
*2 : @@ -88,7 +88,7 @@ abaton
  3 : @@ -128,7 +128,7 @@ abdest
  4-: @@ -81192,9 +81192,9 @@ gyrous
  5 : @@ -234925,7 +234925,7 @@ zymotic
@@ -88,7 +88,7 @@ abaton
  abator
  abattoir
  Abatua
-abature
+agature
  abave
  abaxial
  abaxile




-- 
William Pursell
