From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/5] Add test case for basic commit functionality.
Date: Tue, 31 Jul 2007 10:27:11 -0400
Message-ID: <1185892031.11086.43.camel@hinata.boston.redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
	 <7vodhtgq99.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 16:28:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFshh-0002dW-C0
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 16:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764696AbXGaO12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 10:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764679AbXGaO11
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 10:27:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38968 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763446AbXGaO10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 10:27:26 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6VERI4e012002;
	Tue, 31 Jul 2007 10:27:18 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VERId1012590;
	Tue, 31 Jul 2007 10:27:18 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VERGNZ001858;
	Tue, 31 Jul 2007 10:27:17 -0400
In-Reply-To: <7vodhtgq99.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54353>

On Mon, 2007-07-30 at 21:18 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > +# Pick a date so we get consistent commits. 7/7/07 means good luck=
!
> > +export GIT_AUTHOR_DATE=3D"July 7, 2007"
> > +export GIT_COMMITTER_DATE=3D"July 7, 2007"
>=20
> Other scripts use test_tick for consistent commits; just to let
> you know, the above is as good if you intend to use only one
> timestamp.

Ok, cool, I'll send out an updated test case.

Kristian
