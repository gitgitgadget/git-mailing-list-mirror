From: Miles Bader <miles@gnu.org>
Subject: Re: Git is exploding
Date: Wed, 02 Nov 2011 13:51:31 +0900
Message-ID: <buo8vnzgm98.fsf@dhlpc061.dev.necel.com>
References: <CAA787r=jeBv9moineaJVY=urYzEX+d7n23ED-txAGhLS+OPbmg@mail.gmail.com>
 <vpqfwi8tary.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?=D8yvind_A=2E_Holm?= <sunny@sunbase.org>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 02 05:51:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLSnf-0006DV-2l
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 05:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab1KBEvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 00:51:38 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:48041 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1KBEvh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 00:51:37 -0400
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LU000J01O60CU80@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Wed, 02 Nov 2011 13:51:36 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LU000IBLO6002F0@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Wed, 02 Nov 2011 13:51:36 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id D649528088; Wed, 02 Nov 2011 13:51:35 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id D0E8428076; Wed,
 02 Nov 2011 13:51:35 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac2.idc.renesas.com with ESMTP id PAG13561; Wed,
 02 Nov 2011 13:51:35 +0900
X-IronPort-AV: E=Sophos;i="4.69,441,1315148400";   d="scan'208";a="53108115"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii2.idc.renesas.com with ESMTP; Wed, 02 Nov 2011 13:51:35 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.50])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pA24pX19019112;
 Wed, 02 Nov 2011 13:51:33 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 2A26A52E1F5; Wed,
 02 Nov 2011 13:51:32 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <vpqfwi8tary.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184611>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> The recent rise is essentially due to the git-core package renamed to
> git, and people doing updates:

The renaming would obviously explain the extreme initial steepness of
the rise, but it shouldn't have much effect on the absolute values or
the more recent numbers.

[Look at git-core+git, basically it makes the initial part of the
graph fill in a bit, getting rid of the weird kink and making it more
smoothly exponential but doesn't really change the conclusion.]

Probably the main distortion is just the fact that it counts Debian
users ... subversion has a lot of stodgy corporate users etc that are
unlikely to use Debian!  :]

--Miles

-- 
Twice, adv. Once too often.
