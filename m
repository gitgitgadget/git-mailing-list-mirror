From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 13:25:49 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070327112549.GA12178@informatik.uni-freiburg.de>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9oP-0004DG-V1
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbXC0LZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 07:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbXC0LZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:25:59 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:46680 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753813AbXC0LZ6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 07:25:58 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HW9oI-0005DC-Ai; Tue, 27 Mar 2007 13:25:54 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2RBPouj012567;
	Tue, 27 Mar 2007 13:25:50 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2RBPnd6012566;
	Tue, 27 Mar 2007 13:25:49 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Martin Waitz <tali@admingilde.org>, Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070326233603.GL22773@admingilde.org>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43266>

Hello,

Martin Waitz wrote:
> On Mon, Mar 26, 2007 at 04:28:28PM -0700, Junio C Hamano wrote:
> > Martin Waitz <tali@admingilde.org> writes:
> >=20
> > > To make purge and fsck work we have the hard requirement that it
> > > must be possible to list all objects which belong to one submodul=
e.
> >=20
> > I understand you would want to separate the ref namespace, but I
> > still do not see why you would want to have a separate object
> > store, laid out in a funny way.  Unless you are thinking about
> > using rsync to transfer object store, that is.
>=20
> I want to be able to list all objects which are not reachable in the
> object store, without traversing all submodules at the same time.
> The only way I can think of to achieve this is to have one separate
> object store per submodule and then do the traversal per submodule.
I might have understood something wrongly, but to list objects that are
not reachable you need to traverse all trees anyhow, don't you. =20

Then how big is the difference between a directory and an submodule?
I'd expect it's not so big if the submodules included in different
revisions of the supermodule share most of their history.  Of course yo=
u
need to exploit that.  Thinking again that might be the problem?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

5 out of 4 people have trouble with fractions.
