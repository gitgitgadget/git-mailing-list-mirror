From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: send-email adds redundant From: lines to message body
Date: Tue, 18 Jun 2013 15:50:17 +0300
Message-ID: <20130618125017.GA28113@redhat.com>
References: <20130618110904.GA20052@goldbirke>
 <20130618114207.GD26857@redhat.com>
 <20130618114800.GB20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UovM1-0001zr-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab3FRMtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 08:49:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37437 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab3FRMtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:49:41 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICnUCs024217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 18 Jun 2013 08:49:30 -0400
Received: from redhat.com (vpn1-5-182.ams2.redhat.com [10.36.5.182])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICnSrI007034;
	Tue, 18 Jun 2013 08:49:29 -0400
Content-Disposition: inline
In-Reply-To: <20130618114800.GB20052@goldbirke>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228226>

On Tue, Jun 18, 2013 at 01:48:00PM +0200, SZEDER G=E1bor wrote:
> On Tue, Jun 18, 2013 at 02:42:07PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 18, 2013 at 01:09:04PM +0200, SZEDER G=E1bor wrote:
> > > Hi,
> > >=20
> > > 'git send-email' recently started to add redundant From: lines to=
 my
> > > messages, see e.g.
> > >=20
> > >   http://article.gmane.org/gmane.comp.version-control.git/228132
> >=20
> > Can you please show what do commits point to?
> > E.g. push to some public tree?
>=20
> Sure.
>=20
>   https://github.com/szeder/git.git bash-prompt-speedup

Okay, missed sanitizing author in one more place.
I sent a patch that should fix it for you,
tested-by reports appreciated.

--=20
MST
