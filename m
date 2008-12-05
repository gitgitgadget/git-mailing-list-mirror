From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Fri, 05 Dec 2008 01:16:09 +0100
Message-ID: <493872C9.9060600@fs.ei.tum.de>
References: <49382612.3010207@fs.ei.tum.de> <7vhc5jeo60.fsf@gitster.siamese.dyndns.org> <49385908.5020202@fs.ei.tum.de> <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org> <49386ABE.2050404@fs.ei.tum.de> <7viqpzbhvr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 01:17:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8ONw-0002mU-87
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 01:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbYLEAQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 19:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYLEAQP
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 19:16:15 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:60798 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbYLEAQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2008 19:16:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 7FE3C1C25E;
	Fri,  5 Dec 2008 01:16:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rQ1lWGyvrGbT; Fri,  5 Dec 2008 01:16:13 +0100 (CET)
Received: from [192.168.10.11] (dyn.144-85-212-018.dsl.vtx.ch [144.85.212.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 93DF21C0F0;
	Fri,  5 Dec 2008 01:16:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (X11/20081021)
In-Reply-To: <7viqpzbhvr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102380>

Junio C Hamano wrote:
> If that is the case, and assuming that propagating -C/-p would be a g=
ood
> idea (which I am not sure yet), the patch I sent out earlier (which w=
as
> flawed somewhat; it should use "$git_apply_opt_extra" where it invoke=
s the
> "git apply" command) with necessary fix would serve as the basis to
> implement --directory=3D<dir>?

certainly.  I'll be travelling, so don't expect anything real soon, wil=
l=20
resubmit unless I forget.

--=20
   <3 the future  +++  RENT this banner advert  +++   ASCII Ribbon   /"=
\
   rock the past  +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1 =
 +++     Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
