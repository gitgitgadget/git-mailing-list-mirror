From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 08:15:16 +0100
Message-ID: <20121120071516.GA7206@shrek.podlesie.net>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
 <7vhaoluos6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 08:15:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tai3T-0004xK-LT
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 08:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab2KTHPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 02:15:20 -0500
Received: from [93.179.225.50] ([93.179.225.50]:45175 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab2KTHPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 02:15:19 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id C1690752; Tue, 20 Nov 2012 08:15:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhaoluos6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210082>

On Mon, Nov 19, 2012 at 04:00:09PM -0800, Junio C Hamano wrote:
> Krzysztof Mazur <krzysiek@podlesie.net> writes:
> 
> > On Mon, Nov 19, 2012 at 11:27:45AM -0800, Junio C Hamano wrote:
> >> Given that the problematic line
> >> 
> >> 	Stable Kernel Maintainance Track <stable@vger.kernel.org> # vX.Y
> >> 
> >> is not even a valid e-mail address, doesn't this new logic belong to
> >> sanitize_address() conceptually?
> >
> > Yes, it's much better to do it in the sanitize_address().
> 
> Note that I did not check that all the addresses that are handled by
> extract-valid-address came through sanitize-address function, so

Before sending that patch, I checked that and tested with and without
Email::Valid.

> unlike your original patch, this change alone may still pass some
> garbage to Email::Valid->address().  I tend to think that is a
> progress; we should make sure all the addresses are sanitized before
> using them for sending messages out.

I will try to check that.

Krzysiek
