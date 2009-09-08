From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 5/6 (v4)] full integration of rev-cache into git, 
	completed test suite
Date: Wed, 9 Sep 2009 00:24:22 +0200
Message-ID: <c77435a80909081524i493603efhb32dee77c1e7223b@mail.gmail.com>
References: <op.uys3quhbtdk399@sirnot.private>
	 <op.uyuwkuoxtdk399@sirnot.private> <op.uyzwycxotdk399@sirnot>
	 <op.uzv4covmtdk399@sirnot.private> <1252357564.5969.4.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 00:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml977-0003rC-JF
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 00:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbZIHWYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 18:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbZIHWYV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 18:24:21 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:36085 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZIHWYU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 18:24:20 -0400
Received: by ewy2 with SMTP id 2so3213555ewy.17
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2tzowBw0DN6EzjOszvZmMExk52CiUXpMhE4s0BkYg+Y=;
        b=spaG0gzQ0xUqGrRe0aNr7X1vuMVKg5sxOhT3uKIMt6R5IFtN35jNQRo5E08413ClJ+
         0xEbDV7Fk+y+DfBQbEYiM1rJqSyXWdbahFfdOfFFnKV5hbuvyCTgSO0QE41gQf/Y872u
         qLs9Q40XWqzxUqn9GSU6a3OMAy+2zQycGdhTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fOugNuign5mjz3XHFK4Ag/3DGjvzbsYZlSDxvqNivAe3Cgf1XRBeQiAh31sJuuPigD
         kQTXWifR2i+5KjEMdcWkR+KMZQYvB0fWLxtYmGB7+JtIwYOp96Iv4wg/rKytjaJKJ/3L
         NqtgkHxroN47LcPvodQx3TZf6RNyiNUwx0vQg=
Received: by 10.216.70.205 with SMTP id p55mr1781519wed.55.1252448662224; Tue, 
	08 Sep 2009 15:24:22 -0700 (PDT)
In-Reply-To: <1252357564.5969.4.camel@maia.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128045>

> ^^ You don't need to write comments like "This patch"; in the history
> such words are meaningless.

I had meant to delete that...

> "tweak" ?

Yeah I had modified the messages and didn't replace the additional
info I deleted.  It's not really important, as it's modified again
(for the last time) in the name-related patch, but here it's revised
to take advantage of the size storage.

>> =A0- more fluid handling of damaged cache slices
>
> What does this mean?

That it remembers/is aware of bad slices, instead of dumbly attempting
to load them upon each commit.

> This is quite a long commit message. =A0Is the above detail all usefu=
l?
> Can it be split into one patch for each of the above integrations?

Erm, I suppose they could be split, but the changes to revision and
list-objects aren't very big, so I figured it'd be easier/cleaner to
just put everything required for smooth integration into a single
patch.  I dunno, it dosn't seem hugely necessary; the bits modifying
git code are relatively small and already obviously seperate in the
patch.
