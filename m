From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Thu, 11 Feb 2016 13:15:09 -0800
Message-ID: <20160211211509.GA14667@gmail.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
 <xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
 <xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
 <56BB4BDF.3010407@drmicha.warpmail.net>
 <xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
 <56BCAC69.8030909@drmicha.warpmail.net>
 <xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Dickson Wong <dicksonwong@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTya9-0007lQ-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbcBKVPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 16:15:14 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34485 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcBKVPN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:15:13 -0500
Received: by mail-pf0-f172.google.com with SMTP id x65so35435921pfb.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 13:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gXnXoEkXgTkuUKW92n+dMso2J0ifwgC+3wlL9lq+8t0=;
        b=mu5kP8XMDiwqieo6ATlDYdijWNpET8Sjs4JVMw4is/afDIt2N+jBHDtY/wEsIouiX8
         W4PEJ19NcwswR5/6Ft1AqLzSr4o7hM0Ux0Rq6C/oDKaNsoMZEz8BUxyNT1sn4J+pwbtQ
         3YjxWUlLFyZRQimlzaasXbp1/WQHmTXVlXFCb/NBqs5AgMV72mDTxBUq2X4rQs9F7nJg
         s6M8QmB6mQrpmiOPfMPtKc6/ruT2UMrZnuinxhlAeYGsTeraARu9gbJbCbudi1jLKO2H
         eZWoxgd6ciHMlPyVPcSOQmI+DDd6pNFoKxwUJor1lCGuWkX2G7CE0aSMZXVdm7UCjGmG
         leJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gXnXoEkXgTkuUKW92n+dMso2J0ifwgC+3wlL9lq+8t0=;
        b=ddmjg/PFGBAoi6eKwkl3T1uLX3llEyE3jYa8fQA4F2087diDy7xnwuj6IEuIAaMawT
         iaSaHduOdXAZRQZlZzbReWpUfyU+179oDIEgXCXsFORCEQLhzhcr887m2VVv8Xd/8Faj
         JX5g3S5XVXdDEYi0mgp1xXE0nBvxXuNuVyO/EZtdw/rCaN928GPwfRqUADqqsjeI6fpR
         eCOjIx3nKHE7BC3obREH+OTqbljqNg4Siwk+4tLm33HPQqw9A0GUQSqeKJQGd7PHHhS+
         6wExfJLo8DxJ1ec1xL1Cbr9oyYwo7qWABHkgYUyBl4CzVUAh4ov1x2o9zzuSyLPL9Tv+
         emRQ==
X-Gm-Message-State: AG10YOTMY1vjIUWCpolg66SkyeCBj4q+bfAtx8sloMLUj9f6jEN5PkAIWTd43zMz4dWoeg==
X-Received: by 10.98.19.12 with SMTP id b12mr68817684pfj.29.1455225313096;
        Thu, 11 Feb 2016 13:15:13 -0800 (PST)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by smtp.gmail.com with ESMTPSA id 3sm4629173pfn.59.2016.02.11.13.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 13:15:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286000>

On Thu, Feb 11, 2016 at 08:03:57AM -0800, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> >> Does this mean that I should warn in the release notes that some
> >> existing users might get their expectation broken but we are going
> >> ahead anyway because we think most people read left to right and
> >> then top down?  I am OK with saying that--I just wanted to make sure
> >> we know that it is what we are doing.
> >
> > I would claim that anyone who notices the difference in buffer numbering
> > would be positively surprised.
> 
> Thanks. I, being a non-user of vim, was wondering if people who had
> their own user-defined commands (macros? and possibly short-cut keys
> to invoke them) built around the old (and odd) numbering need to
> adjust--in which case we may need to forewarn.
> 
> > In any case, the buffer numbering is not the same (it is local remote
> > base merge) but it doesn't matter in this case because only one window
> > is displayed, so there is no visual association.
> 
> OK, thanks.

Sorry for not noticing this thread earlier.
The change and the rationale sound good to me.

FWIW,

Acked-by: David Aguilar <davvid@gmail.com>


ciao,
-- 
David
