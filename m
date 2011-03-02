From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 7/7] fetch/pull: Describe --recurse-submodule restrictions
 in the BUGS section
Date: Wed, 02 Mar 2011 21:53:19 +0100
Message-ID: <4D6EAE3F.9070202@web.de>
References: <4D6D7A50.5090802@web.de> <4D6D7B8D.3020409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 21:53:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Put3T-0000IJ-B8
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 21:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab1CBUxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 15:53:49 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:38722 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab1CBUxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 15:53:49 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id 194D61898530F;
	Wed,  2 Mar 2011 21:53:20 +0100 (CET)
Received: from [93.240.114.148] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Put2t-0002w1-00; Wed, 02 Mar 2011 21:53:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6D7B8D.3020409@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Jja+PINtLqaHklgawCUNgXINcORE718hMmTPo
	bHTwXrtM0yP3mraANpN4XjFkdzzEa7Kgann2+xR5NEAcm6JNdi
	ERe8ewjCqDzHLCa4aSdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168340>

Am 02.03.2011 00:04, schrieb Jens Lehmann:
> Using the --recurse-submodules option with fetch and pull might not always
> fetch all the submodule commits the user expects, as this will only work
> when the submodule is already checked out. Document that and warn that
> this is expected to change in the future.

This patch needs the following diff to get rid of some typos. Will be
fixed in v3.

--------8<--------
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index f907ef5..8669227 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -78,10 +78,10 @@ because it is prefixed with a plus sign; `tmp` will not be.

 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in alrady checked
+Using --recurse-submodules can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself can not be
-fetched, making it impossible to check out that submodule later whithout
+fetched, making it impossible to check out that submodule later without
 having to do a fetch again. This is expected to be fixed in a future git
 version.

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 1596d2b..1aad8bf 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -222,10 +222,10 @@ would want to start over, you can recover with 'git reset'

 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in alrady checked
+Using --recurse-submodules can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself can not be
-fetched, making it impossible to check out that submodule later whithout
+fetched, making it impossible to check out that submodule later without
 having to do a fetch again. This is expected to be fixed in a future git
 version.
