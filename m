From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 18:21:08 +0200
Message-ID: <200705151821.08568.kumbayo84@arcor.de>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Karl =?iso-8859-1?q?Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 18:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnzm8-0001TC-D2
	for gcvg-git@gmane.org; Tue, 15 May 2007 18:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbXEOQVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 12:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756095AbXEOQVT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 12:21:19 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:55522 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753678AbXEOQVS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 12:21:18 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 2A35E3727CD;
	Tue, 15 May 2007 18:21:10 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 02F1C1B8E86;
	Tue, 15 May 2007 18:21:09 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 11ACC19B330;
	Tue, 15 May 2007 18:21:01 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47355>

On Tuesday 15 May 2007 17:56, Catalin Marinas wrote:
> On 06/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > The name of the current patch, if any, is always the last line of
> > patches/<branch>/applied (and there is no current patch if and only=
 if
> > the "applied" file is empty). So use that instead, and stop having =
to
> > worry about keeping the redundant "current" file up-to-date.
>=20
> I applied this patch. Could you also send me a patch for the
> bash-completion script as it uses this file?
>=20
> I think the self.__current_file (same for the base file removed in a
> different patch) should still be available in the Series object and
> removed when deleting a branch, otherwise you get a "Series directory
> ... is not empty" exception.
>=20
> Thanks.
>=20
Hi,
this is a bit OT,
but when i wanted to try out this changes i found that 2 unrelated patc=
hes in you repo[1] are empty.
* Store branch description in the config file=20
* Make the "name" argument to "stg new" optional

Is that a problem on my side, or are they really empty?

Greetings Peter

[1] http://homepage.ntlworld.com/cmarinas/stgit.git
which is mirrored at
http://repo.or.cz/w/stgit.git
