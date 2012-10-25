From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Use character class for sed expression instead of \s
Date: Thu, 25 Oct 2012 12:00:46 -0400
Message-ID: <C2AB6973-7BC2-45A4-836E-BB1FAAE7501C@gernhardtsoftware.com>
References: <508935CB.9020408@web.de> <1351180699-24695-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: tboegi@web.de, peff@peff.net, bosch@adacore.com,
	git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:01:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRPrf-00070n-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 18:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934783Ab2JYQAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 12:00:47 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44466 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678Ab2JYQAq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 12:00:46 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 2BE2B11711EB; Thu, 25 Oct 2012 16:00:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.104] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 496FF11711EA;
	Thu, 25 Oct 2012 16:00:45 +0000 (UTC)
In-Reply-To: <1351180699-24695-1-git-send-email-bdwalton@gmail.com>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208404>


On Oct 25, 2012, at 11:58 AM, Ben Walton <bdwalton@gmail.com> wrote:

> Sed on Mac OS X doesn't handle \s in a sed expressions so use a more
> portable character set expression instead.
> 
> Signed-off-by: Ben Walton <bdwalton@gmail.com>

Acked-by: Brian Gernhardt <brian@gernhardtsoftware.com>

I have an identical change sitting in my git.git, I've just been too distracted by other things to commit and send it.

~~ Brian Gernhardt
