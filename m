From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: Fix sorting changelists when cloning a Perforce repository
Date: Mon, 13 Aug 2007 23:45:17 +0200
Message-ID: <200708132345.23647.simon@lst.de>
References: <3f4fd2640708131150r1d9fb02ai1f655a22658cb544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2187969.LysIL89uYS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:46:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKhjc-0003Uz-1U
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 23:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764522AbXHMVpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 17:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764445AbXHMVpj
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 17:45:39 -0400
Received: from verein.lst.de ([213.95.11.210]:53180 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525AbXHMVph (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 17:45:37 -0400
Received: from luria.local (2.84-48-121.nextgentel.com [84.48.121.2])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l7DLjRA5000848
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 23:45:28 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <3f4fd2640708131150r1d9fb02ai1f655a22658cb544@mail.gmail.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55788>

--nextPart2187969.LysIL89uYS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 13 August 2007 20:50:59 Reece Dunn wrote:
> Hi,
>
> When performing a git-p4 clone operation on a Perforce repository,
> where the changelists change in order of magnitude (e.g. 100 to 1000),
> the set of changes to import from is not sorted properly. This is
> because the data in the list is strings not integers. The other place
> where this is done already converts the value to an integer, so it is
> not affected.
>
> This patch fixes this issue.

Acked-by: Simon Hausmann <simon@lst.de>


Thanks,
Simon

--nextPart2187969.LysIL89uYS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGwNDzWXvMThJCpvIRAnamAKD3YPVs2zMaV/gQVuRrcGzlZA0B9QCgzTrz
G6ThuYnJCl4PBVCNJoiqNgQ=
=MUuV
-----END PGP SIGNATURE-----

--nextPart2187969.LysIL89uYS--
