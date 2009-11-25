From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-subtree: directory mismatch
Date: Thu, 26 Nov 2009 00:41:22 +0100
Message-ID: <20091125234122.GA31422@atjola.homenet>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com>
 <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
 <20091125080812.6117@nanako3.lavabit.com>
 <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com>
 <7v7htexuxc.fsf@alter.siamese.dyndns.org>
 <32541b130911251148v70a5dc77k9936881d0b382ec2@mail.gmail.com>
 <7vpr76uzju.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0911260013550.4985@pacific.mpi-cbg.de>
 <32541b130911251520l7a84554bxab9cf59ff9d8fc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Marc Fournier <marc.fournier@camptocamp.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:41:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRUM-00040z-7D
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbZKYXlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 18:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbZKYXlW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:41:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:60890 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964965AbZKYXlV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:41:21 -0500
Received: (qmail invoked by alias); 25 Nov 2009 23:41:26 -0000
Received: from i59F564FE.versanet.de (EHLO atjola.homenet) [89.245.100.254]
  by mail.gmx.net (mp060) with SMTP; 26 Nov 2009 00:41:26 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Fvh0/PUVF4juyzsYHD8YerpPyS3gpKVY3J0Vky0
	EpXqMlo0tHigWD
Content-Disposition: inline
In-Reply-To: <32541b130911251520l7a84554bxab9cf59ff9d8fc1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133705>

On 2009.11.25 18:20:45 -0500, Avery Pennarun wrote:
> On Wed, Nov 25, 2009 at 6:17 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 25 Nov 2009, Junio C Hamano wrote:
> >> I do remember some people didn't like -X<option> syntax but I don'=
t
> >> think there was any solid counterproposal to achieve a similar goa=
l to
> >> satisfy the need to pass arbitrary parameters to the merge strateg=
y
> >> backends.
> >
> > I took exception to the awkward way to specify the option. =A0A str=
ong hint
> > just how awkward -X<option> is: it is hard to implement using
> > parse-options.
>=20
> I read the earlier thread and I still don't quite understand this
> point.  What makes it difficult?

I guess it's -Xfoo vs. -X foo (note the space). Same deal with log
-S<string>. "git log -S foo" would look for an empty string (I guess)
being added/removed in some commit in foo's history, while "git log
-Sfoo" looks for "foo" being added/remove in HEAD's history.

Bj=F6rn
