From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: Builtin-clone?
Date: Tue, 19 Feb 2008 11:02:32 -0500
Message-ID: <1203436952.32036.5.camel@gaara.boston.redhat.com>
References: <alpine.LNX.1.00.0802182341430.5816@iabervon.org>
	 <200802190808.33611.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:03:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRUwA-00074J-3h
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbYBSQCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2008 11:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbYBSQCn
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:02:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbYBSQCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:02:42 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1JG2ddS013017;
	Tue, 19 Feb 2008 11:02:39 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1JG2c51019110;
	Tue, 19 Feb 2008 11:02:38 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1JG2bcF015811;
	Tue, 19 Feb 2008 11:02:38 -0500
In-Reply-To: <200802190808.33611.johan@herland.net>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74420>

On Tue, 2008-02-19 at 08:08 +0100, Johan Herland wrote:
> On Tuesday 19 February 2008, Daniel Barkalow wrote:
> > I remember some discussion of what was still needed in order to mak=
e clone=20
> > a trivial caller of init, config, fetch, and (optionally) checkout,=
 and=20
> > that there was still something. But has anyone actually written the=
 bulk=20
> > of builtin-clone.c?
>=20
> I remember Kristian H=C3=B8gsberg posted some WIP back in December:
> http://thread.gmane.org/gmane.comp.version-control.git/67915/

What Johan said :)  I posted the patch in progress during the 1.5.4
freeze, and threatened to pick it up again in January after 1.5.4 was
released.  I haven't worked on it since, unfortunately.  It does most o=
f
the option parsing and the local clone optimizations, but doesn't use
fetch correctly (as Daniel points out in the thread above).

Daniel, I'm pretty sure you have a better understanding of the fetch an=
d
checkout side of clone, so if you want to take the patch and finish
those parts, I'm fine with that.

> I recently sent him (and the list) an email asking about his progress=
 (and -=20
> once his work arrives - whether it's a good idea to make 'git clone'=20
> produce packed refs), but I have yet to hear from him...

I think packed refs in clone sounds like a good idea, but my primary
goal was really to just port it to C and avoid changes in behavior
during that work.

cheers,
Kristian
