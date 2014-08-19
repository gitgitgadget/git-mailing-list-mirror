From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 15:18:17 -0500
Message-ID: <CAHd499Ad3T1sHQWwE9NNySTbfaL_UvcdX4qrWkhH2PYhet=hMg@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<20140819102421.GA5012@book.hvoigt.net>
	<CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
	<xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
	<CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
	<xmqqoavguw26.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 22:18:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJprS-0008NP-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 22:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbaHSUSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 16:18:20 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:65138 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbaHSUSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 16:18:18 -0400
Received: by mail-vc0-f172.google.com with SMTP id im17so8062931vcb.17
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1Z5IGGM+idGxmZvIOea2M+gcFdoovH6OsONFfzDrrP8=;
        b=Sy9a/ZeQZsgdGEytrPtZyRbYgzr8gSsTH2GTYDBpXV6+cqpLTftNaMmssTgpxrp2Wt
         hYL9tWOOZtPDEZ20L0Ge9BIGpibbp4WTq2KxAitx891EhtRFCKSPSMPn+Eg1Smfoe0wr
         InX4i3rSZrPO6TXQTMqYNH6qDl69nicXFDwUIrEmHwpgolJIZelrnlqZaGRyUxW7iPK5
         jYiSYHgJKBD0m+LYaKudPsAccYWCIqqtaL824oR1YZG9qT7eHpx8ZT3ibPx1kRN3FZHn
         M0Ag9WcAQCQx9NVBI8Q5P9UxCXk5rMJXAMgSFjwaLsFfPs+WrWpryYJlpgMbrKwnoquU
         T+gg==
X-Received: by 10.220.74.195 with SMTP id v3mr32222155vcj.23.1408479497283;
 Tue, 19 Aug 2014 13:18:17 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Tue, 19 Aug 2014 13:18:17 -0700 (PDT)
In-Reply-To: <xmqqoavguw26.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: tvWFvkNSrOTlecMqXA6VwYHKfW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255515>

On Tue, Aug 19, 2014 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I do not know if that is how GitHub teaches people, but I would have
> to say that these are strange phrasing.  I suspect that part of
> their documentation was written long time ago, back when nobody on
> the GitHub side were involved in design (let alone implementation)
> of Git, and I would take it with a grain of salt.
>
> Having said that, here is a summary of the current support for
> referring to different repositories in Git:
>
> <snip>

Wow, that was a very good read. Thank you for that. I definitely have
been using the wrong terms. upstream & origin are interchangeable, yet
I was using them to represent two distinct repositories.

I think going forward my central repository will be named 'origin' and
for the name of the second, nothing has really jumped out at me yet
but it'll either be "fork" or "proxy"... "surrogate" would be nice too
if it wasn't such a long word in comparison.

I'm sure you guys will find a name for it in good time. I wonder what
Linus would suggest.
