From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC] Week 1: Unification of 'for-each-ref', 'tag -l' and 'branch
 -l'
Date: Thu, 04 Jun 2015 13:05:22 +0530
Message-ID: <556FFFBA.4030004@gmail.com>
References: <556DDC21.5050801@gmail.com> <vpqh9qoepv1.fsf@anie.imag.fr> <20150603210833.GA32181@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 09:35:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Pgf-0002Vh-Ar
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 09:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbbFDHfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 03:35:32 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36862 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbbFDHf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 03:35:29 -0400
Received: by pdjm12 with SMTP id m12so25130136pdj.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5E0POYdiioI+WwwObQz8z/BXbhXCAnEjOgynlbNBtNc=;
        b=AKnaWVzr3N/sn3BwrSLQ967/AHr0M36GiUeRb6OMxb8Mojg8+eg2Tmu5eMXrD26AVN
         l6w3YcJAnNi11/bEqdBXXUYLW1Hu7wdrDrFMPM5696x78uxkAZFI1R8S2iN078vCJxL/
         F4hgxhHPLjmA2u3QN+86STk9bkiUnPMNm8e/yvdsUB0GbmQx+wSWy8BP7jbdN7mEx5dY
         KlSe7EsyqcKGv18AGFeC5S0CpEI63lmOfmnsceyTp1d6ekTiFvYdcQU/dIL8ZAdSvW56
         3wMzF7gn6SanvCYSqpAAVlNcTqNXmZMey0ZxJUkZN0up9fYbVfL7OCeAagLnnc+n4Bnr
         oa9A==
X-Received: by 10.66.168.11 with SMTP id zs11mr67908255pab.138.1433403328412;
        Thu, 04 Jun 2015 00:35:28 -0700 (PDT)
Received: from [192.168.0.109] ([103.227.99.94])
        by mx.google.com with ESMTPSA id jx5sm2752533pbc.85.2015.06.04.00.35.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 00:35:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150603210833.GA32181@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270751>

On 06/04/2015 02:38 AM, Jeff King wrote:
> On Wed, Jun 03, 2015 at 06:08:50PM +0200, Matthieu Moy wrote:
>
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> >> Matthieu Moy suggested that I work on the unification of these
> >> commands let both the implementations stay where the user can select
> >> the implementation to be used
> >
> > Just to be clear: my advice is the above with "user" = "caller of the
> > API", not "human being using Git". In other words, "git branch
> > --contains" and "git tag --contains" would still be using two different
> > algorithms, but the user wouldn't notice (except for performance).
>
> Yeah, I think that is sensible. It should be a "feature" of the
> ref-filter that can hopefully go away one day (when we have a sensible
> implementation that works for both; this is something I've been meaning
> to push forward, but Karthik should not have to wait on me).
>
> -Peff
>
Sounds good, Thanks Jeff.

-- 
Regards,
Karthik
