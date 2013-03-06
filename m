From: Jeff King <peff@peff.net>
Subject: Re: auto merge bug
Date: Wed, 6 Mar 2013 04:15:15 -0500
Message-ID: <20130306091515.GC2018@sigill.intra.peff.net>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
 <20130305090326.GC13552@sigill.intra.peff.net>
 <7vtxopvoky.fsf@alter.siamese.dyndns.org>
 <20130305175904.GC9379@sigill.intra.peff.net>
 <7va9qhu1jk.fsf@alter.siamese.dyndns.org>
 <194F685F-9460-42C6-B5A5-59475F53D038@gmail.com>
 <CAOFaZ+4oUD7eMvFmtPdca4AYooxW-PCOiPBUb0jjVw4LPBN8+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Krmpotic <david.krmpotic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 10:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDARv-0002kD-D2
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 10:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab3CFJPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 04:15:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37915 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab3CFJPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 04:15:18 -0500
Received: (qmail 23856 invoked by uid 107); 6 Mar 2013 09:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 04:16:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 04:15:15 -0500
Content-Disposition: inline
In-Reply-To: <CAOFaZ+4oUD7eMvFmtPdca4AYooxW-PCOiPBUb0jjVw4LPBN8+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217508>

On Tue, Mar 05, 2013 at 11:13:12PM +0100, David Krmpotic wrote:

> Hi guys! Thank you for responses.. I haven't suspected that repos
> created via GitHub windows app would have union set by default :( hav=
e
> to ask them about it.. it seems wrong to me=E2=80=A6 Here are the def=
aults for
> a windows repo created with GitHub for windows app:
> [...]
> # Custom for Visual Studio
> *.cs     diff=3Dcsharp
> *.sln    merge=3Dunion
> *.csproj merge=3Dunion
> *.vbproj merge=3Dunion
> *.fsproj merge=3Dunion
> *.dbproj merge=3Dunion

Yeah, I think defaulting to merge=3Dunion there is questionable. In an
ideal world, the GitHub for Windows folks would ship a specialized merg=
e
helper for handling VS project files. It can be open-source and
distributed separately for people who don't use GitHub, but they can
integrate it seamlessly into the GitHub client. So everybody wins.

I see you've already written to GitHub support; thanks. I'll make sure
your issue gets routed to the right people, and I'll see if I can
convince them to write the specialized tool. :)

-Peff
