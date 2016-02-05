From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 8/8] one ugly test to verify basic functionality
Date: Fri, 5 Feb 2016 14:33:29 +0100
Message-ID: <CA+EOSB=UoMves8hdParcdtMGgzmx5p4RyKux_kB3SNK-Par-dw@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
	<1454662677-15137-9-git-send-email-pclouds@gmail.com>
	<CA+EOSBnZVuHThXLg9+VftPVaKy5wqqxp=iQtP1ZUtxkKq32HMQ@mail.gmail.com>
	<CACsJy8C2+kaPLALojJoFe+T=WoeyQ8JsB0zenDzQt3wpi9D=tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 14:36:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRgYQ-0004Al-FO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 14:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbcBENgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 08:36:01 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36204 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbcBENda (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 08:33:30 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so2507278vkg.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Oznmgg1gg68p0st5eRDdpuTTXy8+vD5SXk9ILNyWeRw=;
        b=jgAyikaFeaKpENEhHOMhgeLmTnXYo5WYG529eGSnEqzemYkR3wP5dbpP9xGsBavM2q
         FwcheSeGATXW+6QJJcWaq0R5Gw1WzgS/m7GMWGfnmvlFaC0HDz9r4oBoPjMy1kmBLVnZ
         QTITq8fsyns1lsxG05CANcxzipajwO8x81DaQQ5EitaoNk8i/l7ufBHx2J89IGN1lkJ0
         LbDY3beBJeFsln7nPy7UYNXAlExE3H6YlKO9HliQPBRK2q0gVfKkRsmAfU4xnOs5ZuDd
         QJ7GcYamipKifl4ujoN89ZIZHuUDA5KUGZXrwTIeQpqukjVzotDhpTmQIALgEu+gA90A
         /n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Oznmgg1gg68p0st5eRDdpuTTXy8+vD5SXk9ILNyWeRw=;
        b=TrxBI3HdWcJ1L5y2skEXqKZJO+nZJjzPCwyxM0+vBGMwbp6fiPNk1R73oklgk+cC5e
         e5ic4XtoCgjGoPTyxnXhXRL0lWKw/7VX3GXSuoRSu0ADCJgw2HLoXYKAZpicbiCY/78a
         e539f1CJSM8SwbysKDddQ6CPMOYlf9a8GEaPuXX3F5JecAYflCLnx7s3ckzBaj69xM42
         K2PtQ/KTLJHnJwZZ0sVnw3Gef664KzBTYw5H90V9J/KChj0ovCGQJgc1WZ70UvFgHHG9
         fvm53jXWQr2bTzm1/ZbcgacWjVupri1M0KEum4eywUnWg1L6V7mDxf2R954L2u+c0KhO
         +XQA==
X-Gm-Message-State: AG10YOR9kemzG1BpSAnYhN3CxPGJkF8FCbtAphw/lZoCuT6xfkyVHeTbembvfPjGg5WIayB2BH/UNWDbU+/ClA==
X-Received: by 10.31.180.85 with SMTP id d82mr8418144vkf.83.1454679209108;
 Fri, 05 Feb 2016 05:33:29 -0800 (PST)
Received: by 10.31.56.10 with HTTP; Fri, 5 Feb 2016 05:33:29 -0800 (PST)
In-Reply-To: <CACsJy8C2+kaPLALojJoFe+T=WoeyQ8JsB0zenDzQt3wpi9D=tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285577>

2016-02-05 14:02 GMT+01:00 Duy Nguyen <pclouds@gmail.com>:
> On Fri, Feb 5, 2016 at 6:57 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>>> +       mv `ls .git/objects/pack/*.pack` pack &&
>>
>> No, please. From the git coding guideline : "We prefer $( ... ) for
>> command substitution; unlike ``, it properly nests.
>
> I was being too subtle with the word "ugly". I assure you this test
> cannot be merged in its current form.
>
> But that's not important. It makes me think, can we catch `..`
> automatically? I know the test suite can catch broken && command
> sequence. Maybe we can do the same for`..`?
I dunno. But it might be a good idea
>
>> It should have been the way Bourne spelled it from day one, but
>> unfortunately isn't."
>>
>> http://stackoverflow.com/questions/4708549/whats-the-difference-between-command-and-command-in-shell-programming
> --
> Duy
