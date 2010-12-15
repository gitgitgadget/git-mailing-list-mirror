From: Scott Johnson <scottj75074@yahoo.com>
Subject: html userdiff is not showing all my changes
Date: Tue, 14 Dec 2010 19:47:12 -0800 (PST)
Message-ID: <561247.22837.qm@web110707.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Wed Dec 15 04:47:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSiKn-00016Q-1N
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 04:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759328Ab0LODrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 22:47:15 -0500
Received: from nm4.bullet.mail.ne1.yahoo.com ([98.138.90.67]:30737 "HELO
	nm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753198Ab0LODrO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 22:47:14 -0500
Received: from [98.138.90.54] by nm4.bullet.mail.ne1.yahoo.com with NNFMP; 15 Dec 2010 03:47:13 -0000
Received: from [98.138.89.165] by tm7.bullet.mail.ne1.yahoo.com with NNFMP; 15 Dec 2010 03:47:13 -0000
Received: from [127.0.0.1] by omp1021.mail.ne1.yahoo.com with NNFMP; 15 Dec 2010 03:47:13 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 271553.44557.bm@omp1021.mail.ne1.yahoo.com
Received: (qmail 22844 invoked by uid 60001); 15 Dec 2010 03:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1292384832; bh=//6/vudR7mrH/1F1F4K2caMeHHdNK3Hrk2A/1ICRJAs=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=Uws2vPm4qoJy50Gy+7j1KS65l8gQC88ZfLtu8l0xfSbZ5GPCjmQ6MxYx2EIR5cWrVcV4Ce32ub3pTxGSOAVR4Qwy5vczxKI5HnfQsh7uM7GzpygZcbuNb+SiX3/KY3QwMzJRHnx3xIbUJ0Bt+34PlrfrFn4KZwJaWZTERehNc8g=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=SySZcaxmzAmobzO+W8ZJYrd7NMyrpZNTJVvrCeGQ8uaWceY0iEXhI0TrWGZasdjtnftif8vGYOHoCurVFsaUyfEjvFsM17Fo7kWPYOPq4NnLiOB8gRsXwFv+f1GPHuQpN60+0MA617VLLdKdBLz43s54TUVxd27bqz5IfzBNBFY=;
X-YMail-OSG: 2njUMl0VM1mK_iEi0kD._PB59e4iLeuaFaJe3uSCDejH5at
 o44v2J_Un0sUcplJyi71bbPyUVGrfqpuZCL1jW565FzsE6qgcNFYRAEtAGd8
 X0X6ndRQaP8azOD.Ljcsjf2iXcalqzr1YV4Q0LSnCCcplfHASw9K_CH9507w
 kBAXbzx14dH3EjyNvqCFtsFD.7aRfqqi3miEC7BDZVVht0ckXN5AA10ldCZs
 9WdZThwc1.7CUIGmylW9DfP8qpA5N.bWC8lBY9U9iitgcEJJnolgtWjO48o7
 g6lX2S90kV1CsWKlJCa_UhkxqJtLbdxJNNz4u9WziEoSfbQbUKRkXz5tU89A
 ge.rkgFWyaYW6QodN_E4Zw0PkK8zTPdlcCekx.bVG6CkrcTpgGFG4BNxZvLp
 RC4mkj_G_GpE-
Received: from [99.189.91.206] by web110707.mail.gq1.yahoo.com via HTTP; Tue, 14 Dec 2010 19:47:12 PST
X-Mailer: YahooMailRC/553 YahooMailWebService/0.8.107.285259
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163732>

I am attempting to do a word diff of an html source file. Part of the removed 
html is disappearing from the diff when I enable the fancy html word diff.

Here's the output from basic `git diff`:
diff --git a/adv_layout_source.html b/adv_layout_source.html
index 18a81dd..c4ed609 100644
--- a/adv_layout_source.html
+++ b/adv_layout_source.html
@@ -42,8 +42,8 @@
       <ul>
         <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
         <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
-        <li class="yws-maps"><em></em><a href="#">yws-maps</a></li>
-        <li class="ydn-delicious"><em></em><a href="#">ydn-delicious</a></li>
+        <li><em></em><a href="#">yws-maps</a></li>
+        <li><em></em><a href="#">ydn-delicious</a></li>
         <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
         <li class="yws-events"><em></em><a href="#">yws-events</a></li>
       </ul>


Here's the default `git diff --word-diff`:
diff --git a/adv_layout_source.html b/adv_layout_source.html
index 18a81dd..c4ed609 100644
--- a/adv_layout_source.html
+++ b/adv_layout_source.html
@@ -42,8 +42,8 @@
      <ul>
        <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
        <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
        [-<li class="yws-maps"><em></em><a-]{+<li><em></em><a+} 
href="#">yws-maps</a></li>
        [-<li class="ydn-delicious"><em></em><a-]{+<li><em></em><a+} 
href="#">ydn-delicious</a></li>
        <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
        <li class="yws-events"><em></em><a href="#">yws-events</a></li>
      </ul>

Which is correct, but less than ideal because it highlights much more than the 
actual changes.

So I create a .gitattributes file with one line:
*.html diff=html

And rerun `git diff --word-diff`:
diff --git a/adv_layout_source.html b/adv_layout_source.html
index 18a81dd..c4ed609 100644
--- a/adv_layout_source.html
+++ b/adv_layout_source.html
@@ -42,8 +42,8 @@
      <ul>
        <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
        <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
        <li[-class="yws-maps"-]><em></em><a href="#">yws-maps</a></li>
        <li><em></em><a href="#">ydn-delicious</a></li>
        <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
        <li class="yws-events"><em></em><a href="#">yws-events</a></li>
      </ul>

Yikes! What happened to the second line of changes? The removed code is not 
displayed at all.

This is running git 1.7.3.3.

I suspect the problem is in the html patterns in userdiff.c, but I don't 
understand the word-diff-regex well enough to fix it.
