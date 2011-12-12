From: Stephen Bash <bash@genarts.com>
Subject: Git blame only current branch
Date: Mon, 12 Dec 2011 10:24:47 -0500 (EST)
Message-ID: <d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 16:24:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra7kN-0002Dh-R3
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 16:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab1LLPYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 10:24:51 -0500
Received: from hq.genarts.com ([173.9.65.1]:19655 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751062Ab1LLPYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 10:24:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 37004BEACB9
	for <git@vger.kernel.org>; Mon, 12 Dec 2011 10:24:53 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N-GfbVrppQCC for <git@vger.kernel.org>;
	Mon, 12 Dec 2011 10:24:47 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 63623BEAC9B
	for <git@vger.kernel.org>; Mon, 12 Dec 2011 10:24:47 -0500 (EST)
In-Reply-To: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC15 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186913>

Hi all-

I'm curious if there's a method to make git blame merge commits that introduce code to the given branch rather than commits on the original (topic) branch?  For example:

  A--B--C---M--D  master
   \       /
    1--2--3       topicA

I'd like a mode where 'git blame master ...' shows commit M for lines changed by topicA so I can easily do 'git blame M^ ...' to see changes (on master) prior to the merge of topicA.  Unfortunately 'git blame master ^topicA ...' blames all the changes of topicA to 3 (which reading the docs appears to be the "correct" behavior).

Thanks!

Stephen
