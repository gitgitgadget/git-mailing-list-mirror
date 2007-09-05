From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String
	Library.
Date: Wed, 05 Sep 2007 11:27:10 -0400
Message-ID: <1189006030.20311.14.camel@hinata.boston.redhat.com>
References: <46DDC500.5000606@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 17:27:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISwmq-0008FA-0N
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 17:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbXIEP1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 11:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbXIEP1S
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 11:27:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbXIEP1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 11:27:17 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l85FRG93013519
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 11:27:16 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l85FRGhO017142
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 11:27:16 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l85FRFCg016989
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 11:27:15 -0400
In-Reply-To: <46DDC500.5000606@etek.chalmers.se>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57715>

On Tue, 2007-09-04 at 22:50 +0200, Lukas Sandstr=F6m wrote:
> Hi.
>=20
> This is an attempt to use "The Better String Library"[1] in builtin-m=
ailinfo.c
>=20
> The patch doesn't pass all the tests in the testsuit yet, but I thoug=
ht I'd
> send it out so people can decide if they like how the code looks.
>=20
> I'm not sending a patch to add the library files at this time. I'll s=
end
> that patch when this patch is working.
>=20
> The changes required to make it pass the tests shouldn't be very larg=
e.

Please, no.  Let's not pull in a dependency for something as simple as =
a
string library.  How many distros have bstring pcakaged? =20
The right version?  Does it work on Windows?  We already have strbuf.c,
lets just consolidate the string manipulation code already in git under
that interface.

Kristian
