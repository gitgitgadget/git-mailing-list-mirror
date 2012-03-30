From: Rodrigo Silva <linux@rodrigosilva.com>
Subject: Bug#666250: [PATCH] Documentation: replace 'vi' for 'editor' to  reflect build-time option
Date: Fri, 30 Mar 2012 07:33:21 -0300
Message-ID: <BuLHbqo4rrB.A.lMC.A5YdPB@liszt>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
 <7v398qq1ei.fsf@alter.siamese.dyndns.org>
Reply-To: Rodrigo Silva <linux@rodrigosilva.com>, 666250@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,666250@bugs.debian.org,
 git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,Jonathan Nieder <jrnieder@gmail.com>
X-From: bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org Fri Mar 30 12:42:38 2012
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Envelope-to: glddb-debian-bugs-dist@m.gmane.org
Received: from liszt.debian.org ([82.195.75.100])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>)
	id 1SDZHw-0004YY-RS
	for glddb-debian-bugs-dist@m.gmane.org; Fri, 30 Mar 2012 12:42:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id 6F58713A706D; Fri, 30 Mar 2012 10:43:12 +0000 (UTC)
Old-Return-Path: <debbugs@busoni.debian.org>
X-Original-To: lists-debian-bugs-dist@liszt.debian.org
Delivered-To: lists-debian-bugs-dist@liszt.debian.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id 528DC13A706E
	for <lists-debian-bugs-dist@liszt.debian.org>; Fri, 30 Mar 2012 10:43:12 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank bug
X-Spam-Flag: NO
X-Spam-Score: -6.598
X-Spam-Level: 
X-Spam-Status: No, score=-6.598 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2.599, MISSING_MID=0.001, RCVD_IN_DNSWL_MED=-4]
	autolearn=unavailable
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id WlpJiGJRNW98
	for <lists-debian-bugs-dist@liszt.debian.org>;
	Fri, 30 Mar 2012 10:43:03 +0000 (UTC)
Received: from busoni.debian.org (busoni.debian.org [140.211.15.34])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by liszt.debian.org (Postfix) with ESMTPS id 4F21013A5B57;
	Fri, 30 Mar 2012 10:43:03 +0000 (UTC)
Received: from debbugs by busoni.debian.org with local (Exim 4.72)
	(envelope-from <debbugs@busoni.debian.org>)
	id 1SDZHc-0000Wn-N0; Fri, 30 Mar 2012 10:42:17 +0000
X-Loop: owner@bugs.debian.org
Resent-From: Rodrigo Silva <linux@rodrigosilva.com>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Gerrit Pape <pape@smarden.org>
X-Loop: owner@bugs.debian.org
Resent-Date: Fri, 30 Mar 2012 10:42:15 +0000
Resent-Message-ID: <handler.666250.B666250.1333104019896@bugs.debian.org>
X-Debian-PR-Message: followup 666250
X-Debian-PR-Package: git-man
X-Debian-PR-Keywords: upstream patch
X-Debian-PR-Source: git
Received: via spool by 666250-submit@bugs.debian.org id=B666250.1333104019896
          (code B ref 666250); Fri, 30 Mar 2012 10:42:15 +0000
Received: (at 666250) by bugs.debian.org; 30 Mar 2012 10:40:19 +0000
X-Spam-Bayes: score:0.0000 Tokens: new, 25; hammy, 149; neutral, 170; spammy,
	2. spammytokens:0.999-1--H*r:5713, 0.987-1--H*Ad:U*bwalton
	hammytokens:0.000-+--UD:kernel.org, 0.000-+--100644, 0.000-+--sk:jrniede,
	0.000-+--U*jrnieder, 0.000-+--jrniedergmailcom
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107])
	by busoni.debian.org with smtp (Exim 4.72)
	(envelope-from <linux@rodrigosilva.com>)
	id 1SDZFg-0000Dp-GR
	for 666250@bugs.debian.org; Fri, 30 Mar 2012 10:40:18 +0000
Received: (qmail 5713 invoked from network); 30 Mar 2012 10:33:26 -0000
Received: from unknown (186.221.213.231)
  by p3plsmtpa08-06.prod.phx3.secureserver.net (173.201.193.107) with ESMTP; 30 Mar 2012 10:33:25 -0000
X-Mailer: QUALCOMM Windows Eudora Version 7.1.0.9
In-Reply-To: <7v398qq1ei.fsf@alter.siamese.dyndns.org>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
 <7v398qq1ei.fsf@alter.siamese.dyndns.org>
X-Debian-Message: from BTS
X-Mailing-List: <debian-bugs-dist@lists.debian.org> archive/latest/851301
X-Loop: debian-bugs-dist@lists.debian.org
List-Id: <debian-bugs-dist.lists.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-bugs-dist-request@lists.debian.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194345>

At 23:16 29/3/2012, Junio C Hamano wrote:
>Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Filling in the blank at compile time would be possible, but I'm not
>> convinced it's a good idea.  Wouldn't the same user be just as puzzled
>> when
>>
>>   http://git.kernel.org/?p=git/git-htmldocs.git;a=blob_plain;f=git-var.html
>>
>> (or whatever page with a nicer URL arises to replace the old
>> www.kernel.org/...  pages) says the fallback is 'vi' and git behaves
>> differently?
>
>I've already rejected this patch once, but that was primarily because the
>patch was not justified with the above "I read everybody else's git uses
>'vi' on the Interweb, and even though my distro's manual page says it uses
>'nano', I didn't bother to read it." scenario.

@Jonathan: I'm really sorry for this confusion... I forgot to mention this issue WAS taken to upstream already, and it was rejected because build-time options should be documented by whoever did the changes. So in this case, it's Debian's task to update their man pags to reflect their build-time changes. Junio suggested me to send this patch to Debian, that's why I filled the bug in Debian BTS. It was meant to be a Debian-only patch.

So upstream git man would still say "... and finally 'vi'", since this is upstream default, and Debian would read "... and finally 'editor'", since this is the default set by Debian at build-time. For reference, the original patch included this change, among others:

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 5317cc2..9c49163 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -43,7 +43,8 @@ GIT_EDITOR::
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
     --nofork`.  The order of preference is the `$GIT_EDITOR`
     environment variable, then `core.editor` configuration, then
-    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
+    `$VISUAL`, then `$EDITOR`, and then finally a hardcoded fallback
+    editor set at build time, by default 'vi'.
 
 GIT_PAGER::
     Text viewer for use by git commands (e.g., 'less').  The value

The other changes were fully accepted upstream, this one was rejected. So I modified it to Debian's scenario and filled the bug in BTS.

Since this is meant for Debian, no need to be generic about the "fallback editor set at build time": Debian uses 'editor', so 'editor' should be explicitly mentioned to correctly reflect git's behavior on a Debian system.

@Junio, I'm really sorry for indirectly bringing this up twice to your attention. I've never expected Debian maitainers to be so resposinve, it was awesome fast by reading, analysing and forwarding upstream in a matter of hours. I'm impressed (and embarasssed by this confusion)

MestreLion
