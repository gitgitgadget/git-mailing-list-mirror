From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 18:11:27 -0400
Message-ID: <20160504221127.GB26339@sigill.intra.peff.net>
References: <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
 <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
 <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
 <5729DF25.7030503@ramsayjones.plus.com>
 <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
 <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
 <20160504192516.GD21259@sigill.intra.peff.net>
 <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
 <20160504200635.GA22787@sigill.intra.peff.net>
 <CACBZZX4dYjHETCyMFQngBKoS80gkmcAZKKYc0VkE0ufaAg-gZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 00:11:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay514-0003MY-EE
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbcEDWLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 18:11:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:34308 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbcEDWLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:11:30 -0400
Received: (qmail 7819 invoked by uid 102); 4 May 2016 22:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 18:11:30 -0400
Received: (qmail 14748 invoked by uid 107); 4 May 2016 22:11:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 18:11:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 18:11:27 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX4dYjHETCyMFQngBKoS80gkmcAZKKYc0VkE0ufaAg-gZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293608>

On Wed, May 04, 2016 at 11:54:52PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> >   my @files =3D map { chomp; $_ } `git ls-files`;
>=20
> As a minor sidenote you can equivalently write that as:
>=20
>     chomp(my @files =3D `git ls-files`);
>=20
> I.e. chomp itself when given a list will chomp each item of the list.
> So no need for a map.

Right, thanks, that is more readable. I use the map form reflexively
because I am often doing stuff like:

  my @list =3D do {
    open(my $fh, '<', $fn);
    map { chomp; $_ }
  };

(or replacing "do" with an actual function which is returning a
grotesque pipeline of grep/map, etc).

-Peff
