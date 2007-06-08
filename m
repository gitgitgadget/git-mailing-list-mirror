From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Fri, 08 Jun 2007 18:05:20 -0400
Message-ID: <1181340320.30683.30.camel@hinata.boston.redhat.com>
References: <1181338730800-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0706082249040.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwmaQ-0000aB-1m
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968106AbXFHWFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Jun 2007 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967990AbXFHWFa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:05:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762809AbXFHWF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 18:05:29 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l58M5QKx013381;
	Fri, 8 Jun 2007 18:05:26 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l58M5QgL020628;
	Fri, 8 Jun 2007 18:05:26 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l58M5Pqm004996;
	Fri, 8 Jun 2007 18:05:25 -0400
In-Reply-To: <Pine.LNX.4.64.0706082249040.4059@racer.site>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49510>

On Fri, 2007-06-08 at 22:51 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 8 Jun 2007, Kristian H=C3=B8gsberg wrote:
>=20
> > A more or less straight-forward port of git-tag.sh to C.
>=20
> It is somewhat unfortunate that you did not say that you were working=
 on=20
> this stuff; we have a Google Summer of Code project going on, which t=
ries=20
> to port many scripts to builtins.

Ugh, yeah... wasted effort...  I didn't see anything about the SoC
project on the list and I didn't pre-announce my work because I only
spent little more than half a day...

> As it happens, I am working with jasam on exactly the same script.

Hm... not sure how to resolve this.  FWIW, I'm going to send an updated
version of the patch that should also pass the test suite.  The previou=
s
version always only creates annotated tags.

Kristian
