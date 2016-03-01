From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: GSoC 2016 Microproject
Date: Tue, 1 Mar 2016 13:22:28 +0100
Message-ID: <20160301122228.GL1831@hank>
References: <56D19EF9.3070702@gmail.com>
 <vpq8u26qo3y.fsf@anie.imag.fr>
 <56D1BEC8.9010302@gmail.com>
 <vpq1t7yqgi4.fsf@anie.imag.fr>
 <56D2C828.6010901@gmail.com>
 <vpqpovfblru.fsf@anie.imag.fr>
 <56D46493.4040909@gmail.com>
 <vpqfuwbbjlx.fsf@anie.imag.fr>
 <56D57F4E.7000402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 13:22:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aajJd-0005KZ-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 13:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbcCAMWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 07:22:09 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37489 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbcCAMWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 07:22:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id p65so30955444wmp.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 04:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RP3ay2KGeMTLRoCPf2Nd+QW5uzpEKW12Ls+kEKjidLs=;
        b=uEDc9jM+y7v0LrfDiArKdPSYGAfwcajZSBEOJqvQfNm5Nhvw3VzhG8dvmDWDW63g5h
         wesVPO7zQl8EL+SzjM0mbVFjIh15nzWkbqo1IvICgkkUC0Y6lu1shakXXwG35mSL7UxD
         1Sbdoxo+s6P+h/Ic4vJmt5ajnqBPKBW6+XO/rDKZpfm3g8S/A6sJp/EYUiVt8CuKLZdI
         b5jBahJHzMIHeHliMK800Z6qIpxiTDZ0z9wupv8LbUx+6iSGfQ0CwHSGM8FVVxl+cgIp
         Ivg6OtXHCzhIhedCH4SMqDCU0C9JBqASH/Xr2+oNAaWcMxqWjyaCawuG1gPc1Qe5R/HW
         fxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RP3ay2KGeMTLRoCPf2Nd+QW5uzpEKW12Ls+kEKjidLs=;
        b=Gnn2RWye/zy1p9SnJP8NcLCvxWcbAtmXHQ2mIbioLX+lmPpV11c4NqQChbjqiT/MSU
         Zqv6VHrXoy6fQFFjxpyb1a3nM+I7u2Ko4UaSP3M/nvA5TKC+BdhsffjMVxYxoBJ+/b4y
         B+XRpzSAlF6dL0QKcGgeFKtogVC2JHYgli2sBxijGwa7TBYnwNr9O9JymTf5lclsl9l+
         u48dJMs7gNn2eS3vfPcoRnT4O4aFkzLVZ4N2nwmziSWjJWHF2wTuCs+XFZcv8TVus/Ke
         y4m6GaoFI1bjQRBP7B72yu7QwRpb8jXSOrQ4Bu8LeCY19SXUKFliZOuRFAEZ52xGLIdO
         JLUg==
X-Gm-Message-State: AD7BkJIAFs/SQW8S7LXdMkAmJ14LeOZptmIubXBGtSShBJBhsF3cJu4xTiBat2n/i9i1Uw==
X-Received: by 10.28.146.209 with SMTP id u200mr3200317wmd.59.1456834926915;
        Tue, 01 Mar 2016 04:22:06 -0800 (PST)
Received: from localhost (host95-109-dynamic.249-95-r.retail.telecomitalia.it. [95.249.109.95])
        by smtp.gmail.com with ESMTPSA id 8sm21146371wmk.13.2016.03.01.04.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 04:22:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56D57F4E.7000402@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288011>

On 03/01, Sidhant Sharma wrote:
>
> > If you use PARSE_OPT_HIDDEN, I think you don't need to specify a message. Otherwise, the documentation only has value if it contains more than just the option name, but that is the hard part if you're not familiar with the code. The best place to find documentation is in the history (git blame the file and see if the commit message introducing the option enlightens you). But that's why I said this didn't have to be part of the microproject: writting good doc requires a good understanding of the whole thing ...
> I used OPT_HIDDEN_BOOL for all except for reject-thin-pack-for-testing, where I used PARSE_OPT_HIDDEN. I ran the test locally and also on Travis, and the all tests passed. How do I proceed now?

Now you can send a patch to the mailing list.  See
Documentation/SubmittingPatches for more details.

It usually is helpful to send the patches to yourself first as well,
and try to apply them using git am, to avoid mistakes in the patch
submission.

>
> Thanks and regards,
> Sidhant Sharma [:tk]
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Thomas
