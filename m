From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git rebase -i does not rebase if all lines are removed
Date: Tue, 17 Jul 2012 14:25:15 +0200
Message-ID: <500559AB.9000304@viscovery.net>
References: <CAGHpTBKn+avCrWegktoJRurG+oycq6Sb9CiRDCBQG=hSMUkjiA@mail.gmail.com> <1342522535.20671.7.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 14:25:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr6qE-0002es-80
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 14:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab2GQMZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jul 2012 08:25:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50075 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab2GQMZU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2012 08:25:20 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Sr6ri-0002RK-Ly; Tue, 17 Jul 2012 14:26:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CB0EE1660F;
	Tue, 17 Jul 2012 14:25:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1342522535.20671.7.camel@centaur.cmartin.tk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201602>

Am 7/17/2012 12:55, schrieb Carlos Mart=C3=ADn Nieto:
> But more important would be /why/ you feel that rebase -i is the tool
> you should be using. If you'd like to move the branch pointer back,
> that's what the reset command is for.

Perhaps because that's not what the OP wanted to do?

Sometimes it happens that you rebase a bunch of commits, and only a
handful remains because the others are already in upstream. Looking at
each remaining one closely, you decide that they don't have to be rebas=
ed
(maybe because slightly modified versions are in upstream), so you remo=
ve
them one by one, and you end up with an empty list.

This has happened to me at one point, and writing "noop" after the list=
 is
empty is a minor nuisance. But I am not complaining. Because being able=
 to
abort an interactive rebase by clearing the list is much more important=
=2E

-- Hannes
