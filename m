From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: git-checkout changes the index but not the checked out files?
Date: Mon, 23 Apr 2007 20:35:51 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070423183551.GB25465@informatik.uni-freiburg.de>
References: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com> <7virbokmx1.fsf@assigned-by-dhcp.cox.net> <46a038f90704221717i8e5c1bkff066dcbdb0a0523@mail.gmail.com> <7vabx0kk4z.fsf@assigned-by-dhcp.cox.net> <46a038f90704221745h1bf2955cyfb40f6e8c08a336d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg3OL-0003Hw-60
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 20:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbXDWSf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Apr 2007 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbXDWSf6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 14:35:58 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58939 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161151AbXDWSf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 14:35:57 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Hg3OG-0002UN-8a; Mon, 23 Apr 2007 20:35:56 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l3NIZq94027568;
	Mon, 23 Apr 2007 20:35:52 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l3NIZpsO027567;
	Mon, 23 Apr 2007 20:35:51 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46a038f90704221745h1bf2955cyfb40f6e8c08a336d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45346>

Hallo,

Martin Langhoff wrote:
> Hmmmm. There was a .git/mdl18-local file that had the bogus SHA1 in
> it: a26c09be05a08e5f911ef84b5f8010ba155ea77d . I don't know how it go=
t
> there and how it had the wrong sha1 in it.=20
I already saw this, too.  In my case it was the result from making=20

	git update-ref $branch ...

and I forgot to prefix $branch with refs/heads.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3De+%5E+%28i+pi%29
