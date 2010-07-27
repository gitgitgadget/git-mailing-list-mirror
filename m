From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 23:32:58 +0200
Message-ID: <4C4F508A.8050200@web.de>
References: <4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> 	<AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> 	<4C4DB9AC.9000306@xiplink.com> <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com> 	<20100727182841.GA25124@worldvisions.ca> <7vaapc7jv8.fsf@alter.siamese.dyndns.org> <AANLkTim0A0MAmpgAiaYSgYO=YbZ2gc4Upx3MQQopx6DG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Branchaud <marcnarc@xiplink.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:33:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odrlr-0006wQ-KB
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab0G0VdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:33:01 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39157 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0G0VdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:33:00 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0AE0C1650C701;
	Tue, 27 Jul 2010 23:32:59 +0200 (CEST)
Received: from [80.128.76.222] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Odrli-0003Nj-00; Tue, 27 Jul 2010 23:32:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <AANLkTim0A0MAmpgAiaYSgYO=YbZ2gc4Upx3MQQopx6DG@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Ht7U2zRUHnE5aI9kUg1u7T7D4ayq0wQKhirkO
	srrff5wrNa9+hh7P16CIAyn9m6KYJlQUjzWD9DojFvow6NoqoU
	OSHdG/jGguAuw+QoZekg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152006>

Am 27.07.2010 22:57, schrieb Avery Pennarun:
> One problem with this line of reasoning is that "--recursive" is
> always an option.  But if submodules are ever to be easy to use, I
> think it should be the default (or settable as a default using git
> config).  This would take us a *long* way towards usability (of
> course, in addition to adding the missing features, as you mention).

And that is exactly what I am currently doing:

- I already teached diff and status to always recurse (and just
  sent a patch to add a config option for that behavior, as some
  users either can't pay the performance costs or don't want to
  see submodules show up as modified just because they contain
  untracked files).

- I posted a WIP patch doing recursive checkouts (that is basically
  working but I still have to put in the safety checks so that no
  modifications to submodules are accidentally discarded unless -f
  is used).

- I am working on a recursive fetch too.

And then there is other stuff on my list to be tackled; I try to
fix these issues so that the most annoying problems get solved
first.

Unfortunately that does not proceed as fast as i wished, but
hopefully I can show some progress in the near future. Of course
any help would greatly be appreciated ;-)
