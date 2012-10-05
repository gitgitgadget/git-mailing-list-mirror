From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Fri, 05 Oct 2012 16:15:39 +0200
Message-ID: <m2y5jlyph0.fsf@igel.home>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
	<CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
	<7vbogj5sji.fsf@alter.siamese.dyndns.org>
	<506D5837.6020708@alum.mit.edu>
	<7vobki19ax.fsf@alter.siamese.dyndns.org> <m2391t1589.fsf@igel.home>
	<vpqpq4x14ox.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 05 16:15:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK8h0-0002Eg-2f
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 16:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab2JEOPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 10:15:43 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40975 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab2JEOPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 10:15:42 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XYCg02wmHz4KK3f;
	Fri,  5 Oct 2012 16:15:40 +0200 (CEST)
X-Auth-Info: XX9STeoMe7BedSwPIg90NiUfZDPCkvMuZOjTHPxVGkk=
Received: from igel.home (ppp-93-104-156-246.dynamic.mnet-online.de [93.104.156.246])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XYCg01cl5zbbhK;
	Fri,  5 Oct 2012 16:15:40 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id DE237CA2B7; Fri,  5 Oct 2012 16:15:39 +0200 (CEST)
X-Yow: After THIS, let's go to PHILADELPHIA and have TRIPLETS!!
In-Reply-To: <vpqpq4x14ox.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Fri, 05 Oct 2012 14:30:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207107>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> When we require "x/**/y", I think we still want it to match "x/y".
>>
>> FWIW, in bash (+extglob), ksh and zsh it doesn't.
>
> You're right about bash, but I see the opposite for zsh and ksh:
>
> zsh$ echo x/**/y
> x/y x/z/y
>
> ksh$ echo x/**/y
> x/y x/z/y

Looks like this is different between filename expansion and case pattern
matching (I only tested the latter).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
