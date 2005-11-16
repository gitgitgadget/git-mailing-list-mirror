From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Deprecate --cache.* ?
Date: Wed, 16 Nov 2005 10:18:18 +0100
Message-ID: <200511161018.19374.Josef.Weidendorfer@gmx.de>
References: <437A5F08.7020908@etek.chalmers.se> <7vsltxazyf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Nov 16 10:18:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcJR9-0008Ae-Uj
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 10:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVKPJSX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 04:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVKPJSX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 04:18:23 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:39628 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030256AbVKPJSW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 04:18:22 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 2C52C950
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 10:18:21 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vsltxazyf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12014>

On Wednesday 16 November 2005 07:06, Junio C Hamano wrote:
> Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:
>=20
> > Backward compability could be ensured by having both versions of th=
e flags
> > around for a while and issuing a warning when the old form is used.
> >
> > Good idea? Bad? Stupid? Do we want to keep "cache" around?
>=20
> I agree that may be a logical move, with proper b/c slack, but I
> am not _so_ enthused about this...

Probably, as your fingers are trained. I just tried it to write 10
times as fast as possible: cache, and afterwards index; and writing
cache *is* faster ;-)

But for someone new to git, these options must be totally confusing
and coming out of nowhere. Not that I use these often - I am a
Cogito user.

Practically, the opinion of people using these options often should
count, as it will be inconvenient for them. Rare users can look up
the man page.

Josef
