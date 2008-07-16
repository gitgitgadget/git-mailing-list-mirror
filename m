From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Wed, 16 Jul 2008 08:57:33 +0200
Message-ID: <20080716065733.GB32617@diana.vm.bytemark.co.uk>
References: <7v3amglxmb.fsf@gitster.siamese.dyndns.org> <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com> <alpine.DEB.1.00.0807111635400.8950@racer> <7f9d599f0807110841r329dfb95g786a576bd981dd1b@mail.gmail.com> <alpine.DEB.1.00.0807111647080.8950@racer> <7vej60jln6.fsf@gitster.siamese.dyndns.org> <7f9d599f0807122014y5190463j62d106a01bf31c86@mail.gmail.com> <7f9d599f0807150957o78d46204x280668c763fba2bf@mail.gmail.com> <alpine.DEB.1.00.0807152255020.2990@eeepc-johanness> <7vod4yztf5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Geoffrey Irving <irving@naml.us>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:59:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ0z3-0005DT-90
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 08:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYGPG6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jul 2008 02:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbYGPG6a
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 02:58:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2116 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYGPG6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 02:58:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KJ0xB-0000CH-00; Wed, 16 Jul 2008 07:57:33 +0100
Content-Disposition: inline
In-Reply-To: <7vod4yztf5.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88646>

On 2008-07-15 15:14:38 -0700, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > > +static const char *signature =3D "CS1M";
> >
> > Carrie Scr*ws 1 Man?
>
> No Idea ;-)

Given the "cached_sha1_map_header" union (or struct) earlier in the
patch, I know what my guess is. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
