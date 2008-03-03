From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH, fixed] builtin-clone: create remotes/origin/HEAD symref, if guessed
Date: Mon, 3 Mar 2008 18:41:46 +0100
Message-ID: <200803031841.47302.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <alpine.LSU.1.00.0803020622190.22527@racer.site> <1204563913.4084.3.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWEi7-0006LK-Fy
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbYCCRn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 12:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbYCCRnW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:43:22 -0500
Received: from sam.opera.com ([213.236.208.81]:36514 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757505AbYCCRnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:43:19 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m23Hfllo030357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Mar 2008 17:41:48 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <1204563913.4084.3.camel@gaara.boston.redhat.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92.1/6093/Mon Mar  3 15:03:18 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75956>

On Monday 03 March 2008, Kristian H=C3=B8gsberg wrote:
> Oh and I'm wondering if
>=20
>   strbuf_initf(&real_ref,=EF=BB=BF "%s/%s", branch_top, head);
>=20
> would be a worthwhile addition to the strbuf API...

+1. This is about the first thing I started looking for in strbuf.h whe=
n I first looked at strbufs...


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
