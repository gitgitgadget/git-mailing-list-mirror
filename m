From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 13:57:25 +0000
Message-ID: <20110121135725.GR13235@n2100.arm.linux.org.uk>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com> <20110116092315.GA27542@n2100.arm.linux.org.uk> <20110116110819.GG6917@pengutronix.de> <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com> <20110116134248.GD27542@n2100.arm.linux.org.uk> <4D398C43.1000306@vollmann.ch> <20110121134728.GO14956@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Detlef Vollmann <dv@vollmann.ch>,
	Jello huang <ruifeihuang@gmail.com>, git@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Jan 21 14:58:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgHV5-0005IF-Nq
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 14:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab1AUN5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 08:57:53 -0500
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33811 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab1AUN5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 08:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
	h=Sender:In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Ub6QSZOFL4MARSwOjCMsNzMa+0a8V448opBIWSAhinA=;
	b=V2F/breoBO5Vj3Xcri6GDPLso96CucdUpzTElypC2XEMHejh8EC2sFkGuWm6gu0GOLqkHr9YPmO2YnXQ7mmc6VWbTnhqyCZM5IFsNWw/Q2VWRq5CTdJ0woSkcSAnAaH+wNtlxJpMyhrySgMK8aEpf3ymJCIanGyONIluLw9E1Ug=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PgHUU-0007NS-Nb; Fri, 21 Jan 2011 13:57:27 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PgHUT-0004w1-FZ; Fri, 21 Jan 2011 13:57:25 +0000
Content-Disposition: inline
In-Reply-To: <20110121134728.GO14956@pengutronix.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165370>

On Fri, Jan 21, 2011 at 02:47:28PM +0100, Uwe Kleine-K=F6nig wrote:
> Hi Detlef,
>=20
> On Fri, Jan 21, 2011 at 02:38:11PM +0100, Detlef Vollmann wrote:
> > On 01/16/11 14:42, Russell King - ARM Linux wrote:
> > >Let's say you already have a copy of my tree from a month ago, and=
 Linus
> > >has pulled some work from me into his tree, and repacked his tree =
into one
> > >single pack file.  At the moment, the largest pack file from Linus=
 is
> > >400MB plus a 50MB index.
> > >
> > >You already have most of the contents of that 400MB pack file, but=
 if
> > >you're missing even _one_ object which is contained within it, git=
 will
> > >have to download the _entire_ 400MB pack file and index file to re=
trieve
> > >it.
> > I thought this has changed with "smart http" in git 1.6.6.
> > Am I missing something?
> Well, not all http repos offer smart http.  E.g. Russell doesn't[1],
> probably because the serving machine doesn't have the power to nice
> serve a repo via git:// or smart http://.

What is smart http?  I don't particularly follow git developments.
