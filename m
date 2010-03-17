From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 17:35:19 +0100
Message-ID: <4BA104C7.5020207@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrwDx-00088Y-KX
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab0CQQf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 12:35:26 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:45278 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab0CQQfX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 12:35:23 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 267C014E418EE;
	Wed, 17 Mar 2010 17:35:21 +0100 (CET)
Received: from [78.48.200.74] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1NrwDI-0004Wg-00; Wed, 17 Mar 2010 17:35:20 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.8) Gecko/20100228 SUSE/3.0.3-1.1.1 Thunderbird/3.0.3
In-Reply-To: <4b8bf32f.0706c00a.26cb.691d@mx.google.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX193ZR5sjO34/N9wkxhpl+gQS7Q8KV/t6VxOhXii
	JuXAY3KuGtq/h9hVOlZdDWBgpQEi9CfaDSnQ6ckZZgJb/8Kt8L
	XdWyr8EusDpQafcsFIFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142411>

>From 828d97e2f50b49c87138f382d579605dc134d8ca Mon Sep 17 00:00:00 2001
From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 17 Mar 2010 17:05:08 +0100
Subject: [PATCH] Documentation: clarification for the command "git checkout <branch>"

The software implementation worked differently in comparison
to the description in the first paragraph. The updated explanation
should reflect the current behaviour.

Signed-off-by: Markus Elfring <Markus.Elfring@web.de>
---

> I think it would be a great contribution if you could clean up
> Junio's explanation and submit a patch that includes it in the
> documentation for "git checkout".

Will the following wording be acceptable?

Regards,
Markus


 Documentation/git-checkout.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..5fcea56 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -15,10 +15,11 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-
-When <paths> are not given, this command switches branches by
-updating the index, working tree, and HEAD to reflect the specified
-branch.
+When <paths> are not given, this command marks the specified branch
+as the next commit target. (The reference "HEAD" points to its tip.)
+Checking out another branch (branch switching) is designed to carry
+your local modifications across with you. The working tree is not
+restored to the state of its last commit.
 
 If `-b` is given, a new branch is created and checked out, as if
 linkgit:git-branch[1] were called; in this case you can
-- 
1.7.0.1
