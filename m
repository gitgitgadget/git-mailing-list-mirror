From: Wincent Colaiuta <win@wincent.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:45:16 +0100
Message-ID: <AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <alpine.LFD.0.99999.0711261417580.9605@xanadu.home> <854pf8243i.fsf@lola.goethe.zz> <20071126195750.GD25784@efreet.light.src>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwkqB-0007Jk-P3
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbXKZUpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 15:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbXKZUpm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:45:42 -0500
Received: from wincent.com ([72.3.236.74]:39617 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbXKZUpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 15:45:41 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQKjHnQ017579;
	Mon, 26 Nov 2007 14:45:18 -0600
In-Reply-To: <20071126195750.GD25784@efreet.light.src>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66119>

El 26/11/2007, a las 20:57, Jan Hudec escribi=F3:

> The availability of plumbing is really big part of a reason why git =20
> is so
> good and has so many scripts and tool built on top of it.

Yes, the plumbing is really lovely when it comes time to whipping =20
together a quick tool for a special task; much nicer than writing a =20
plugin.

=46or the benefit of newcomers, I just wish the plumbing was kept a =20
little bit out of sight. You know, porcelain in /usr/bin and plumbing =20
in /usr/libexec or other such place.

It's fine once you've learnt your workflows and know the 10 or 15 Git =20
tools that you'll be using day-to-day; but for people who are just =20
starting off this can be a little bit intimidating:

$ git-<tab>
Display all 146 possibilities? (y or n)

Cheers,
Wincent
