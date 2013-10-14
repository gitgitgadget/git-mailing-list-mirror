From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My patches
Date: Mon, 14 Oct 2013 16:40:59 -0500
Message-ID: <525c64ebe2390_197a905e84c@nysa.notmuch>
References: <20131012072450.GA21165@nysa>
 <xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 00:08:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqJI-00072n-OA
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab3JNWIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:08:14 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:49668 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3JNWIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:08:13 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so4086910oag.17
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ca3Z3WJwx3bIRv2dKIMVpEcNo0DQuWsPErlk1DhiQWA=;
        b=reVcydjxSHPf8F6+OBJeO3gbPxzg0N1mA1VaMZb3jjXjTr0dcuLoh7BTk0n1i5935X
         lZCccpN3D0cDs0E2rbaVA8Z2kREO8URQ2KWZl64PWC804qqmMj1axU4btE5L+PoXeA7k
         nPmYdLRRk0JCs3gRaizRO6cLqT1S09nrvzNfDs2GkgPSjyJAb+IYfqwqfUfpmJl6YhXQ
         BRSbFJd7tUB7nBUz3X7o9Ej0LYmPDFgiRz29Z+fhki+/7TF9rYHYHT4+Z84tcvCKmiNX
         aci7yhvfqcoKUl3VtotonsVe2vOiW2vdTw3v3sJ/4JalUuKf48UQCvvsmluiLzsrD7CT
         EVZg==
X-Received: by 10.60.76.72 with SMTP id i8mr30006541oew.11.1381788492674;
        Mon, 14 Oct 2013 15:08:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm121700357oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:08:11 -0700 (PDT)
In-Reply-To: <xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236123>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Clearly, a lot of my patches have not been reviewed ...
> 
> I think the reason for it most likely is because you earned the Bozo
> bit ($gmane/227602) in many reviewers' eyes.

So what you are saying is that the reason is entirely personal, not technical.
Is that correct?

However, it is funny how Theodore Ts'o is saying so in that mail, yet at the
same time he is actively engaged in at least two discussions started by me in
two different projects (Linux and isync) just last week.

> I phrased it differently ($gmane/233347) at the beginning of this
> cycle,

You said:

---
It seems that Matthew is trying to see if you can work better with
others than before after a break, but I personally am not hopeful
yet and do not want to waste my/our time on flamewars like we saw in
the past.
---

By which you presumably are referring to this patch series:

http://thread.gmane.org/gmane.comp.version-control.git/233295/focus=233306

It seems to me there's no negative fallout from that thread, and Matthieu Moy
still thinks this is a good series, yet you haven't applied it, or even
commented on it.

> but I'll say it one more time. I'll refrain from responding
> to your messages with anything other than "looks good, thanks". A
> patch from you that I do not understand the motivation behind it, or
> a patch from you that attempts to solve a problem I see better ways
> of solving the same, will not see the usual response from me that
> requests a clarification (in the resulting code or in its
> explanation in the proposed commit log message) or suggests an
> improvement or an alternative.

So, what you are saying is that if none of my 160 patches have been picked yet,
it means you will not be picking them, even though you are not explicitly
saying so. Is that correct?

Even if other Git developers agree it's a good change, you will not be picking
them. Correct?

> Such a review comment and the discussion that follows it after a
> patch is posted is an essential part of the collaborative
> development process in this community and it has helped the quality
> of our end product. We unfortunately saw time and again that the
> process rarely works when the discussion involves your patches.

No, you did not. What you saw was a person that unlike a trained dog, argued
against you. And apparently your definition of a good discussion is one in
which the other person just does what you say, and doesn't argue back.

Let me be clear; what I did is provide arguments against your arguments, which
means all I did was disagree. That is all.

> I haven't caught up with the list traffic yet, but the way the
> discussion that followed a recent review ($gmane/235936) progressed
> tells me that things haven't improved much, so the assessment above
> still seems to hold true, at least to me.

I applied the change requested in ($gmane/235936), so there is no more comments
left on that series, there's nothing that prevents that series from being
picked, yet it's not.

Presumably you have a problem with that series, but you haven't spoken, and you
won't, even though it's not just me that is waiting for a response, but other
Git developers (and users) who are interested in moving this forward.

Anyway, I spent a lot of time working on those 160 patches, I would appreciate
if you could respond to this single question:

Are the patches going to be applied? Yes or no.

-- 
Felipe Contreras
