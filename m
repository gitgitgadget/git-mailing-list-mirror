From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Mon, 3 Oct 2011 10:31:20 -0700
Message-ID: <CAE1pOi2Vzqp2X95AE6DHhPvCCUURS+H4rTqr53-kxCuRhzSS4g@mail.gmail.com>
References: <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<4E889813.8070205@gmail.com>
	<CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
	<20111003030723.GA24523@sigill.intra.peff.net>
	<CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
	<vpqaa9ijzt4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 03 19:31:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAmMQ-0005dZ-Rt
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 19:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757044Ab1JCRbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 13:31:22 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37329 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab1JCRbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 13:31:21 -0400
Received: by qyk7 with SMTP id 7so3887510qyk.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rIx+Sg9qrLcEH4i7K6qRTTDtmB6yslW6iLZX0GNNXs0=;
        b=TOrXembKGK63hDJ3QZackt0U5lpKKniQazdOjQDfTUYFV027zNQTPRYsc7BG9HSGA6
         zqJ6IOVbLPi7uNOEIEMSI35TPYjNTDalJjrKNJCwR08BgLl49ZuwFxHMoLa/Qn3anyJO
         C6sqtXHzh+X4XG/XZgzOfXC8CbKoGmi0RCNB4=
Received: by 10.229.72.87 with SMTP id l23mr179854qcj.163.1317663080554; Mon,
 03 Oct 2011 10:31:20 -0700 (PDT)
Received: by 10.229.87.134 with HTTP; Mon, 3 Oct 2011 10:31:20 -0700 (PDT)
In-Reply-To: <vpqaa9ijzt4.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182677>

On 3 October 2011 00:32, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> Yes, I meant it literally. And, no, Git could not possibly know so it
>> would have to be optional behaviour. But it's probably a lot of work
>> for (for most people) little gain.
>
> Not only little gain, but also important risk: users of this feature
> would be likely to spend hours debugging something just because some
> files weren't recompiled at the right time.

Possibly. When I do a git pull or similar I do a full build
regardless. I don't know of any build tool that triggers a build
because of a deleted source file (that's an actual problem I ran into
only a couple of weeks ago). Of course, in that scenario the build was
succeeding where it should have been failing. :-)

> If you want to optimize the number of files compiled by "make", then
> ccache is your friend. This one is safe.

This is all C, right? I'm in Java land so I would assume ccache is of
no use to me. And we certainly don't use make.
