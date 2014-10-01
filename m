From: David Aguilar <davvid@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2014, #09; Tue, 30)
Date: Tue, 30 Sep 2014 21:01:25 -0700
Message-ID: <20141001040124.GA32748@gmail.com>
References: <xmqq38b8svrd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:01:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZB6W-0007eI-5T
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 06:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbaJAEBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 00:01:24 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:44748 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaJAEBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 00:01:23 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so9503pdi.10
        for <git@vger.kernel.org>; Tue, 30 Sep 2014 21:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FVHJ8e/j7JsflQxM3I1WjM/M4uqmcGNDXke+4Ipqvn4=;
        b=TpXccxEBMG7QinEcD7qTuVeUJrWiTzNaWUeAhwpz0CvgJZgJjjSkpCNr2UBZmkLlSa
         ASByzT46c8Br0RsI898sfGzlBKI9dhhduj+Vna3uq3E0H0KfikVlrGfroqYJmFAHCMUe
         yPNIABUUVyPB9gGaoXvB8Ufcs1TMDs7t+bCuvFdMSpOdtRWw1ZbNOJivasf1X4+wjkS3
         0s/o5d2BMDu7r6xsaCI/IOMtOexCO9E7mmemWneRbpiZpmh+bR3Ew2kM56moA9FLU6SG
         XUxQwHA/hcp8RBOkw9Xtao52Ic1yrRXLHA6Fj48Q50MW2xzC6mjUIcvZI1tC7HNNIVfe
         w1Tw==
X-Received: by 10.68.233.68 with SMTP id tu4mr76231792pbc.65.1412136083161;
        Tue, 30 Sep 2014 21:01:23 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ri9sm16505822pbc.5.2014.09.30.21.01.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 21:01:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq38b8svrd.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257690>

On Tue, Sep 30, 2014 at 01:23:18PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
> 
> * da/include-compat-util-first-in-c (2014-09-15) 4 commits
>  - SQUASH???
>  - check-headers: add header usage checks for .c files
>  - Makefile: add check-headers target
>  - cleanups: ensure that git-compat-util.h is included first
> 
>  So... what is happening to this topic?  I think the bottom one is a
>  reasonable clean-up without too much churn, but I am not sure about
>  the rest.

Agreed. The SQUASH??? commit could be squashed in, but it might
just be better to take the bottom commit and drop the rest since
they aren't really that helpful.

Thanks,
-- 
David
