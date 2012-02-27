From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 01/11] Add more large blob test cases
Date: Mon, 27 Feb 2012 21:18:05 +0100
Message-ID: <20120227201805.GA10195@m62s10.vlinux.de>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330329315-11407-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S271T-0004FH-Lt
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 21:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab2B0USL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 15:18:11 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:56996 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752533Ab2B0USK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 15:18:10 -0500
Received: (qmail invoked by alias); 27 Feb 2012 20:18:08 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp019) with SMTP; 27 Feb 2012 21:18:08 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/Z/G4R3xDZRD09gxOJZ5gcvSskRPlHVIildieFdH
	yHzyRJP7kP83Gk
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id ED424D400C; Mon, 27 Feb 2012 21:18:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1330329315-11407-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191662>

A minor spelling error in the text.

On Mon, Feb 27, 2012 at 02:55:05PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> New test cases list commands that should work when memory is
> limited. All memory allocation functions (*) learn to reject any
> allocation larger than $GIT_ALLOC_LIMIT if set.
>=20
> (*) Not exactly all. Some places do not use x* functions, but
> malloc/calloc directly, notably diff-delta. These could path should
                                                    ^code
> never be run on large blobs.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

-Peter
