From: =?GB2312?B?y++61Q==?= <sunheehnus@gmail.com>
Subject: Re: [PATCH] OPTION_CMDMODE should be used when not accept an
 argument, and OPTION_NUMBER is of special type. So change the mode to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 23:21:21 +0800
Message-ID: <CAJr59C2Rd4JDUe-UMcjg6=z2fVDc45pSHZwKB_aA-X2p1PkQvw@mail.gmail.com>
References: <1393597765-14164-1-git-send-email-sunheehnus@gmail.com>
	<CAJr59C1qHrQ9qPdDWfGzj9QX3L-EwEcP+updu0SDn24r4i7UMQ@mail.gmail.com>
	<CACsJy8BM=m6=tv2P6F3EAcVPupovSTKC3s+5gkus3V+GZ4owRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: pclouds@gmail.com, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 16:21:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJPFg-00071G-2b
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 16:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaB1PVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 10:21:24 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:63086 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbaB1PVX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 10:21:23 -0500
Received: by mail-we0-f170.google.com with SMTP id w61so681937wes.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=0CrEi0uJzGftj5v1yADpf+/3QHUOhKQhbyUInImbUTc=;
        b=iaOeSSXO3eS/8yTjO7erJgpvsLkRfR4JHz7Gx516CVhjxqvEWUTAgm1QURysQVx8jY
         3mLrzdoVYj949ppUK2YdVbjlaurX3fAcirNkBmVh2EEs1BF7gzdzkMNqaUh8GaHgc0tR
         R17FIJj6tIP73HFyz774Fd8c5onqlXmtol+COsLXFnboUbpAdOJgLkYUVo3RNHIrTwzs
         ifQAHaCZY2GD6p/48olhz4HL1feIaDMX8z8SW3+18vySX3AuhxLLbCVWRzRM/CwHXf66
         CNN7iN8o8N7tJK49qf1xx8YDKTozp87zoHi6sdP/LV8Mev140SpT4+zWBpwWyM5MGYBP
         bu9w==
X-Received: by 10.180.205.204 with SMTP id li12mr3113314wic.34.1393600881130;
 Fri, 28 Feb 2014 07:21:21 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 07:21:21 -0800 (PST)
In-Reply-To: <CACsJy8BM=m6=tv2P6F3EAcVPupovSTKC3s+5gkus3V+GZ4owRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242974>

2014-02-28 22:43 GMT+08:00 Duy Nguyen [via git]
<ml-node+s661346n7604517h28@n2.nabble.com>:
> Way too long subject line. Keep it within 70-75 chars. The rest could
> be put in the body.
>
> On Fri, Feb 28, 2014 at 9:32 PM, =CB=EF=BA=D5 <[hidden email]> wrote:
>> I am not sure if this is a bug.
>> I need your help to find out it.
>
> Tip:git has a wonderful history (most of it anyway). Try "git log
> --patch parse-options.[ch]" to understand parse-options evolution. Ad=
d
> -SOPTION_NUMBER (or -SOPTION_CMDMODE) to limit to only commits whose
> diff contains that keyword.
> --
> Duy
> --
Got it,
Thanks

> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to [hidden email]
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> ________________________________
> If you reply to this email, your message will be added to the discuss=
ion
> below:
> http://git.661346.n2.nabble.com/PATCH-OPTION-CMDMODE-should-be-used-w=
hen-not-accept-an-argument-and-OPTION-NUMBER-is-of-special-typeE-tp7604=
513p7604517.html
> To start a new topic under git, email
> ml-node+s661346n661346h27@n2.nabble.com
> To unsubscribe from git, click here.
> NAML
