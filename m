From: "Kent R. Spillner" <kspillner@acm.org>
Subject: Re: [PATCH 03/12] Add and use skip_prefix_defval()
Date: Wed, 18 Dec 2013 10:27:46 -0600
Message-ID: <20131218162746.GA15334@sl4mmy.zerosphere.org>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
 <1387378437-20646-4-git-send-email-pclouds@gmail.com>
Reply-To: "Kent R. Spillner" <kspillner@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 17:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtK7A-0002zv-UC
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 17:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab3LRQgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 11:36:43 -0500
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:58939 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3LRQgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 11:36:40 -0500
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2013 11:36:40 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp21.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 17956300D60;
	Wed, 18 Dec 2013 11:27:50 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp21.relay.ord1a.emailsrvr.com (Authenticated sender: sl4mmy-AT-zerosphere.org) with ESMTPSA id F32E2300D83;
	Wed, 18 Dec 2013 11:27:49 -0500 (EST)
Mail-Followup-To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1387378437-20646-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239455>

On Wed, Dec 18, 2013 at 09:53:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This is a variant of skip_prefix() that returns a specied pointer
> instead of NULL if no prefix is found. It's helpful to simplify
>=20
>   if (starts_with(foo, "bar"))
>     foo +=3D 3;
>=20
> into
>=20
>   foo =3D skip_prefix_gently(foo, "bar", foo);

Should this be skip_prefix_defval instead of skip_prefix_gently?
