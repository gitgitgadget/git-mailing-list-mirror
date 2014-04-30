From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Wed, 30 Apr 2014 10:22:30 +1000
Message-ID: <CAHYYfeGhkef9MgA56r2gMcnFjbC_bsJrvR2pPgjiuWLSU1MnCA@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
	<87bnvl6bdg.fsf@fencepost.gnu.org>
	<535e8e4253196_45651483310b3@nysa.notmuch>
	<152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
	<535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
	<CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
	<535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
	<220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
	<535f62c1e740a_45e485b30887@nysa.notmuch>
	<87r44g33z4.fsf@fencepost.gnu.org>
	<535f702352d21_3aee3b2f0b9@nysa.notmuch>
	<87mwf431t3.fsf@fencepost.gnu.org>
	<535f76db38a34_6f23159b31099@nysa.notmuch>
	<87eh0g30it.fsf@fencepost.gnu.org>
	<535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
	<752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com>
	<535f915e3ed89_2719108f30817@nysa.notmuch>
	<514ff3d6-aea5-4b1d-8ff4-14e779876fb1@email.android.com>
	<535fa9b15a495_6d5dff2f0e0@nysa.notmuch>
	<e31d0160-c7e1-4e80-93bb-d1da590eb8b5@email.android.com>
	<53601d818409d_2f8c107d31055@nysa.notmuch>
	<e904f1b8-56eb-4584-9f2e-5a842c870aa0@email.android.com>
	<53603042d6e18_c48df1308b9@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 02:22:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfIIG-0005id-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 02:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbaD3AWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 20:22:32 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:41343 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637AbaD3AWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 20:22:31 -0400
Received: by mail-ve0-f176.google.com with SMTP id db11so1241286veb.35
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 17:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MDAET+ly3Yr29dPRoB2z9E8LsY1hc5ngpUyKlKzBebw=;
        b=ppLXsw7iDIdg+bu7UQkRbQic/s4yVlZvX548p9fpCgbJtSOVYzKhpYlbAkeWfdr5/I
         L220IdNXfDT3cOoXd7q2TKVivlgw2CI73/a4jGgh9N8X3oJSFctXnGo38uBtyGU4YHvZ
         AgdMLBWBnGQHbgk4No3RRWSm3qi+7LNpNFCgxVoLN6FCcgfW3eIiPhwyzFo1qmoxVUEI
         jxGjnTaNMFey/oDKd3l4UediGcOTwNHMfOj6oElXlQ1HHskITI4cdugqVJUGvMnEdA+w
         Z1kwD1UEJcLFplGvIPEgRuAYr1I/okvn/JhcL45OA5qsvkpaG5+P4KDIj7EoluvUbgK7
         rwJA==
X-Received: by 10.220.184.72 with SMTP id cj8mr838331vcb.10.1398817351057;
 Tue, 29 Apr 2014 17:22:31 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Tue, 29 Apr 2014 17:22:30 -0700 (PDT)
In-Reply-To: <53603042d6e18_c48df1308b9@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247668>

Felipe Contreras wrote:
> James Denholm wrote:
>> > Either way your analogy is completely wrong as I already explained
>> > multiple times. I'm not trying to convince vegetarians to go
>> > hunting, I'm saying they should eat something, bread, meat,
>> > vegetables, anything. Instead they choose to starve to death.
>>
>> I'm the meantime, the community decides that some of your proposals
>> aren't good ideas, and decide to consider others in due course.
>
> Wrong. The problems are ackowledged, no other proposals are put forward,
> nothing gets done.

So I'll ask again - you've described frustration at the
pace of git development, and that you feel that your patches
aren't being accepted. If you feel that this is ultimately to the
fatal detriment of git, why are you still trying to convince
vegetarians to join you in hunting when you could simply find
a more willing group?
