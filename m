From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Move option parsing code to parse-options.[ch].
Date: Mon, 24 Sep 2007 14:41:02 -0400
Message-ID: <1190659262.10444.1.camel@hinata.boston.redhat.com>
References: <1190401278-2869-1-git-send-email-krh@redhat.com>
	 <7vsl57iz1t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:41:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZsrx-0005s9-Bk
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 20:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbXIXSlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2007 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbXIXSlP
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 14:41:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbXIXSlO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 14:41:14 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8OIf84a012571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2007 14:41:08 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8OIf74V031023;
	Mon, 24 Sep 2007 14:41:07 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8OIf73s028649;
	Mon, 24 Sep 2007 14:41:07 -0400
In-Reply-To: <7vsl57iz1t.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59070>

On Fri, 2007-09-21 at 12:44 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> > ---
> >  Makefile         |    2 +-
> >  builtin-commit.c |  117 ++++++++----------------------------------=
------------
> >  parse-options.c  |   74 ++++++++++++++++++++++++++++++++++
> >  parse-options.h  |   29 +++++++++++++
> >  4 files changed, 121 insertions(+), 101 deletions(-)
> >  create mode 100644 parse-options.c
> >  create mode 100644 parse-options.h
>=20
> Hmmmmmmm. Is it too much to ask to pretend as if the previous
> "builtin-commit.c" that had these parts that did not belong to
> it in the first place never happened?

No problem, I wasn't sure whether to update the patches or to just send
follow-up patches now that it was in pu.  I'll resend 7/7 as 3 new
patches that exports add_files_to_cache(), adds option parsing, and
finally builtin-commit.

Kristian
