From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Git commit generation numbers
Date: Thu, 28 Jul 2011 18:00:48 +0300
Message-ID: <CAMP44s2F429MG5DeRAULnSgNkCwrVGPfC2HeFw=iHXPXjkw0yA@mail.gmail.com>
References: <20110721202722.3765.qmail@science.horizon.com>
	<alpine.LFD.2.00.1107220907370.1762@xanadu.home>
	<alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
	<201107222034.20510.jnareb@gmail.com>
	<CA+55aFzsZ6w_a_wPEuBjtDeSDYQviVfy9UmJMxPz4geu4CRthQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, david@lang.hm,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 28 17:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmS51-00058B-Kt
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 17:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab1G1PAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 11:00:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63808 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab1G1PAu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 11:00:50 -0400
Received: by fxh19 with SMTP id 19so1344597fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wUOvdtDJtAnPdILXhCTrZt9d+RAtZB0lQxLRUKMCFGA=;
        b=TB1jTNxbJmFeJZ3DepLqSoY5+6p2qDLaxN2wN5UH6YGOjlAjMyc5ocNihyG4eUV4IX
         SaPleZ90/ftxuNxCZ5R4bnm5Nhlx735uluV4sp7o04OZZ3FVwisyvg+xoAFIo1CA432f
         /oiWVcxxMpB1lrzR0LMtkTdQ0oHKnNopMn9+c=
Received: by 10.204.157.10 with SMTP id z10mr33225bkw.347.1311865248830; Thu,
 28 Jul 2011 08:00:48 -0700 (PDT)
Received: by 10.204.56.15 with HTTP; Thu, 28 Jul 2011 08:00:48 -0700 (PDT)
In-Reply-To: <CA+55aFzsZ6w_a_wPEuBjtDeSDYQviVfy9UmJMxPz4geu4CRthQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178069>

On Fri, Jul 22, 2011 at 10:06 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jul 22, 2011 at 11:34 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>
>> That is IF unknown headers are copied verbatim during rebase. =C2=A0=
=46or
>> "encoding" header this is a good thing, for "generation" it isn't.
>
> Afaik, they aren't copied verbatim, and never have been. Afaik, the
> only thing that has *ever* written commits is "commit_tree()"
> (originally "main()" in commit-tree.c). Why is this red herring even
> being discussed?
>
> Of course you can always generate bogus commits by writing them by
> hand. But that's irrelevant.

Let's suppose for a moment that the commits do have these wrong
generation numbers, shouldn't a fetch on the newer client check these
and show an error? But what if they are pushed to a central server
that has old version of git? It would be messy.

--=20
=46elipe Contreras
