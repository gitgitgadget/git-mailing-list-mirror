From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: Why does git-mergetool use /dev/tty?
Date: Tue, 24 Aug 2010 03:04:38 -0400
Message-ID: <4323106E-D314-4644-8203-71CC3811A962@gernhardtsoftware.com>
References: <3D6C7B12-FA06-4EAD-9781-5CA74FE23057@gernhardtsoftware.com> <20100824064306.GA18308@hashpling.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Aug 24 09:04:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnnYw-00021o-M4
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab0HXHEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 03:04:46 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:47266 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab0HXHEp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 03:04:45 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A74771FFC43C; Tue, 24 Aug 2010 07:04:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 524C51FFC43A;
	Tue, 24 Aug 2010 07:04:27 +0000 (UTC)
In-Reply-To: <20100824064306.GA18308@hashpling.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154300>


On Aug 24, 2010, at 2:43 AM, Charles Bailey wrote:

> There's a proposed patch to save and restore the original stdin
> instead of assuming that there is a tty in pu: af314714.
> 
> If the current behaviour is causing an issue for you then testing this
> fix would be appreciated.

The issue was spurious output during tests, which is fixed by af314714.

Thanks for the explanation though, I had missed that it was part of a pipeline.

~~ Brian
