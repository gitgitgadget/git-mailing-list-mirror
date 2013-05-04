From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Another use of "@"?
Date: Sat, 4 May 2013 10:48:23 +0700
Message-ID: <CACsJy8DkDes5SdvU7W1kg24w3VBaQz9caZnkyy6iWFiYqw6Saw@mail.gmail.com>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
 <7vr4hozie1.fsf@alter.siamese.dyndns.org> <vpqy5bvaf6x.fsf@grenoble-inp.fr> <CACsJy8DsrY9ybLoCAo35Puc7oR41Kda9nKjBXL147qN-3xrMRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 04 05:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYTT2-0005tj-2u
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 05:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab3EDDsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 23:48:55 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:41504 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab3EDDsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 23:48:54 -0400
Received: by mail-oa0-f53.google.com with SMTP id n9so2218027oag.26
        for <git@vger.kernel.org>; Fri, 03 May 2013 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6T7DrEbZjCBg1X85ptCTOPUbkElxFX27RKVy/OgfxiQ=;
        b=aYVy6Pbx/AxSaGS4UCe837FSyZk7fsrDRtcE1Xc/CIGRFv5mKfE6XTXd09ZDRq4/Nr
         lvOAO1McQFB5C8+V86sz0ZMn470rXIe5ND/0r12EbN7NP34aUTiwH/XfQHWC2RrOsEBX
         C53/nH76JeTTKWkn2m8Jo9p0gXisSFTbLGg0bU0vfrwqjjYzkEdsas3S2hvk7YgLm6Lr
         bnOOyINxsbloQQJUS/QI1KuJIk2S3LAVQbnyZZy6dP0Z2D0Ozs95o1p2EvcmgIYFBqlN
         IxDyqFWqLQTBRW3hQfVaFiCbp36jQTz8Gc5yx66SwOpJVlZbO974vHldlwbAPIXZfU+W
         VoAw==
X-Received: by 10.60.83.103 with SMTP id p7mr2088522oey.130.1367639334156;
 Fri, 03 May 2013 20:48:54 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Fri, 3 May 2013 20:48:23 -0700 (PDT)
In-Reply-To: <CACsJy8DsrY9ybLoCAo35Puc7oR41Kda9nKjBXL147qN-3xrMRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223354>

On Sat, May 4, 2013 at 10:26 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, May 4, 2013 at 5:09 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> The A/@ could make sense, but I'm wondering whether we're taking the
>> direction of implementing some kind of Brainfuck dialect in Git revision
>> specifiers. I'm not sure we want to add more special characters here and
>> there with subtly different meanings (@ = HEAD, @{1} = HEAD@{1}, A/@ =
>> A/$(git symbolic-ref --short HEAD)).
>
> Another subtle overloading of @ that might be desirable (althought
> might be achievable another way). "git log -g"  is equal to "git log
> -g HEAD" but there is no easy way (that I know of) to do "git log -g
> $(git symbolic-ref HEAD)". "@" could fill the inconvenient spot here,
> I think. Alias is no good because I won't be able to add extra
> options.

I wouldn't mind typing <ref>@{link} that does "git symbolic-ref
<ref>", though. Because ref is optional, "git log -g @{link}" is not
bad. "link" is probably not a good name for this.
--
Duy
