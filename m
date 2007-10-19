From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 23:58:38 -0400
Message-ID: <20071019035838.GB18717@coredump.intra.peff.net>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <C5184350-51A7-46B4-B0C9-E32F79214546@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iij0h-0004QH-EE
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966533AbXJSD6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966512AbXJSD6m
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:58:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2876 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966425AbXJSD6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:58:40 -0400
Received: (qmail 8898 invoked by uid 111); 19 Oct 2007 03:58:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:58:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:58:38 -0400
Content-Disposition: inline
In-Reply-To: <C5184350-51A7-46B4-B0C9-E32F79214546@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61643>

On Thu, Oct 18, 2007 at 11:53:05PM -0400, Michael Witten wrote:

>>   3. You don't want to commit your changes, so you git-mv in the index
>>      only without involving your dirty working tree file.
> That's exactly what the original poster wanted.
>
> It's not unreasonable.

I guess. I really think git-stash is your friend here. But you can still
do step (3) with git-update-index (I'll leave the exact details as an
exercise for the reader).

-Peff
