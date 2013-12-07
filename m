From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 09/10] builtin/replace: unset =?utf-8?b?cmVhZF9yZXBsYWNlX3JlZnM=?=
Date: Sat, 7 Dec 2013 19:02:38 +0000 (UTC)
Message-ID: <loom.20131207T200130-598@post.gmane.org>
References: <20131207160514.21478.72966.chriscool@tuxfamily.org> <20131207162106.21478.98950.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 20:03:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpN9f-00072b-Pf
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 20:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852Ab3LGTDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Dec 2013 14:03:03 -0500
Received: from plane.gmane.org ([80.91.229.3]:57965 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761Ab3LGTDB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 14:03:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VpN9Y-0006za-BM
	for git@vger.kernel.org; Sat, 07 Dec 2013 20:03:00 +0100
Received: from eph38.neoplus.adsl.tpnet.pl ([83.20.49.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 20:03:00 +0100
Received: from jnareb by eph38.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 20:03:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.20.49.38 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/30.0.1599.114 Chrome/30.0.1599.114 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239014>

Christian Couder <chriscool <at> tuxfamily.org> writes:

>=20
> When checking to see if some objects are of the same type
> and when displaying the type of objects, git replace uses
> the sha1_object_info() function.
>=20
> Unfortunately this function by default respects replace
> refs, so instead of the type of a replaced object, it
> gives the type of the replacement object which might
> be different.

Wasn't replace mechanism tightened, so that replacing object
must be the same type as replaced object?

Is there a situation where you might want replace object
with different type of object?

--=20
Jakub Nar=C4=99bski
