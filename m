From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: [PATCH] add instructions on how to send patches to the mailing list with Gmail
Date: Sun, 2 Nov 2008 16:01:00 +0100
Message-ID: <20081102150100.GF13242@frsk.net>
References: <b97024a40811010028l36606128v61172807f4cf503a@mail.gmail.com> <adf1fd3d0811010300ye0aca83t12d271388d35b8d4@mail.gmail.com> <b97024a40811011340s92a1c24jb81b75dfb25e43c5@mail.gmail.com> <20081102091006.GA4066@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Preston-Werner <tom@github.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 16:02:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KweTQ-0000jj-38
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 16:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbYKBPBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbYKBPBT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 10:01:19 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:47770 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYKBPBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 10:01:18 -0500
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1KweRo-0007no-TR; Sun, 02 Nov 2008 16:01:03 +0100
Received: from fredrik by asterix.frsk.net with local (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1KweRo-0003eE-GY; Sun, 02 Nov 2008 16:01:00 +0100
Content-Disposition: inline
In-Reply-To: <20081102091006.GA4066@artemis>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99847>

On Sun, Nov 02, 2008 at 10:10:06AM +0100, Pierre Habouzit wrote:

> > > Warning: It is not secure.
> > 
> > It is true that the certificate is not verified, but since the patches
> > are destined for a public mailing list, this does not represent a
> > large problem.
> 
> What he means is that the password is cleartext ;)
> (I think)

The way I read and understand it, the issues arises if a MITM-attack takes
place.  If the client doesn't verify the certificate, an attacker can easily
get the username and password. 

So unless someone creates a separate gmail-account for submitting patches,
one should really trust the connection (ie not a public wlan), or verify the
certificate before transmitting the password.

-- 
Kind regards,
Fredrik Skolmli
