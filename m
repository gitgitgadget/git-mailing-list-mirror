From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 06 Mar 2008 13:35:15 -0500
Message-ID: <1204828515.10084.16.camel@gaara.boston.redhat.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
	 <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0802281159550.22527@racer.site>
	 <200803052221.12495.johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0803052317350.15786@racer.site>
	 <7vir00lski.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0803052327570.15786@racer.site>
	 <alpine.LSU.1.00.0803060212170.15786@racer.site>
	 <20080306063331.GA7325@glandium.org>
	 <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>
	 <alpine.LSU.1.00.0803061153400.15786@racer.site>
	 <1204827539.10084.9.camel@gaara.boston.redhat.com>
	 <alpine.LSU.1.00.0803061925370.3941@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 19:39:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXKzo-0008A0-HF
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 19:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbYCFSif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 13:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYCFSie
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 13:38:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbYCFSie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 13:38:34 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m26IZLnO007846;
	Thu, 6 Mar 2008 13:35:21 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m26IZKRO006109;
	Thu, 6 Mar 2008 13:35:20 -0500
Received: from [192.168.1.104] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m26IZKRd011261;
	Thu, 6 Mar 2008 13:35:20 -0500
In-Reply-To: <alpine.LSU.1.00.0803061925370.3941@racer.site>
X-Mailer: Evolution 2.21.91 (2.21.91-2.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76408>

On Thu, 2008-03-06 at 19:26 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 6 Mar 2008, Kristian H=C3=B8gsberg wrote:
>=20
> > On Thu, 2008-03-06 at 11:55 +0100, Johannes Schindelin wrote:
> >
> > > So your suggestion is out, unless you suggest to implement the wh=
ole=20
> > > printf mechanism... which I hope you're not.
> >=20
> > It's not a terrible idea, honestly.
>=20
> Heh.  Yeah, I actually posted a start...
>=20
> > There are several mature vsnprintf implementations out there under=20
> > friendly licenses.  We could just stick it in compat/.  It's the on=
ly=20
> > way to do reliable, cross platform vsnprintf, in my experience.  An=
d the=20
> > issue with %I64u vs %llu could be handle by implementing both, as W=
ayne=20
> > Davison suggests.
>=20
> Sure, we could always copy from somewhere else.  My rationale was tha=
t I=20
> had fun writing it, and that we do not really need a full printf()=20
> implementation.

That's how it always starts... "We just need %d and %s! It'll take me
half an hour!"  I know because, I've it a number of times myself ;)
Just pull in the rsync one, don't waste time on this.

Kristian


