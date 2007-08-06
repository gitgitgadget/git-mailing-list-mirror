From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] send-email: let sanitize_address_rfc822 do rfc2047 quoting
Date: Mon, 6 Aug 2007 10:33:42 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070806083341.GA6625@informatik.uni-freiburg.de>
References: <11863445481996-git-send-email-ukleinek@informatik.uni-freiburg.de> <f95pie$8lv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 10:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHy28-0002jM-Kk
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 10:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbXHFIdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbXHFIdp
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 04:33:45 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:39643 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753174AbXHFIdo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 04:33:44 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IHy23-0002cq-Lr; Mon, 06 Aug 2007 10:33:43 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l768XgYX006715;
	Mon, 6 Aug 2007 10:33:42 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l768Xg4a006714;
	Mon, 6 Aug 2007 10:33:42 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <f95pie$8lv$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55124>

Hello Jakub,

Jakub Narebski wrote:
> > The former version tried to fix-up the real name part with double q=
uotes
> > if it includes a '.'. =A0I removed this as rfc2047 can handle a dot=
, too.
>=20
> Not nice. I'd rather use double quotes if rfc2047 is not needed.
> It means:
>  - no quotes for us-ascii name, without '.'
>  - quotes for us-ascii name with '.' and perhaps other forbidden char=
acters
>    like '"' or something
>  - full rfc2047 quoting if name contains characters outside us-ascii.
Well, that is OK for me, too.  I just thought to do just one thing that
is able to handle all cases.  So the code is easier to read and most of
the time you don't see the quoted result anyhow.

I will follow up with a new version later that will leave the second
part out.  I don't know which chars can be quoted by "...", is it more
than .?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+stone%3D
