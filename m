From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 17:59:20 -0500
Message-ID: <20070119225920.GA26442@fieldses.org>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home> <7v1wlrle61.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701191437450.3011@xanadu.home> <7vbqkufyhy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701191729060.3011@xanadu.home> <eoriau$n97$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 23:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H82hh-0006f5-Ew
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbXASW7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXASW7W
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:59:22 -0500
Received: from mail.fieldses.org ([66.93.2.214]:52914 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932844AbXASW7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:59:21 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H82hc-0008Ms-Ak; Fri, 19 Jan 2007 17:59:20 -0500
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eoriau$n97$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37218>

On Fri, Jan 19, 2007 at 11:57:12PM +0100, Jakub Narebski wrote:
> Nicolas Pitre wrote:
>=20
> > Also, having:
> >=20
> > =A0 =A0git-am(1)
> > =A0 =A0 =A0 =A0 =A0 Apply a series of patches from a mailbox.
> >=20
> > =A0 =A0git-applymbox(1)
> > =A0 =A0 =A0 =A0 =A0 Apply a series of patches in a mailbox.
> >=20
> > looks a bit weird. =A0Why two commands with almost the same descrip=
tion? =A0
> > Maybe one of them could be relegated to ancillary? =A0Or even both =
of them=20
> > to foreignscminterface?
>=20
> Because they are almost the same (same command, different interface).
> git-applymbox is legacy for Linus.

Given how often this question is asked, maybe git-aplymbox should just
be removed from this and every other global list of commands.  Linus
(and whoever else is used to it) knows where to find it.

Unless there's really something it has that git-am doesn't.

--b.
