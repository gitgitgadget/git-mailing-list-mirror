From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 00:50:58 -0700
Message-ID: <CAGdFq_ifDYKTXt_cKkz5ZTBPgZKB7HFEbWereNnhSmS3qbhbsA@mail.gmail.com>
References: <20121025042731.GA11243@elie.Belkin> <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin> <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
 <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
 <CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
 <CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
 <CAGdFq_hgYPF5eeCB9hSsjVfUyEhkBNJAtzoNuNqs5N6V-+w9Hg@mail.gmail.com>
 <20121025073454.GB15790@elie.Belkin> <CAGdFq_j5sWsHwJY-rWP-XJ6cMF6uwSq=9beFe9ZuZyixBa1fVA@mail.gmail.com>
 <20121025074829.GD15790@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:51:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRIEJ-0003GJ-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 09:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805Ab2JYHvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 03:51:40 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61001 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431Ab2JYHvj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 03:51:39 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so547099qcr.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iAeThhP6CBbV5+KTUVJT//722fjz2DRTY41Vjoxijus=;
        b=jpEEAJy3WGMf+Gg6o00Uj/YKH1gYTZLIBgR9W5rOa3H4xzEZps1moRVU2RfmBRW2Ws
         Eou/aERGmkArVYTQrS5I2uwfmPuwHkqf1fyPYNmFQtzMqcbmcAw2673bhSWlBhEeTEix
         V+YTwxSy0zse8QAiVpFHWcs5Uaqr0xLUB11kTScJd732XhxfS9zwNp98L04+vxh9b0Pb
         kNloFB2ZMRzIGu9jgA70rY3+RIUNhlFxv+bThqHGD6LVNWmsnnLEFmossukUlVFQ1Rnz
         2eGgIjyIOKKH4xVgiNeaHNsNe2dQAE/8VKpk1ohuTR9f71Rbnc6RL7wXtCGMPGdxj8Ne
         mFPQ==
Received: by 10.49.130.234 with SMTP id oh10mr10344051qeb.42.1351151498557;
 Thu, 25 Oct 2012 00:51:38 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Thu, 25 Oct 2012 00:50:58 -0700 (PDT)
In-Reply-To: <20121025074829.GD15790@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208361>

On Thu, Oct 25, 2012 at 12:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Sverre Rabbelier wrote:
>
>> I know there was a reason why using UNINTERESTING didn't work
>> (otherwise we could've used that to start with, instead of needing
>> Junio's whence solution). I think all refs ended up being marked as
>> UNINTERESTING or somesuch.
>
> True.  Is it be possible to check UNINTERESTING in revs->cmdline
> before the walk?

That might work, maybe Dscho remembers why we did not go with that approach.

-- 
Cheers,

Sverre Rabbelier
