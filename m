From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Using kdiff3 to compare two different revisions of a folder
Date: Sun, 17 Feb 2008 09:35:44 -0200
Message-ID: <b8bf37780802170335r5a3eeb99q40da4d89044bf9e7@mail.gmail.com>
References: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
	 <200802132338.18449.robin.rosenberg.lists@dewire.com>
	 <b8bf37780802131636q698ebb21kc415328c04d8425d@mail.gmail.com>
	 <20080217105113.GC13178@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Feb 17 12:36:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQhoy-0005jm-7b
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 12:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbYBQLfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 06:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbYBQLfr
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 06:35:47 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:47126 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbYBQLfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 06:35:46 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1275018fkz.5
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 03:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1KjgBMtyvaKcBbfA4wxsrb7Nt9d7DQHR5pmvC5X/k0k=;
        b=dPV9oLQp02F7n2kT57DMISX1voL2Z2sY66MbFoWzjbcytT9NEhZVHtyn5Ue7f+DAujy0/PGxX7hJkSb1WnHnFgTpEJEZA03UOhMj5JegD8I70vmZNneNwaGrjQxTfEk4b/C7i2CcfxtgCNiZIZk+drDb5VZ3qXlQobfoV97q1OE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xAzR5Iz984+ItlJuIP6Qv0R//I6A62l8e41z7EHzGsA1lPIRGGugHgkjwWS2gLnJHrCy+L2wkUL93L+OTUT9CLlTAFndrWndegsSrF1Gmg6XCczRNbfJvYbQDD2NH/3v0BuT5ZPuy5wg+bFF3vRg7FUhItTyavnY0vkyHi5SLmI=
Received: by 10.78.182.17 with SMTP id e17mr6834418huf.62.1203248144426;
        Sun, 17 Feb 2008 03:35:44 -0800 (PST)
Received: by 10.78.100.15 with HTTP; Sun, 17 Feb 2008 03:35:44 -0800 (PST)
In-Reply-To: <20080217105113.GC13178@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74121>

On Feb 17, 2008 8:51 AM, Jan Hudec <bulb@ucw.cz> wrote:
> On Wed, Feb 13, 2008 at 22:36:34 -0200, Andr=E9 Goddard Rosa wrote:
> > > >     Is there a better way to do this kind of comparison?
> > >
> > > Yes.
> > >         git diff <whatever options> | kompare -
> > >
> >
> > Thanks, Robin! It works too.
>
> It should be noted, that kompare seems to be the only graphical tool =
willing
> to accept patch instead of two trees. Unfortunately it does not seem =
possible
> to install it without KDE, not to speak about Windows (where kdiff3 w=
orks
> quite well).
>

Yes, it is true. Patch support is not yet implemented on kdiff3.

Best regards,
--=20
[]s,
Andr=E9 Goddard
