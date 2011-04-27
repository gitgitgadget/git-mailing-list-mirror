From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 14:32:20 +0300
Message-ID: <BANLkTi=-d+8ynv5NQ1SZA3V7PMiGiHauCw@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
	<BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
	<BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
	<BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:32:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF2yp-0003Ha-8z
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 13:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab1D0LcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 07:32:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58145 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab1D0LcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 07:32:22 -0400
Received: by fxm17 with SMTP id 17so1049316fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=udxdN7kNCbT2VZT3SR1jR79cuA7avozSE2MZfJkv7kw=;
        b=rDYtiJTi1UsIBbj2Y3EyKdd+0rAETh0lGZBsYprA7Ud3psXHmTQwHVOmTr9mtfGaFD
         RDGKUCYS/TXWItQkB0LayWISmzmMsa8lYUDXqDYrtwp5t44v8SBubt1axO8b/0KtITgp
         kL7NUgWz7FMf5IZg8CNgZFGJ8cF4+ZETQLmsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=V+PfMnxFjY6k8iGp9TGGFEHOA4baVb6p7jEvd6CjpHwCRce8kzVt3cEXn2Q2R8ZywX
         W0CPmLpiWg1kuib7EmIty8TojkKDdmiVDquwtkaXFs4sMTPiZ65QZkVBBpTwBB0O52PD
         sQbo5DqPSoBANIjaAPNQ8AhaITuVuioQhrj6Y=
Received: by 10.223.110.21 with SMTP id l21mr377338fap.70.1303903940743; Wed,
 27 Apr 2011 04:32:20 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 04:32:20 -0700 (PDT)
In-Reply-To: <BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172221>

On Wed, Apr 27, 2011 at 2:29 PM, Stephen Kelly <steveire@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 11:48 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> No problems here:
>
> I had another go.

And is that the expected behavior or not? BTW. I used 1.7.5.

-- 
Felipe Contreras
