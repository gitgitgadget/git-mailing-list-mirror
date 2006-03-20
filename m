From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cloning from sites with 404 overridden
Date: Mon, 20 Mar 2006 20:43:16 +0100
Message-ID: <20060320194316.GO18185@pasky.or.cz>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com> <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com> <e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com> <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net> <441EF46E.5050907@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 20 20:43:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLQHR-0003Dt-2C
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 20:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWCTTnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Mar 2006 14:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWCTTnA
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 14:43:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61339 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964889AbWCTTm7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 14:42:59 -0500
Received: (qmail 23589 invoked by uid 2001); 20 Mar 2006 20:43:16 +0100
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <441EF46E.5050907@etek.chalmers.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17762>

Dear diary, on Mon, Mar 20, 2006 at 07:29:02PM CET, I got a letter
where Lukas Sandstr=F6m <lukass@etek.chalmers.se> said that...
> Junio C Hamano wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >>http://digilander.libero.it /mcostalba/scm/qgit.git/objects/8d/ea03=
519e75f47d
> >=20
> > To be fair, the site is _not_ missing anything from HTTP
> > protocol perspective, because when git asks 8d/ea0351... file,
> > the server responds with a regular "HTTP/1.0 200 OK" response.
> > So it is _your_ repository that is corrupt -- instead of
> > correctly _lacking_ the file you should have removed with
> > prune-packed, it has a garbage file.
>=20
> Actually, it sends a 302 redirect.=20
>=20
> Perhaps a repository config option to treat a 302 as a 404?

I think that would be too ugly _and_ specific a workaround for the
particular site. It's reasonable to keep it generalized for all the
broken repositories when already doing it.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
