From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 14:08:49 -0400
Message-ID: <1B9251F9-C1AF-41F7-8BF8-D36DDB27EF09@gernhardtsoftware.com>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com> <20130621043052.GA5318@sigill.intra.peff.net> <20130621044236.GA5798@sigill.intra.peff.net> <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com> <20130621044953.GA5962@sigill.intra.peff.net> <D0852D0F-3282-41DF-8A5A-4BEF1B39ED66@gernhardtsoftware.com> <20130621180334.GA4499@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:08:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq5lY-0000eT-EI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423513Ab3FUSIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:08:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56306 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423488Ab3FUSIv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 14:08:51 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id D54F32736300; Fri, 21 Jun 2013 18:08:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id AB62027362F7;
	Fri, 21 Jun 2013 18:08:49 +0000 (UTC)
In-Reply-To: <20130621180334.GA4499@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228639>


On Jun 21, 2013, at 2:03 PM, Jeff King <peff@peff.net> wrote:

> IfVersion comes from mod_version. I assume that if it were not loaded,
> apache would complain about the directive entirely. But it's true that
> we don't load it until later. Maybe try moving the IfVersion/Lockfile
> stanza down below the mod_version LoadModule line?

Apache is apparently overly accepting.  Moving the IfVersion below all the IfModules fixes it.

~~ Brian
