From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 10:35:36 -0400
Message-ID: <20080314143536.GA5362@coredump.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <20080313170016.GA3439@sigill.intra.peff.net> <2008-03-13-18-14-36+trackit+sam@rfc1149.net> <20080314132949.GC2932@coredump.intra.peff.net> <2008-03-14-14-40-22+trackit+sam@rfc1149.net> <20080314134600.GA3968@coredump.intra.peff.net> <2008-03-14-14-50-48+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 15:36:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaB1A-0007if-H5
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 15:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbYCNOfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 10:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbYCNOfj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 10:35:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1787 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbYCNOfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 10:35:38 -0400
Received: (qmail 5011 invoked by uid 111); 14 Mar 2008 14:35:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 10:35:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 10:35:36 -0400
Content-Disposition: inline
In-Reply-To: <2008-03-14-14-50-48+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77230>

On Fri, Mar 14, 2008 at 02:50:48PM +0100, Samuel Tardieu wrote:

> | Yes, it works fine for me:
> 
> Ahhhhh, found it. It looks like you have no format.headers configuration
> variable, do you?

No, I don't. Having peeked a few days ago at the pretty-printing code,
that is almost certainly the problem (I think the extra_headers
parameter is overloaded to handle both of these conditions). Can you
work up a patch?

-Peff
