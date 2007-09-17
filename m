From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/9] Enable wt-status output to a given FILE pointer.
Date: Mon, 17 Sep 2007 19:30:25 -0400
Message-ID: <1190071825.10112.19.camel@hinata.boston.redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0709061726010.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQ35-0002DX-9M
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbXIQXaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755030AbXIQXaf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:30:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48807 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654AbXIQXae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:30:34 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8HNUWHY029628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2007 19:30:32 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HNUWg8012467;
	Mon, 17 Sep 2007 19:30:32 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HNUV5p014944;
	Mon, 17 Sep 2007 19:30:31 -0400
In-Reply-To: <Pine.LNX.4.64.0709061726010.28586@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58499>

On Thu, 2007-09-06 at 17:27 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 5 Sep 2007, Kristian H=C3=B8gsberg wrote:
>=20
> > Still defaults to stdout, but you can now override wt_status.fp aft=
er=20
> > calling wt_status_prepare().
>=20
> Would it not be easier to freopen(filename, "a", stdout)?

It's probably easier, but I think this is cleaner and the patch isn't
that big.  I don't want to worry about the side effects of freopening
stdout...

Kristian
