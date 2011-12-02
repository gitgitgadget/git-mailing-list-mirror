From: Miles Bader <miles@gnu.org>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Fri, 02 Dec 2011 16:45:34 +0900
Message-ID: <buowrafxvq9.fsf@dhlpc061.dev.necel.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
 <201112020826.14114.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Hord <phil.hord@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 02 08:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWNpa-00020I-Mv
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 08:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab1LBHqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 02:46:46 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:46524 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1LBHqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 02:46:45 -0500
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LVK001BGG847VD0@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Fri, 02 Dec 2011 16:45:40 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LVK00KATG7Z7Z50@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Fri, 02 Dec 2011 16:45:40 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id F36BC800A2; Fri, 02 Dec 2011 16:45:39 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id DDD1E80086; Fri,
 02 Dec 2011 16:45:39 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac1.idc.renesas.com with ESMTP id SAA09119; Fri,
 02 Dec 2011 16:45:39 +0900
X-IronPort-AV: E=Sophos;i="4.71,282,1320591600";   d="scan'208";a="57583440"
Received: from unknown (HELO relay61.aps.necel.com) ([10.29.19.64])
 by relmlii1.idc.renesas.com with ESMTP; Fri, 02 Dec 2011 16:45:39 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.98.178])
	by relay61.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pB27jYkf006705;
 Fri, 02 Dec 2011 16:45:35 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 985E552E21D; Fri,
 02 Dec 2011 16:45:34 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <201112020826.14114.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186211>

Thomas Rast <trast@student.ethz.ch> writes:
>> > I remember them as:
>> > --soft      -> git uncommit
>> > --mixed  -> git unadd
>> > --hard     -> git undo
>> 
>> I don't particular like these names, but conceptually they are helpful.
>
> I think all of these, but the last one in particular, are *very*
> dangerous oversimplifications.  Doubly so if you then use "undo" with
> a revision argument.

I agree.  Not only is it completely wrong when used with a revision
argument, but "undo" is so vague that it's probably useless for _any_
git command, much less one so dangerous as "reset --hard".

-miles

-- 
Friendship, n. A ship big enough to carry two in fair weather, but only one
in foul.
