From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 15:14:26 -0400
Message-ID: <CAPig+cQ-kmHeQsMMKdj0joSHWEnGfirSM1WbC-6G2BiMLnoUGg@mail.gmail.com>
References: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
	<vpqfuvju4km.fsf@anie.imag.fr>
	<xmqqtwjzn2nu.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQNBeBaLb-znNgxOanUz++pQLae=c8vUtFXjqxOns4d-g@mail.gmail.com>
	<xmqqegb3n1if.fsf@gitster.mtv.corp.google.com>
	<CAJPOeMediYQMwvgqhOquVh+KT61gdpUew9ernjuOYuf8By=hZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: elena petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5Nz-0002Kl-PL
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922AbcCUTVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:21:02 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33855 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673AbcCUTU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:20:59 -0400
Received: by mail-vk0-f43.google.com with SMTP id e185so226734376vkb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=jEKpC6M8P/JakeDMgd+WGsCYFUoQO/FRpgeFQ7a9WeA=;
        b=ZpkAy7+fD6ClHR7K9DaSw91MRCzfIyEPNqp20eZsV70ixtGCy2kDWddoCSWDaf0nVK
         MhIjLwTh+yjBetGKRFpOk+wGPcTcgP9GuSEkMrLnzV2Upa28EGJ6cHmlULZKyRRrJK4O
         7tJd9HtfEeTN6W2Et7eAPGPcpJPtXpm0Dx/YEIz3X1rY4dXFWQyCitCh+xwiACUVqYa5
         4meh9XnhEHbRBSQbxrHI3OTES/FFl+D7RcXAR+dSa3tBAp0DWw2e/8mdWTsGR2M6eXoZ
         FSjTXj2Wu49ZgSP955k+daBoeNn5ARUR77+IGpPYRMK7Z5fjmnWKuUElVSSJCB48Mhi5
         1yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jEKpC6M8P/JakeDMgd+WGsCYFUoQO/FRpgeFQ7a9WeA=;
        b=IfNSVU85W7AmF3sErn7/H3nvAUAKZ1nvv81FOGfXzPZVvjPARqUQZQ/VwnwZP4UCwk
         HPD5zXwvMQ+LsNr6miFlhatOc+9GC770Hnq37nAKXhswc7Wf615Rd5iE/ie89gCJl9tf
         E3efkjK9fiUhas9t+b+zRqL3oWOW/1ZAoSMah3wtJxewttM4Mviqc1VR8vQeVvHUwPQI
         JCu/shurG3XwtQj9oPHtiGsLjk7oBxUTUAxOcEJfrYx/3tY1s+MEg/35MS1k0vrG1wyK
         VF4FmgjfdG5ssTbRzj5g2eLxM78l41ps4eJaeyqW3MgVFYkqN3dfyr+sIkQTbC7ysZ+f
         RMIg==
X-Gm-Message-State: AD7BkJIUe4Y8jW8srEb54CpnxIXfxtc6Z0xQN87SvrQIU9S/bjWcdUyIj47+bH2rsMmHKvPClJhnFbSk0ejUUA==
X-Received: by 10.31.150.76 with SMTP id y73mr32914251vkd.84.1458587666513;
 Mon, 21 Mar 2016 12:14:26 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 21 Mar 2016 12:14:26 -0700 (PDT)
In-Reply-To: <CAJPOeMediYQMwvgqhOquVh+KT61gdpUew9ernjuOYuf8By=hZQ@mail.gmail.com>
X-Google-Sender-Auth: LN0-XLMPM8U3gcYqcpwIftKShjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289438>

[please don't top-post; respond inline instead]

On Mon, Mar 21, 2016 at 2:53 PM, elena petrashen
<elena.petrashen@gmail.com> wrote:
> Thank you for the feedback!
> The safety concert is indeed a good point. Would it maybe make
> sense to request user to confirm this operation? I.e:
> $git delete -D -
> You've requested to delete "foo" branch. Proceed with deleting? y/n

Rather than requiring the user to stop and answer a question, an
alternative would be to perform the deletion as requested but then
give advice about how to recover if the wrong branch was deleted by
mistake, much in the way advice is given when switching to a detached
head. (And, the advice could be suppressed by an "advice"
configuration variable similar to how other advice messages can be
suppressed.)

> Also, do you think - shortcut is justifiable for $git branch -m when
> referring to the "old branch"?

It comes up once in a while that I've switched away from a branch and
then decide I want to rename it, but it's infrequent enough that it's
difficult to say if it would be generally useful.
