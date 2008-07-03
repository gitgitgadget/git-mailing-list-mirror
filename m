From: Wincent Colaiuta <win@wincent.com>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Thu, 3 Jul 2008 15:37:30 +0200
Message-ID: <08353871-5C94-4E97-9589-DC3980C47CD4@wincent.com>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com> <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr> <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr> <7vtzflolis.fsf@gitster.siamese.dyndns.org> <7vtzfln5zw.fsf@gitster.siamese.dyndns.org> <20080703021541.GK18147@mail.rocksoft.com> <alpine.DEB.1.00.0807031303080.9925@racer>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Stoakes <tim@stoakes.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEP1j-000770-Gq
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 15:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYGCNiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 09:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYGCNiK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 09:38:10 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:34193 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbYGCNiK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 09:38:10 -0400
Received: from cuzco.lan (249.pool85-53-23.dynamic.orange.es [85.53.23.249])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m63DbVOK020470
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 3 Jul 2008 09:37:33 -0400
In-Reply-To: <alpine.DEB.1.00.0807031303080.9925@racer>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87290>

El 3/7/2008, a las 14:11, Johannes Schindelin escribi=F3:

> Hi,
>
> On Thu, 3 Jul 2008, Tim Stoakes wrote:
>
>> This [changing git status to use the pager automatically] was quite =
a
>> nasty change to sneak on people I think.
>
> Well, I think that a command producing pages and pages of output =20
> without
> stopping is useless.  Therefore, _I_ maintain that it makes tons of =20
> sense.

Ditto. For me, the change was very welcome. Sure, usually the status =20
output is short, but on those occasions where it isn't (big file =20
reorganizations etc) I was quite sick of doing the "git status, oops =20
that output was too long let's try again, git -p status" dance. It was =
=20
also incongruous with my very first experiences with Git, where I had =20
been pleasantly surprised that "git log" automatically invoked the =20
pager whereas "svn log" just spewed output into my console until ^C.

Cheers,
Wincent
