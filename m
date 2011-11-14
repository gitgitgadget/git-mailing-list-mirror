From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Mon, 14 Nov 2011 13:48:51 +0100
Message-ID: <20111114124851.GB21854@victor>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
 <20111113182757.GA15194@elie.hsd1.il.comcast.net>
 <20111114113235.GE10847@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	vinassa vinassa <vinassa.vinassa@gmail.com>,
	git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 14 13:49:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPvyG-0002x7-I3
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 13:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab1KNMtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 07:49:03 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:47096 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab1KNMtD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 07:49:03 -0500
Mail-Followup-To: Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	vinassa vinassa <vinassa.vinassa@gmail.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Content-Disposition: inline
In-Reply-To: <20111114113235.GE10847@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185382>

On Mon, Nov 14, 2011 at 06:32:35AM -0500, Jeff King wrote:
> On Sun, Nov 13, 2011 at 12:27:57PM -0600, Jonathan Nieder wrote:
> 
> > Though I haven't tested.  It would be nice to have an md5git (or even
> > truncated-sha1-git) program to test this kind of thing with.
> 
> Fortunately we have such a thing:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/184243
> 
> That one actually has 40 bits of hash entropy, so you'd expect to
> generate 2^20 (about a million) commits before accidentally colliding.
> If you want an easier experiment, you could truncate it even further.

Would it be helpful to truncate this to something ludicrous like a
single byte of entropy, to be able to write tests for the various tools
and options?

Cheers,
V

-- 
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
