From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 01/15] Move split_cmdline() to alias.c
Date: Sun, 29 Jun 2008 16:29:24 +0200
Message-ID: <48679C44.30702@free.fr>
References: <cover.1214581610.git.vmiklos@frugalware.org> <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org> <486796C3.7040304@free.fr> <alpine.DEB.1.00.0806291513450.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 16:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxvW-0006R8-JO
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 16:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584AbYF2O3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbYF2O3S
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 10:29:18 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:58552 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758308AbYF2O3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 10:29:18 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 50FDE12B708;
	Sun, 29 Jun 2008 16:29:17 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id E06F712B6E7;
	Sun, 29 Jun 2008 16:29:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806291513450.9925@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86807>

Johannes Schindelin a =E9crit :
>=20
> As the string comes either from the config (where it is trimmed), or =
from=20
> the command line (where the user can be stup^W^Wask for whitespace=20
> explicitely),  I do not see much merit in this patch.

You are right, today it is not a problem because the usage is really li=
mited
but Miklos's intention seems to make the function usable by everyone. A=
s we
do not know how it will be used in the future, I think it is safer with=
 my
patch.

Olivier.
