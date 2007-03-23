From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Fri, 23 Mar 2007 09:59:30 -0400
Message-ID: <20070323135930.GB24788@fieldses.org>
References: <7v648u38ws.fsf@assigned-by-dhcp.cox.net> <20070322043604.GA6303@mellanox.co.il> <7vd531yicx.fsf@assigned-by-dhcp.cox.net> <20070322062805.GD6303@mellanox.co.il> <7vaby5wxyn.fsf@assigned-by-dhcp.cox.net> <20070322074051.GA29341@mellanox.co.il> <7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net> <20070322083757.GC29341@mellanox.co.il> <7vr6rhtvr0.fsf@assigned-by-dhcp.cox.net> <eu0m6t$hln$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 14:59:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUkIo-0008Pn-PK
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 14:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422924AbXCWN7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 09:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbXCWN7c
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 09:59:32 -0400
Received: from mail.fieldses.org ([66.93.2.214]:58484 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422924AbXCWN7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 09:59:31 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HUkIk-0007zX-FF; Fri, 23 Mar 2007 09:59:30 -0400
Content-Disposition: inline
In-Reply-To: <eu0m6t$hln$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42931>

On Fri, Mar 23, 2007 at 02:57:38PM +0100, Jakub Narebski wrote:
> Junio C Hamano wrote:
>=20
> > +The commit message is formed by the title taken from the
> > +"Subject: ", a blank line and the body of the message up to
> > +where the patch begins. =A0Excess whitespaces at the end of the
> > +lines are automatically stripped.
>=20
> Does this mean that git-am cannot make a log message that doesn't
> follow git formatting commit message guidelines, namely short one-lin=
e
> description, then longer description and signoff?

The input to git-am is email, not log messages.

--b.
