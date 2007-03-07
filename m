From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 5/6] Fix some "comparison is always true/false" warnings.
Date: Wed, 07 Mar 2007 19:05:49 +0000
Message-ID: <45EF0D0D.4060904@ramsay1.demon.co.uk>
References: <45E9BE69.4070508@ramsay1.demon.co.uk> <20070305074502.GA31507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 21:26:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP2i0-0005oY-GL
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 21:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965625AbXCGUZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Mar 2007 15:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965624AbXCGUZ4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 15:25:56 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:1685 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992539AbXCGUZz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2007 15:25:55 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-34.mail.demon.net with esmtp (Exim 4.42)
	id 1HP2ht-000Gk9-EM; Wed, 07 Mar 2007 20:25:53 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20070305074502.GA31507@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41688>

Karl Hasselstr=F6m wrote:
> On 2007-03-03 18:28:57 +0000, Ramsay Jones wrote:
>=20
>> +typedef unsigned int ucs_char_t;  /* assuming 32bit int */
>=20
> Umm ... wouldn't an uint32_t be a better fit here?
>=20

Yes, but I did not want to add a dependency on a C99 header
(i.e. <stdint.h>). I had a vague recollection that Linus had
stated that git was probably broken if int wasn't 32 bits, so ...

This was before I realized that a recent change to git meant
that git was already including C99 headers <inttypes.h> and,
therefore indirectly, <stdint.h>.

So, if it is OK to depend on those headers, then an uin32_t may
indeed be a better fit.

All the best,

Ramsay Jones
