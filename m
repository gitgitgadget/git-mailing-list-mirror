From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
	use --signoff
Date: Sat, 27 Dec 2008 13:01:28 +0100
Message-ID: <20081227120128.GA11322@chistera.yi.org>
References: <7v63l6f1mc.fsf@gitster.siamese.dyndns.org> <1230368596-6865-1-git-send-email-dato@net.com.org.es> <7v8wq1esvo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 13:03:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGXsg-000134-BB
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 13:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbYL0MBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 07:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYL0MBc
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 07:01:32 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1104
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYL0MBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 07:01:31 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 46A32801BF66;
	Sat, 27 Dec 2008 13:01:30 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGXrE-0002xq-Td; Sat, 27 Dec 2008 13:01:28 +0100
Content-Disposition: inline
In-Reply-To: <7v8wq1esvo.fsf@gitster.siamese.dyndns.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104000>

* Junio C Hamano [Sat, 27 Dec 2008 03:53:47 -0800]:

> Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> > +commit.signoff::
> > +	If set, 'git commit' will behave as if '-s' option was given.
> > +	Please use this option with care: by enabling it, you're stating
> > +	that all your commits will invariably meet the S-o-b
> > +	requirements for any project you send patches to. It's probably

> This is true only if you set it in your global configuration.  A more=
 sane
> usage would be to have it per repository as you recommend in a later
> sentence, and "for any project" part is untrue when the reader does s=
o.

How about:

  Please use this option with care: by enabling it globally, you'd be
  stating...

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
                              Listening to: Niza - Solsticio de inviern=
o
