From: Colby Ranger <cranger@google.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Mon, 1 Jul 2013 11:47:32 -0700
Message-ID: <CAFFbUKKm89n0HG6xUhYMLs_yjRJ8n0jFtOEEN=vXxJfWKLx5FA@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
	<CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
	<CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
	<7vtxkl28m7.fsf@alter.siamese.dyndns.org>
	<CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
	<CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
	<CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com>
	<20130627024521.GA6936@sigill.intra.peff.net>
	<CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 01 20:47:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utj8U-00065t-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 20:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab3GASre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 14:47:34 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:50687 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab3GASrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 14:47:33 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so2659873lbh.21
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yOAyH60WgGoU9ySEk70xmqSfP+ymec00opOTU4pIRlU=;
        b=g8SOatuM9qgyRfno3HvFZas73Hj5IGNU/htAPNHnFhbMdCpBpxZa37jZjxrAcpBuLK
         GIln4fWxGGLqWIFqk2h+Zy2vBW9mfU5eAfNhALWUxk3BZGBfqn07tzkhg7/VmQD9+LYB
         UY1enbh0DvWwITfHWdIgApOMefwwcaKlfBs9/eRTEwQu1dS7bndozjilPcrj1am9iZrk
         aDNKWM9vo9VUvWqb5NdY+WuWzOHQUqdSgHAhv1fIxrrhB9ua+gyX8cOuboOJ6m+sunME
         /P6p8z3aP0MVdeP/xjTLDOPee3Go36y5GCB62HrXHRuEHZugZoI9zETGogfEe2mB3s+8
         CnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=yOAyH60WgGoU9ySEk70xmqSfP+ymec00opOTU4pIRlU=;
        b=LOIS9jG1GzNRTAimd/dK3zzxMJNSsqluGMEH9JHbTLqxFJfwEQfxbeJRBtEG5BP5iH
         qea+zF9vi6+hwdZIsKt7ti5NylGadJPayAhIHCpzEFwzXSCwTvHsSTR3TrAOUbYIuEQw
         vfm24tvyzeGbFu6myjo+7xIp+Y8x3vdXdNgG6YTqVVmqjeQ/Pwa8B1L2aD3xdthokn3n
         wVTrNQKJWz/5DQhmYWaFyUSrmiCvu5KhesPqEvbephMHM6XoWq1JUN4nfH2sRkPUmZUP
         RyXeff3ZPY1zfqmbqBoiC3nyKoIC4C/J2asNXc6tKDkqbFiGiISTjwp+mVQFWhPZf8eh
         TWEw==
X-Received: by 10.112.150.201 with SMTP id uk9mr11600154lbb.61.1372704452320;
 Mon, 01 Jul 2013 11:47:32 -0700 (PDT)
Received: by 10.114.161.230 with HTTP; Mon, 1 Jul 2013 11:47:32 -0700 (PDT)
In-Reply-To: <CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
X-Gm-Message-State: ALoCoQnurCOBFjzIw60BxbTtYtaWYD/jHuDwRP/nplyLKpXQZLgar1qHFXnuhdBrbutrBXysLO8PGOw2tYGy/T+g+6sKvIOuafbTu+cKn9m2J/t4SE8xkTZhn0P0AdbsbfaWF2t28+vDjHgCAt+iW72WgCFaSxL22f9KROE/q+AmCIaksJmxN9njCD9ogxBQ/YzSxf7uDmBk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229318>

> Right, the format and implementation in JGit can do "Counting objects"
> in 87ms for the Linux kernel history.

Actually, that was the timing when I first pushed the change. With the
improvements submitted throughout the year, we can do counting in
50ms, on my same machine.

> But I think we are comparing
> apples to steaks here, Vincent is (rightfully) concerned about process
> startup performance, whereas our timings were assuming the process was
> already running.
>

I did some timing on loading the reverse index for the kernel and it
is pretty slow (~1200ms). I just submitted a fix to do a bucket sort
and reduced that to ~450ms, which is still slow but much better:
https://eclipse.googlesource.com/jgit/jgit/+/6cc532a43cf28403cb623d3df8600a2542a40a43%5E%21/
