From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] parse-options: deprecate OPT_BOOLEAN
Date: Wed, 28 Sep 2011 18:30:41 +0900
Message-ID: <buok48tggji.fsf@dhlpc061.dev.necel.com>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 11:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8qTd-0007XZ-Pj
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 11:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab1I1Jat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 05:30:49 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:64784 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab1I1Jas convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 05:30:48 -0400
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LS800LZM7RBAS90@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Wed, 28 Sep 2011 18:30:47 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LS800IWI7RBU9E0@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Wed, 28 Sep 2011 18:30:47 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 8D45A48087; Wed, 28 Sep 2011 18:30:47 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 82FF64808E; Wed,
 28 Sep 2011 18:30:47 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac4.idc.renesas.com with ESMTP id UAG04280; Wed,
 28 Sep 2011 18:30:47 +0900
X-IronPort-AV: E=Sophos;i="4.68,454,1312124400";   d="scan'208";a="47628485"
Received: from unknown (HELO relay51.aps.necel.com) ([10.29.19.60])
 by relmlii2.idc.renesas.com with ESMTP; Wed, 28 Sep 2011 18:30:47 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.97.223])
	by relay51.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id p8S9Ug3L009015;
 Wed, 28 Sep 2011 18:30:42 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 5F90952E23D; Wed,
 28 Sep 2011 18:30:42 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182304>

Junio C Hamano <gitster@pobox.com> writes:
> As a first step to remedy this, introduce a true boolean OPT_BOOL(), =
and
> rename OPT_BOOLEAN() to OPT_COUNTUP().

Hmm ...  "OPT_COUNTED"?

-miles

--=20
values of =CE=B2 will give rise to dom!
