From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] clone: allow initial sparse checkouts
Date: Mon, 24 Feb 2014 21:48:01 +0000
Message-ID: <robbat2-20140224T214733-300290109Z@orbis-terrarum.net>
References: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
 <CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com>
 <robbat2-20140223T072340-334493350Z@orbis-terrarum.net>
 <CACsJy8ApmVPAnhQmVAsFyXtV49S+9VULsEYZ7W3x7HMMoVtDzA@mail.gmail.com>
 <robbat2-20140223T204934-225383635Z@orbis-terrarum.net>
 <xmqqzjlg9zdn.fsf@gitster.dls.corp.google.com>
Reply-To: Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 24 22:48:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI3Nh-0006Ee-MG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 22:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbaBXVsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 16:48:05 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:47152 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbaBXVsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 16:48:04 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 6310133F8B6
	for <git@vger.kernel.org>; Mon, 24 Feb 2014 21:48:03 +0000 (UTC)
Received: (qmail 18262 invoked by uid 10000); 24 Feb 2014 21:48:01 -0000
Content-Disposition: inline
In-Reply-To: <xmqqzjlg9zdn.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242650>

On Mon, Feb 24, 2014 at 09:47:16AM -0800,  Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> > The only other clean alternative would be implementing ONLY
> > --sparse-checkout-from, and letting uses use fds creatively:
> > --sparse-checkout-from <(echo X; echo Y)
> Not all POSIX shells have such an abomination that is process
> substitution.  You can easily work it around by adopting the usual
> convention to use "-" to read from the standasrd input, though.
> 
> 	(echo X; echo Y) | cmd --sparse-checkout-from -
Is that a vote that you'd like to see a --sparse-checkout-from variant
of my patch?

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
