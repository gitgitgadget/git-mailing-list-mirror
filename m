From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Mark and protect local commits?
Date: Mon, 09 Jan 2012 09:29:04 +0100
Message-ID: <jee8ii$6ft$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 09:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkAcg-0006b2-Ti
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 09:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab2AIIaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 03:30:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:57406 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232Ab2AIIaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 03:30:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RkAcZ-0006X1-2a
	for git@vger.kernel.org; Mon, 09 Jan 2012 09:30:23 +0100
Received: from 93.92.134.38 ([93.92.134.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 09:30:23 +0100
Received: from norbert.nemec by 93.92.134.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 09:30:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 93.92.134.38
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188160>

Hi there,

I have often wished that there were ways to

a) protect certain commits from leaving the local repository

b) mark commits that have already left the local repository


To be more specific:

a) Sometimes, I try out certain experimental features and want to make 
sure they don't accidentally end up out in the wild. If there were a 
flag to explicitly mark them "private", any non-local operation (push, 
pull, etc) on these commits could create an error message.

b) For history-rewriting operations, it is important to know which 
commits are out in the wild and which are not. In a "push"-setup working 
copy, git should be able to keep track of this. Any newly created commit 
would be marked as "unpublished" and the mark would be removed when the 
commit is pushed. Any history-rewriting would be prevented on published 
commits.


Has anyone else thought along these lines?

Greetings,
Norbert
