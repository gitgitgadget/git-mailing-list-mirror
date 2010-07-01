From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more
	gradually
Date: Thu, 1 Jul 2010 20:57:12 +0200
Message-ID: <20100701185712.GA22421@pvv.org>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com> <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com> <4C2C6BC5.1030905@viscovery.net> <7v630z41ao.fsf@alter.siamese.dyndns.org> <D2F8C67C-F7AE-4523-870F-879B741C2591@gmail.com> <m3iq4znnfr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.orgList" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 20:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUOx2-0001Ss-RY
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 20:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab0GAS5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 14:57:23 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:44553 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab0GAS5W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 14:57:22 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OUOwi-0005qP-HU; Thu, 01 Jul 2010 20:57:12 +0200
Content-Disposition: inline
In-Reply-To: <m3iq4znnfr.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150062>

On Thu, Jul 01, 2010 at 10:05:17AM -0700, Jakub Narebski wrote:
> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> > On 1. juli 2010, at 18:25, Junio C Hamano <gitster@pobox.com> wrote:
> > > Johannes Sixt <j.sixt@viscovery.net> writes:
> > >> Am 7/1/2010 11:09, schrieb Eyvind Bernhardsen:
> >>>
> >>>> +core.mergePrefilter::
> [...]
> >> 
> >> Somehow to me "prefilter" does not sound to convey what really is going on
> >> here, though.
> > 
> > "Doubleconvert" doesn't really mean anything either though, and
> > "convert" and "normalise" are too generic. I think the problem is
> > that there's no existing name for what convert.c does.
> > 
> > I chose "filter" because of the filter property; the crlf and ident
> > things can be regarded as built-in filters.  -- Eyvind
> 
> What about `merge.renormalize' ;-) ?

Best so far! Or what about "merge.canonicalize"? Sorry for bikeshedding :)

- Finn Arne
