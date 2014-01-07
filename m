From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 20:52:07 +0100
Message-ID: <CALas-ihyPTt60F_cVM8_D07rkN+gtaD9HdWcPvfx-soN4bFrgg@mail.gmail.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net> <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net> <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:52:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0chU-0006Yk-MC
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbaAGTw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:52:29 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49991 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaAGTw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:52:28 -0500
Received: by mail-oa0-f46.google.com with SMTP id l6so719897oag.33
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 11:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MjjRlm6Lz44XXgtPNza3XWBPhSTVECgum2XvrBACh9U=;
        b=sDjHt4w01IPmKj7bIJel1mlQLewBvgBcGnjVuQyMpQswXauKbSFOUOVFZ5L2CYf7pZ
         gr9weU54s/E7J0eKYYCIqm6TOEdmuk0IJ0IOeq7uVLnlRY+K+/rLxYyScEsFk6GopPZ4
         NP4A6CZyuClpgmwGTBQyviMxzEhb1As7bs/JVq/wy1uzbRYDN+KXgBnqaRgy6nUkPwAg
         Go0hlLFK5ohK9R//4rCjurHOxwhJmpuUAfA8VXO3Wxm8v6NCNywYg7BHAAvXPCMGSYek
         zDyg8CsIf3nEDvD8gwkibJ13XDcMu0r0zD66HLxAPJcNAe0f3hxKG/F6AyjrdM+apGXH
         mSiw==
X-Received: by 10.182.29.33 with SMTP id g1mr2489116obh.59.1389124347726; Tue,
 07 Jan 2014 11:52:27 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 11:52:07 -0800 (PST)
In-Reply-To: <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240141>

2014/1/7 Francesco Pretto <ceztko@gmail.com>:
> 2014/1/7 Junio C Hamano <gitster@pobox.com>:
>> It is not immediately obvious to me why anybody who specifies the
>> submodule.*.branch variable to say "I want _that_ branch" not to
>> want to be on that branch but in a detached state, so from that
>> perspective, submodule.*.attach feels superfluous.
>>
>
> Junio, for what it concerns me I fully support *this* patch as,

Where "this" patch is Trevor's one, don't get me wrong... :)
