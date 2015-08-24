From: Stefan Beller <sbeller@google.com>
Subject: Re: Submodule, subtree, or something else?
Date: Mon, 24 Aug 2015 09:51:01 -0700
Message-ID: <CAGZ79kY+HLzd4esdy+i82Eh5Vhc1NEDDfinD2iiBMvV41GSCiw@mail.gmail.com>
References: <1440197262.23145.191.camel@gmail.com>
	<CAGZ79kbUXwEYnpDWgKqnUab2xP4m9m7FMskaK2u8WcqnLSSoog@mail.gmail.com>
	<1440339066.32140.17.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?SsSBbmlzIFJ1a8WhxIFucw==?= <janis.ruksans@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 18:51:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTuxh-0007yH-3z
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 18:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbbHXQvE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 12:51:04 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36013 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbbHXQvD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 12:51:03 -0400
Received: by qkda128 with SMTP id a128so26359493qkd.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=da1X3R+Rldp+wboIOhaNvzHoTCtEkNOTHzME8ULKFvE=;
        b=MQ7XGTFVT9yFbefp4saLUM6ww361Tnln7IN8hI89hhQvwAQRK0JMR0lcR3rItrLOAL
         BXW0sf0CjD01V4964/Cg7g/2DSGSARY0wRsWanTEerATXhvOv8c62tNlZ9eIOb94VOO1
         u2jcpJIL2cHw0L+h+62UvT31QFz68OFuQJ5tCzn7pTmJGn44L7un3KkFruLpPPuWxOoF
         jcqcaJTCN8kDYYP1cNixZ/kWPjjCWhx4FCH/OroYU9A/D+Gk0aj9NG0R7t1mUUX43bZQ
         VZZfUrM5qSJd1I+C08P0GgQo7/GwMu6xBk1lmp5xppG22BNA4sDdNYucP177/dS7RPg6
         7Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=da1X3R+Rldp+wboIOhaNvzHoTCtEkNOTHzME8ULKFvE=;
        b=RY8ZDbBek7oUs9fuXPVoPBg5ZG32fP1ztS9E7lC8gf0R62FMwXwDCu9SS4a4zKjmnZ
         QrSSZtc7TyLYHkiJKkiG34nochrWd8jX/euA3K11zFAE3C7p9RTsQ4RAU00oJsDDxfDY
         8ndWUap6cLwXBSiVxOmlmSmMeGRDdzSvRdevl0BulcJccjDa8pIO89jWp0Vbm/vUqF48
         BGkMgQI3e1a4sIOcGUnsP3OGhrxvf54o8UH/8LBWtkp6k3X78bGadPonrmGqcrlPCP5D
         LFoTPxE/zICJpi7PPtBu3+1yykASnXr98OJbndCfd/HKVgJWBzMID8pNQ7jGsnLrYY8j
         B+pA==
X-Gm-Message-State: ALoCoQkDOHfVpzYt+32A2fvKw+za1mR7Ny6pDCiwcEjfChaMHN+VJu/AJdsPLe+X9gYkua9oL3dh
X-Received: by 10.170.186.131 with SMTP id c125mr30600162yke.25.1440435061536;
 Mon, 24 Aug 2015 09:51:01 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Mon, 24 Aug 2015 09:51:01 -0700 (PDT)
In-Reply-To: <1440339066.32140.17.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276459>

On Sun, Aug 23, 2015 at 7:11 AM, J=C4=81nis Ruk=C5=A1=C4=81ns <janis.ru=
ksans@gmail.com> wrote:
> On Pk, 2015-08-21 at 17:07 -0700, Stefan Beller wrote:
>> On Fri, Aug 21, 2015 at 3:47 PM, J=C4=81nis Ruk=C5=A1=C4=81ns <janis=
=2Eruksans@gmail.com> wrote:
>> >
>> > A major drawback of submodules in my opinion is the
>> > inability to make a full clone from an existing one without having
>> > access to the central repository, which is something I have to do =
from
>> > time to time.
>>
>> Can you elaborate on that a bit more?
>> git clone --recurse-submodules should do that no matter which remote
>> you contact?
>
> I mean that if I have cloned a repository with submodules, cloning th=
at
> repository with --recurse-submodules will either access the "central
> server" if absolute URLs are used, or requires additional clones for
> each submodule.  For example
>
> git clone --recursive http://somewhere/projectA.git
> git clone --recursive file://$(pwd)/projectA projectA.tmp
>
> The second command will cause the submodules to be downloaded again, =
or
> expect them to be found in $(pwd).

IIUC, the second command will lookup the submodules in $(pwd), but if t=
hey
are not there they are skipped, so all of the existing submodules are c=
loned.
Why do you need more submodules in the tmp clone than in $(pwd)/project=
A
would be my next question. But I see your point now.



>
> Or am I mistaken, or doing something wrong?
>
