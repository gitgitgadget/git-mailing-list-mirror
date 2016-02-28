From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Sun, 28 Feb 2016 11:35:42 +0100
Message-ID: <47DA71B9-5A00-48E4-B7A8-6C678F597627@gmail.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com> <CACsJy8CjOkNuEg=QRTATQLkYzMxpf5zryMXERZu6Zn59VDUB_Q@mail.gmail.com> <17AFC0E6-FC83-4BD4-9C19-43A6B9103866@gmail.com> <CACsJy8Dc1dHp7kGgz_pY1uoXum-k3gnzD0AHFsaLQzuZihUKcw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 11:35:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZyhZ-0008Uf-Mw
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 11:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbcB1Kfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 05:35:46 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36100 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbcB1Kfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 05:35:45 -0500
Received: by mail-wm0-f67.google.com with SMTP id l68so3693199wml.3
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 02:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l4NLMGSAe2rNNBVs7BHYfiWE9oAmzCdx+M/NtLj0hA8=;
        b=j29PmLdKidNneuRc380AWc3IY8bsIJnARYL77EpnZZas6Z/98zjwk1bkXC4wtAp+j+
         Q2rn6cHHhfzEhUOw5MBVr5Jo6uZkQ7KrygDiJWcnt65m+QdCjBL4LBJEuXsUFQBB8z8U
         qaGb3p8pj7Po2bVmCQYQnI3FwCG2jQiIVh15gQUq9l9wDAcdwWqKOc43a0gqQe7IPuAK
         PaFBYc1FfkRdtiS7H8/0lIhWoA0e6XBBKoybCXVa1iImhxMlIgaht08CdATG3dndIvoI
         8p8pSBgu2ekSkWT4o/xsXob6M7zKqNT6rqBPimoCDQWiADnrz71aMbXMMwfAaKVmT0K/
         kZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l4NLMGSAe2rNNBVs7BHYfiWE9oAmzCdx+M/NtLj0hA8=;
        b=jhpWvq11piwhiB0Y2j6MSHMtxJaEUzy9njl1rWiJdj7zIyROBOe91r6O2rkJh204sy
         FdfaMJv3LWtTGd+VNP8J6JyY9IU24gq5U/2oBUMaPDunDi8XZqSpH0bgrYnFzd+61KJr
         m0hu/rjKgp3rI2SVxOCEuF9SDSG3eCIyDHnzWv5E+yzqoaaEdBwWQKQy85k0Up6BL3Xh
         H1327EN2ah0HqAvsCcwTugktjHU3Z+YbuvWrSgvsJvj/hPvgz1CLSRFFpC+3Qlo11aEV
         GDDM44kWXk65jK3kyMMcnPnmLyZ80lvTA/97ju6vtg73dla/pSxM2QT2x4hsGgxXzAUD
         BKAw==
X-Gm-Message-State: AD7BkJLtP/ENWt10DUtvWM38vW0DLjirFYwWqNbvrkTh8mv3lAE+BGjgh7+yvK08nrPMiw==
X-Received: by 10.194.184.234 with SMTP id ex10mr9288822wjc.8.1456655743434;
        Sun, 28 Feb 2016 02:35:43 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4692.dip0.t-ipconnect.de. [93.219.70.146])
        by smtp.gmail.com with ESMTPSA id c26sm10905657wmi.24.2016.02.28.02.35.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 02:35:42 -0800 (PST)
In-Reply-To: <CACsJy8Dc1dHp7kGgz_pY1uoXum-k3gnzD0AHFsaLQzuZihUKcw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287765>


On 26 Feb 2016, at 10:33, Duy Nguyen <pclouds@gmail.com> wrote:

> On Fri, Feb 26, 2016 at 4:30 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> 
>>> On 26 Feb 2016, at 10:26, Duy Nguyen <pclouds@gmail.com> wrote:
>>> 
>>> On Thu, Feb 25, 2016 at 3:42 PM,  <larsxschneider@gmail.com> wrote:
>>>> +ifdef DEVELOPER
>>>> +       CFLAGS +=       -Werror \
>>>> +                               -Wdeclaration-after-statement \
>>>> +                               -Wno-format-zero-length \
>>>> +                               -Wold-style-definition \
>>>> +                               -Woverflow \
>>>> +                               -Wpointer-arith \
>>>> +                               -Wstrict-prototypes \
>>>> +                               -Wunused \
>>>> +                               -Wvla
>>> 
>>> With the exception of $(SCRIPTS) in Makefile, I think we prefer to
>>> avoid \ and have one addition per statement
>>> 
>> I guessed that because I actually looked through the makefile to find how you deal with line
>> brakes. The problem here was that this line gets really long and then it is hard to see what
>> warnings are enabled.
>> Would you be OK with using \ for readability here?
> 
> Probably misunderstanding. I meant something like this
> 
> CFLAGS += -Werror
> CFLAGS += -Wdecl..
> CFLAGS += -Wno-form..

Oh. I just realized the patch made it already into master. Do you think I should submit
a follow up patch? I also wonder, do you see an advantage of one style over the other
or do you want me to change it for consistency?

Thanks,
Lars