From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 1/3] merge: a random object may not necssarily be a
 commit
Date: Tue, 02 Apr 2013 00:51:15 +0200
Organization: OPTEYA
Message-ID: <1364856675.26812.3.camel@test.quest-ce.net>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
	 <1364846239-8802-1-git-send-email-gitster@pobox.com>
	 <1364846239-8802-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 00:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMnZy-0007tG-AO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 00:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604Ab3DAWv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 18:51:26 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:55578 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756506Ab3DAWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 18:51:25 -0400
Received: from [IPv6:2a01:e35:2e9f:6ac0:e1ed:fda0:5d8e:1080] (unknown [IPv6:2a01:e35:2e9f:6ac0:e1ed:fda0:5d8e:1080])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6C24B940034;
	Tue,  2 Apr 2013 00:51:16 +0200 (CEST)
In-Reply-To: <1364846239-8802-2-git-send-email-gitster@pobox.com>
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219723>

Hi,

Le lundi 01 avril 2013 =C3=A0 12:57 -0700, Junio C Hamano a =C3=A9crit =
:
> The user could have said "git merge $(git rev-parse v1.0.0)"; we
> shouldn't mark it as "Merge commit '15999998fb...'" as the merge
> name, even though such an invocation might be crazy.
>=20
> We could even read the "tag " header from the tag object and replace
> the object name the user gave us, but let's not lose the information
> by doing so, at least not yet.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for the patch.

I gave it a try and found the behavior rather good.

Merging a tag object by its name or by its object-id are now using the
same behavor: it is more consistent.=20

Tested-by: Yann Droneaud <ydroneaud@opteya.com>

PS: there's a typo in the commit title :)

Regards.

--=20
Yann Droneaud
OPTEYA
