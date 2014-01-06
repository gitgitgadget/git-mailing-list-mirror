From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 00:32:47 +0100
Message-ID: <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net> <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net> <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0JfX-0000TS-TU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933288AbaAFXdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:33:11 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33334 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbaAFXdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 18:33:08 -0500
Received: by mail-ob0-f169.google.com with SMTP id wm4so19139236obc.14
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 15:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x59zJtAcCbFCtTkKnc7sYYSsmQOE/8pEsPs7exsfwiE=;
        b=DmMYOpY9P+wSV81wUDCoq2klZw8cIFnZv/EfPipMB9rMxSgHaTFsEZeRUlV0mNBTLW
         8AnuyA3cRatLDofjCkXz0GMaPra9y7CjMqF9EVc5/BIfQucwzboN0eDNlxt4SQzIMbhJ
         ptoEIZgw0lyZLSS0s3QWg7BV6tuXqQNJzw6LMYwBwBk8U0S313BoBMMka/EG6L3/PkMl
         RDa+NUdfs02LHHeJWKeuGXB1487XyXYw7wafFIUxuVbIoRTP+PIx3MONXTXnMgtbTCGF
         YPE14pOBuvlh7L31O06VaI3KgmDcUYrvT2dI7Ts45HfnIRTgh0d1KboF1uvVCY/VKC3I
         uHAg==
X-Received: by 10.182.250.200 with SMTP id ze8mr2069obc.72.1389051187940; Mon,
 06 Jan 2014 15:33:07 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 15:32:47 -0800 (PST)
In-Reply-To: <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240084>

2014/1/7 Francesco Pretto <ceztko@gmail.com>:
> To not break the existing behavior what it's really needed here, IMO,
> is a "submodule.<name>.attached" property that says two things:
> - at the first clone on "git submodule update" stay attached to
> "submodule.<name>.branch";
> - implies "--remote", as it's the only thing that makes sense when the
> submodules are attached.
>

Unless you decide to go with the proposed approach of Trevor, where
"submodule.<name>.branch" set means attached (if it's not changed:
this thread is quite hard to follow...). To this end, Junio could sync
with more "long-timers" (Heiko?) submodule users/devs to understand if
this breaks too much or not.
