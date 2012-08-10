From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 11:13:30 -0700
Message-ID: <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com>
References: <20120810075342.GA30072@sigill.intra.peff.net> <7vboiilpvs.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com> <20120810180836.GA29597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:14:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sztif-0004d5-0r
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 20:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759238Ab2HJSNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 14:13:52 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37326 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758857Ab2HJSNv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 14:13:51 -0400
Received: by ggdk6 with SMTP id k6so1903067ggd.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=ksPgh/BaCVeEAt17uNiJw527SoI/jdQU1R1WvcR6u/o=;
        b=RRZWxty4tGqcFpVpu/c3OUHTFUmkb0w8agwRVjvdcGQjTF2+V1hpHr1mnJay9FBleg
         fSJsWreW+WiSje0ac2OJeSoqYPBeaZ6NPz/uvgtrOOGpLrA9vnGRQrw1Iq+IirZbEkgF
         cSZr7lER1DI7VDyde3D3TH6qtbe6Qitbak/Ebbu70E8PwSkIZcJf29cGMlq/MgMLc5nJ
         xiYImdh6+US+VD8+fWEWpMPafEPUyglr/adUDHcCDWcZ4BUwUxjr9XRzlaZohN2frd7A
         1AcPFxEWqy/zp24yd72+6U0pFUnEgEkic8MrrkQfntonSkFSyIDbsaX9HthsFw/wbIcF
         IpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=ksPgh/BaCVeEAt17uNiJw527SoI/jdQU1R1WvcR6u/o=;
        b=WLPno+oZLOUmpJrNBcDvazRqtl7vcuzd0rjrjVh8EznB5QcvHc4QWUGr6CtnON60kh
         7trXtWlKBA1T/7PsoRxx6Do1a+nGSjRG2i9vBDRHmyFSD6yqgpdXRftQS2U8JSPlrOJ7
         RZLocCPYoDtnSccHTwMi/6M3WZA7YfTzE5VTRe1ldR0zcM2FIYycBc/Vga57uO2tiiH3
         5zJV92bquAC9Hwvxv53zyrZ66mFBYb7932/f5TSMr1J1cKtLfYqdap7v6GueMPfyS9V7
         49Cd++zc6tvbycmxu+iI1rahjGHmxO+3RFZpjY0fPSgbe/lsghr57bDJ0IN2vGAPTRDg
         PNzg==
Received: by 10.50.182.226 with SMTP id eh2mr2628508igc.69.1344622430692;
        Fri, 10 Aug 2012 11:13:50 -0700 (PDT)
Received: by 10.50.182.226 with SMTP id eh2mr2628498igc.69.1344622430600; Fri,
 10 Aug 2012 11:13:50 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Fri, 10 Aug 2012 11:13:30 -0700 (PDT)
In-Reply-To: <20120810180836.GA29597@sigill.intra.peff.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQk0uM9ZHsCRa4bQW6Ykxi4V9EcUruJoC2urjI9bNDU0bQFe4Ws7Av1oBBdrFjhLkJmKjMGR6B1b3w0xG3y6njKXz44Vpzn+qUin71wimniQAx3Eiak2zZQuUNFirhyFDF3OsxL6FeBW7eHMTMuVDz0zi2mSIgCKiZp8EcWfiPcvVoH8HwoU6IAjh4YoIhfheUng+jiy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203243>

On Fri, Aug 10, 2012 at 11:08 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 10, 2012 at 11:06:08AM -0700, Dave Borowitz wrote:
>
>> > I asked the folks who run code.google.com and they are indeed seeing
>> > something like these in their logs:
>> >
>> >  >> Client asked for capability agent=git/1.7.12.rc2.79.g86c1702 that was not advertised.
>>
>> FWIW, this error comes from Dulwich:
>> https://github.com/jelmer/dulwich/blob/25250c1694dac343d469742aeafa139f37fc4ec6/dulwich/server.py#L196
>
> Thanks for the data point. I knew you guys ran some custom code, so I
> wasn't sure how widespread this is. The fact that other dulwich-based
> servers would see the same issue makes me doubly sure that my fix is the
> right direction.

You may also notice in that code a set of innocuous_capabilities,
which IIRC is the complete set of capabilities, at the time of
writing, that the C git client may send without the server advertising
them. Such a set (painstakingly assembled, I assure you :) may be
useful as we move further in this direction.

>> So any servers running Dulwich would be affected by this...though I'm
>> not aware of any large-scale Dulwich installations other than Google
>> Code.
>
> I'd rather not break small-scale installations, either. :)
>
> -Peff
