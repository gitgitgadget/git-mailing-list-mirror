From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC PATCH] repack: make repack -a equivalent to repack -A and
	drop previous -a behavior
Date: Fri, 14 Nov 2008 02:48:28 +0100
Message-ID: <20081114014828.GD5285@atjola.homenet>
References: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil> <20081114000219.GB5285@atjola.homenet> <jKWdt94ZxgNW0UAgUUW-qjTtpWohpQXMfvw-AUmOXND8SD5yFw0N8w@cipher.nrlssc.navy.mil> <20081114012502.GC5285@atjola.homenet> <Dei99j9xFoGAh0A3LCO0zx3LqCb4lViSZpGvv_KGn38@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 02:49:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0noi-0004k0-Rs
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 02:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYKNBsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 20:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYKNBsd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 20:48:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:36355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751160AbYKNBsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 20:48:32 -0500
Received: (qmail invoked by alias); 14 Nov 2008 01:48:30 -0000
Received: from i577B96AD.versanet.de (EHLO atjola.local) [87.123.150.173]
  by mail.gmx.net (mp039) with SMTP; 14 Nov 2008 02:48:30 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/uM1cXJVDuc6yuU+CDbIfecQbNnowsyUWnxzKCZS
	t5uxZJ50pR3t9d
Content-Disposition: inline
In-Reply-To: <Dei99j9xFoGAh0A3LCO0zx3LqCb4lViSZpGvv_KGn38@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100945>

On 2008.11.13 19:36:45 -0600, Brandon Casey wrote:
> Bj=F6rn Steinbrink wrote:
> > On 2008.11.13 18:53:29 -0600, Brandon Casey wrote:
> >> Bj=F6rn Steinbrink wrote:
> >>> We have:
> >>> 	-a	Create a new pack, containing all reachable objects
> >>> 	-A	Same as -a
> >>> 	-ad	Same as -a, and drop all old packs and loose objects
> >> by loose objects, I assume you mean packed unreachable objects.
> >=20
> > No, actually I just totally ignored the fact that -a of course alre=
ady
> > deletes the loose objects.
>=20
> Actually, I had forgotten that repack deletes any loose objects at al=
l.
> It does call prune-packed, but only when -d is used.

Ugh, right. -a does not delete loose objects without -d. So, ignoring
the .keep stuff, my initial description was even right and I just
confused myself afterwards :-/

Thanks,
Bj=F6rn
