From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: git subtree push-all and pull-all
Date: Thu, 25 Jul 2013 12:19:27 +0100
Message-ID: <CALeLG_khS=n4K3AuRFMZhRx30tzwcAKt7UPG8d1Tu5YeOkPaPA@mail.gmail.com>
References: <CALemSr4Z+p7v_wQn7EOFTVHjtMYgxqGSBZf3zU5pn-eW_SEG5A@mail.gmail.com>
	<20130707125430.GA23197@paksenarrion.iveqy.com>
	<CALemSr4Q_En+9eAbu2oRO-=EYt78sCB4nQjSO67W_m=nxu6KiQ@mail.gmail.com>
	<51DBD636.7070601@initfour.nl>
	<CALeLG_=x30qR1LFiKzz+NZu6vAf3GAL2tTCsbCz0Zm6J+udAcg@mail.gmail.com>
	<51F0F728.6090709@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gareth Collins <gareth.o.collins@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	git <git@vger.kernel.org>,
	Dieter Adriaenssens <dieter.adriaenssens@gmail.com>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Thu Jul 25 13:19:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Ja0-0000b6-L1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 13:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3GYLT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 07:19:29 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:38621 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab3GYLT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 07:19:28 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so392839oag.31
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 04:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=s8cC03+TEKQ7o8PtTT7Fxd5tHgIaRUil/4UhgBgZY/4=;
        b=RmYWFymoEDRsIQ7UaVSO2sHCqsF/k3yoq9n0tw0RUAyS+85OUEC2kbKeO5lFQkBfqB
         tgSN8uR/t8Y40h15ClNy5gRRHWNLCu9zfR5A9pV5yCjm9Y8gIswquwK0+yekUyNyQYKg
         1r8LYSkCe4pVvNetYsGG5a6DUIq6JSLXNAfsWvHHiVPe9jM5HScqjosc08zFLj5CjOin
         M9acBlhywWQWeTZ0rk95GhGy0345eTUzUqlF8p0ndzWPLzj/nz6MuCvvXcMbmwbZBeUf
         0i+A0SPGdlLlcr584TPXMzv3Psc0e2QE/15cAjxtwYiJPdenh6KP9pGqe5RKO8UHvIQC
         HFZQ==
X-Received: by 10.60.56.229 with SMTP id d5mr41267152oeq.7.1374751167669; Thu,
 25 Jul 2013 04:19:27 -0700 (PDT)
Received: by 10.76.9.2 with HTTP; Thu, 25 Jul 2013 04:19:27 -0700 (PDT)
X-Originating-IP: [212.219.195.16]
In-Reply-To: <51F0F728.6090709@initfour.nl>
X-Gm-Message-State: ALoCoQmJntHg6DhbuFCQObex2ph4ZOqCY888yoOXxy7047y69b81v3W4Ql2N01Gtt1dGiwQ/KxTU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231130>

I agree with the idea of maintaining git-subtree outside of contrib.
However, you would need the commitment of apenwarr, or whoever hosts
the master repo, to merge in any pull requests or we are no further
forward. (apenwarr appears not to have been active on github since
early May).

On Thu, Jul 25, 2013 at 11:00 AM, Herman van Rink <rink@initfour.nl> wrote:
> On 22-07-13 21:35, Paul Campbell wrote:
>>
>> Hi,
>>
>> Sorry for the delay. Not been monitoring the list lately.
>>
>> I'm afraid work stopped for two reasons. Lack of interest from the
>> list was the main one. I understand subtree isn't used much and
>> subsequently there wasn't much interest in reviewing the patches I was
>> putting out. As a result I lost interest.
>>
>
> It seems to be hard to get anything done on such a busy list. :( Especially
> when the maintainers lack time/attention for such a contrib.
>
> I think including it in the contrib folder has not done us any good.
>
> Maybe we should just focus on maintaining a separate repo, which could be
> based of https://github.com/apenwarr/git-subtree (which has already 92
> forks, including one of mine). And obviously integrate all the recent work
> from Paul.
>
>
> --
>
> Met vriendelijke groet / Regards,
>
> Herman van Rink
> Initfour websolutions
>



-- 
Paul [W] Campbell
