From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] t7610: cd inside subshell instead of around
Date: Mon, 23 Aug 2010 23:51:22 -0400
Message-ID: <432D99EA-303B-4201-9B07-7694800B4580@gernhardtsoftware.com>
References: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com> <20100824030524.GF17406@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 05:51:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnkXu-0002TH-Gi
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 05:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab0HXDv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 23:51:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43167 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab0HXDv0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 23:51:26 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 449521FFC43C; Tue, 24 Aug 2010 03:51:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C0BB31FFC43A;
	Tue, 24 Aug 2010 03:51:13 +0000 (UTC)
In-Reply-To: <20100824030524.GF17406@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154282>


On Aug 23, 2010, at 11:05 PM, Jonathan Nieder wrote:

> While we're looking at this test script, some more nitpicks for
> squashing in. :)
> 
> -- 8< --
> Subject: t7610 (mergetool): more nitpicks
> 
> - use tabs to indent
> - do not redirect output away unnecessarily
> - avoid a subshell for 'yes "" | git mergetool file3'
> - use test_tick for reproducible, increasing timestamps
> - use test_cmp instead of 'test $foo = bar'; the former is much
>   nicer to debug with --verbose since it produces a diff.

Fair enough.  I just took a stab at the bit that irritated me the most.  Thanks for cleaning up the rest.

~~ Brian
