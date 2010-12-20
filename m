From: Adam Monsen <haircut@gmail.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Mon, 20 Dec 2010 19:35:00 +0000 (UTC)
Message-ID: <loom.20101220T203122-271@post.gmane.org>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 20:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUlVy-00073F-0D
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 20:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013Ab0LTTfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 14:35:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:40690 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932730Ab0LTTfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 14:35:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PUlVp-0006zY-8Y
	for git@vger.kernel.org; Mon, 20 Dec 2010 20:35:13 +0100
Received: from c-67-183-136-182.hsd1.wa.comcast.net ([67.183.136.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 20:35:13 +0100
Received: from haircut by c-67-183-136-182.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 20:35:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.183.136.182 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.224 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164009>

Linus Torvalds writes:
> What happened today was that I had been doing a pull or two, and then
> applied an emailed patch with "git am" as usual. But as sometimes
> happens, I actually had a previous "git am" that had failed - in fact,
> it was the same patch that I applied today that had had an earlier
> version that no longer applied.

It would be helpful if "git status" mentioned if a rebase or am operation is in 
progress... this might have helped you avoid the situation described.
