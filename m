From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH 1/1] git-send-email: Add a --suppress-all option
Date: Tue, 18 Sep 2007 10:39:37 -0400
Message-ID: <31e679430709180739xf2eaa32i8233059fbfb38f12@mail.gmail.com>
References: <11900540373215-git-send-email-felipebalbi@users.sourceforge.net>
	 <46EF8107.1030607@op5.se> <20070918132251.GB12120@fieldses.org>
	 <86bqc03vrq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 16:39:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXeEr-0000qt-1m
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 16:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbXIROjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 10:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbXIROjj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 10:39:39 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:15038 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303AbXIROjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 10:39:39 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1140631nze
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=jfRPsurfwphbiPRvwJ5DFgnVOBA/Q3yVTAlOp2RCpik=;
        b=HqDUC6w9s8rqeq/5Km2YTBwSbCu41/Txg0WETHT/LaAIdxhCaYL5/SyzYtKzGuILkfSfxYUlvdsGW4APOGz9SKFdsOGd3xeSGkCpJWVHVRZQikaYxGlE0jarh8R36dDa8enn7/f4SRheij0XDxN+UI4MnUmXLuFKZC2oOPbirCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lFnK6zHmNMBFd600LW8yGw8GZpwvkVKteCKB4uLB4clAmxvHk8X9HWhc8oUkQpSMr3Y8WsuznRXqSoqo2eDGv+LGel4c0RH1ISfzciIN3SZ63Sryc9an2x3wx473mHeNl2Z84/8kLv1DpWAn3xaLsqpiZRBIjrrP+MqYfbIseUI=
Received: by 10.114.52.1 with SMTP id z1mr2627112waz.1190126377862;
        Tue, 18 Sep 2007 07:39:37 -0700 (PDT)
Received: by 10.114.61.4 with HTTP; Tue, 18 Sep 2007 07:39:37 -0700 (PDT)
In-Reply-To: <86bqc03vrq.fsf@lola.quinscape.zz>
Content-Disposition: inline
X-Google-Sender-Auth: 87cc3187c3f39a3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58615>

Hi,

On 9/18/07, David Kastrup <dak@gnu.org> wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
>
> > On Tue, Sep 18, 2007 at 09:40:55AM +0200, Andreas Ericsson wrote:
> >> Felipe Balbi wrote:
> >>> From: Felipe Balbi <felipe.lima@indt.org.br>
> >>> This patch adds a --suppress-all option to avoid sending emails
> >>> to everybody but the ones listed by --to option.
> >>
> >> To my minds eye, --suppress-all is equivalent to --dry-run. Could you
> >> rename it to "--cc-nobody" or some such?
> >>
> >> On a side-note, I've never really understood why git-send-email *by
> >> default*
> >> sends to a bazillion people. Does anybody ever use it without suppressing
> >> most of the CC targets?
> >
> > Yes.  I never suppress the cc's.  The cc-everyone thing is standard on
> > the kernel mailing lists.
> >
> > The one exception is if I'm just sending the series to myself as a test.
>
> Wouldn't --no-cc be a nicer option name?

It'll probably conflict if I don't wanna CC patch's author nor
Signed-off-by but DO want to CC somebody special like the maintainer.

the option is changed to --cc-nobody and it's already resent. :-)

>
> --
> David Kastrup
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
