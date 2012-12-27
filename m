From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Thu, 27 Dec 2012 18:35:06 +0100
Message-ID: <CALWbr2xmtvchR4G37-FzzgScKe4p4RjLc7=Pg8d4K6SWO7tGAQ@mail.gmail.com>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
	<1356528674-2730-1-git-send-email-apelisse@gmail.com>
	<7vip7omd8c.fsf@alter.siamese.dyndns.org>
	<20121227034859.GA20817@sigill.intra.peff.net>
	<7va9t0m69o.fsf@alter.siamese.dyndns.org>
	<CALWbr2wFg_9oDoZ_BUQwAzVV+UJSqBQRrMYmt6fv=fo02RL7Zg@mail.gmail.com>
	<20121227161920.GA28162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 27 18:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToHSs-0002Cy-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 18:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab2L0Rl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 12:41:29 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:48656 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab2L0RlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 12:41:25 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2012 12:41:25 EST
Received: by mail-qc0-f170.google.com with SMTP id d42so5136094qca.29
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1kVWXVsa3xLGIFxymcnEyEgtLOYskm/DResjhqqPvLk=;
        b=UZfiIbrQ0UNtJZIPTznNvPLgECwGXoaUectFKyWvTrIuSDk/XIPuB/x/y1ExRT3ats
         Xicuil7+iUdyra3MhLlVhkZOixhJI7H9OspqJ8APWblJWUz5kr6qiL/ya657xSEhre1U
         7UB/vh3Zgn2O8nJj2m4kHK0cOfruOrFB3bxptGoJjkEH0bicUA/FtMSXratVlQdmFI3G
         /3PnpaV7NGBPRXjmlUuCtAh22fV9PQCAoO4H/W49eIAswZ1njT0ZLFh6zIYpHIw+hv9V
         w3B1iQ5RQ9ud7yAlvGs+48vEg1TAJJWjXkEVww8wc4lfBsTNx4hsmSw5HwRmC4TJFUID
         hEeQ==
Received: by 10.224.73.6 with SMTP id o6mr14216935qaj.26.1356629707131; Thu,
 27 Dec 2012 09:35:07 -0800 (PST)
Received: by 10.49.11.233 with HTTP; Thu, 27 Dec 2012 09:35:06 -0800 (PST)
In-Reply-To: <20121227161920.GA28162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212206>

> By "committed", I assume you meat that you have "dirA/unco" as an
> untracked file, and "dirA/committed" as a file in the index?

Of course,

> Thanks for putting this together. I agree with the expected output in
> each case, and I think this covers the cases we have seen (case 1 is
> Michael's original report, case 2 is what I wrote in my mail, and case 3
> is the one you just came up with). I can't think offhand of any others.

Great, so I can build some tests reflecting those behaviors while
waiting more inputs
