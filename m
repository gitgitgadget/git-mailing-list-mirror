From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Fri, 13 Mar 2009 17:28:49 +0900
Message-ID: <buohc1xddxa.fsf@dhlpc061.dev.necel.com>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
	<7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
	<20090310100400.GC11448@pvv.org>
	<7v7i2v4x2v.fsf@gitster.siamese.dyndns.org>
	<20090312120109.6117@nanako3.lavabit.com>
	<20090312102243.GA27665@pvv.org>
	<buomybrqahe.fsf@dhlpc061.dev.necel.com>
	<20090312122047.GA14157@pvv.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: '@pvv.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 09:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li2nV-0005M3-0r
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 09:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZCMI3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 04:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbZCMI3q
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 04:29:46 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:34346 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZCMI3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 04:29:44 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2D8SbKA029317;
	Fri, 13 Mar 2009 17:28:49 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Fri, 13 Mar 2009 17:28:49 +0900
Received: from dhlpc061 ([10.114.114.241] [10.114.114.241]) by relay21.aps.necel.com with ESMTP; Fri, 13 Mar 2009 17:28:49 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 3C10452E276; Fri, 13 Mar 2009 17:28:49 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20090312122047.GA14157@pvv.org> (Finn Arne Gangstad's message of
	"Thu, 12 Mar 2009 13:20:47 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113158>

Finn Arne Gangstad <finnag@pvv.org> writes:
>> Presumably the push --track option would be used with an explicit branch
>> name given to push anyway, right?  Then it can use that info to set up
>> the tracking flexibly (and with sane defaults).
>> 
>> E.g.,, simple case:
>>     git push --track SOME_REMOTE BRANCH_NAME
>> 
>> complex case:
>>     git push --track SOME_REMOTE MY-BRANCH:REMOTE-BRANCH
>
> Yes, git push --track ... would typically do the same thing to the
> config as git checkout -b MY-BRANCH SOME_REMOTE/REMOTE-BRANCH, which
> is enough for push --tracking to do its thing.
>
> I am not sure if you mean that git push --track could do something
> extra to make --tracking unecessary for git push, currently it cannot
> do that since the push configuration is per remote, not per branch.

Hmm, now I'm confused... I was just thinking about --track, but am not
sure what --tracking is ... need to go grovel past posts...

-Miles

-- 
Happiness, n. An agreeable sensation arising from contemplating the misery of
another.
