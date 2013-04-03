From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 3 Apr 2013 17:22:28 +0200
Message-ID: <87k3ojtz9n.fsf@linux-k42r.v.cablecom.net>
References: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
	<3b24bc742b9738531d707932a9775c98@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPWe-0001si-Vs
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760206Ab3DCPWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 11:22:32 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:21576 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab3DCPWb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 11:22:31 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 3 Apr
 2013 17:22:26 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 3 Apr 2013 17:22:28 +0200
In-Reply-To: <3b24bc742b9738531d707932a9775c98@meuh.org> (Yann Droneaud's
	message of "Wed, 03 Apr 2013 17:18:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219949>

Yann Droneaud <ydroneaud@opteya.com> writes:

> Hi,
>
> Le 03.04.2013 16:27, Thomas Rast a =C3=A9crit=C2=A0:
>> +<commit>, <object>::
>> +	The object that the new tag will refer to, usually a commit.
>> +	Defaults to HEAD.
>=20
> Is there any other kind of object that can be tagged ... and what is
> the purpose of this ?

Any object type, including tags.  Signed tags of other tags probably
make sense if you want to express extra approval on top of the original
signature.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
