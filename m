From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 5/6] Fix some "comparison is always true/false" warnings.
Date: Thu, 8 Mar 2007 07:45:34 +0100
Message-ID: <20070308064534.GA5981@diana.vm.bytemark.co.uk>
References: <45E9BE69.4070508@ramsay1.demon.co.uk> <20070305074502.GA31507@diana.vm.bytemark.co.uk> <45EF0D0D.4060904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 08 07:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPCNl-0003os-4H
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 07:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbXCHGpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Mar 2007 01:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbXCHGpl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 01:45:41 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1591 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502AbXCHGpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 01:45:41 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HPCNa-0001bl-00; Thu, 08 Mar 2007 06:45:34 +0000
Content-Disposition: inline
In-Reply-To: <45EF0D0D.4060904@ramsay1.demon.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41714>

On 2007-03-07 19:05:49 +0000, Ramsay Jones wrote:

> Karl Hasselstr=F6m wrote:
>
> > Umm ... wouldn't an uint32_t be a better fit here?
>
> Yes, but I did not want to add a dependency on a C99 header (i.e.
> <stdint.h>). I had a vague recollection that Linus had stated that
> git was probably broken if int wasn't 32 bits, so ...
>
> This was before I realized that a recent change to git meant that
> git was already including C99 headers <inttypes.h> and, therefore
> indirectly, <stdint.h>.

Your approach is much more sophisticated than mine. :-) I just
thought, "wow, this _screams_ for a uint32_t -- hmm, is it OK to use
that?", and then did "git grep uint32_t" and got about a screenful of
hits.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
