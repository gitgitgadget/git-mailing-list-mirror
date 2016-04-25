From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Mon, 25 Apr 2016 07:14:42 +0700
Message-ID: <CACsJy8Bu+fsWP-dmckbSCRvonpqtCyvwGZWHCvjtfSWKY3A6QQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
 <571CE4D5.8010403@ramsayjones.plus.com> <CAP8UFD0dEYPSku8w=7ehJFFgtNFO8EbUc4RDn+KRdrYG3-=Rxg@mail.gmail.com>
 <CAP8UFD0rKNAoZgCPQkfo_qd7b_V4rOtLqBvQ-XQoeT6OnZidGw@mail.gmail.com> <571D059B.2010908@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 02:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auUBS-0003TE-67
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 02:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbcDYAPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 20:15:15 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33082 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcDYAPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 20:15:14 -0400
Received: by mail-lb0-f182.google.com with SMTP id jj5so19562725lbc.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=anuUrh4B/Zygbuo+ljBmr7TAGeBadRyiGLmXX/lSe5E=;
        b=BkUTUxsTyUxaeZ9Ve1ZyAhW1s3NpH+XfsB+8YvMzwCmW9esMXpSYARLtIxZonU2KN7
         8Ohsk8QjUR/vtwLvIX3xjxKHGmv7zMKNqxigAOWK8UhOGPKqXY4HpfJg4iSmIZGUSwGc
         VN4GrkGbcN/o0szQKAfqKgvk5t0RPTBImHxA5yW94mM4WqnfdtMYrckdeq/Gl9dLAHgz
         5dR0th95nGYnvCHLNmsGoIz9XW14CjC/Td9Bd5nIO1FNeRPFJgytnpCAmY1zaf+jWSml
         WsQM+60nOqIDThYO2dM3wNnKJX2LseeU+El+hdnnsteHS30Mn8XATYFsgM/h6K9+fuMZ
         67BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=anuUrh4B/Zygbuo+ljBmr7TAGeBadRyiGLmXX/lSe5E=;
        b=BLlEnu9uGoxrDNIW+d3FEtJiPL9I/IDP/uFpTkY+R5AnirTTZVajgTZvSqBftHdw5f
         E7LxS8KNePZ5EnQ37lz/+UULpdYoUWhcTBexQAqIgLDGIU6EocjwK3jJ1MH0uvpGKNsP
         CDpZUYwpUlbn7xBUADNVT6RPCJjmjLazTk6gxSG8qdZlGRfMZRYhMAdj1SnJpy99W4Sx
         TYHqgf72zUvbAYEnuuzVWdv2hiPgjhBBymr3sLjUJ5EZp/RRZsz+jakY/E/aicQUH19R
         wQ8FfjnEGB4PS7QCFlPQF0J+eVvDiQElw7WhCaV43SWeDxAC6+TOqG9Q2SAA4Dsl3iNq
         Q9Cw==
X-Gm-Message-State: AOPr4FXH9yYy6Iip3TfRlqPj8Yy53Vt/ujQeEgxJzlFfltEbP4PtFoBIypLmjf/k/rvhkh77BWNuDSg5GzdyNA==
X-Received: by 10.112.22.131 with SMTP id d3mr12820781lbf.145.1461543312508;
 Sun, 24 Apr 2016 17:15:12 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sun, 24 Apr 2016 17:14:42 -0700 (PDT)
In-Reply-To: <571D059B.2010908@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292447>

On Mon, Apr 25, 2016 at 12:42 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 24/04/16 17:56, Christian Couder wrote:
>> On Sun, Apr 24, 2016 at 6:27 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> On Sun, Apr 24, 2016 at 5:23 PM, Ramsay Jones
>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>
>>>>
>>>> On 24/04/16 14:33, Christian Couder wrote:
>>>>> This is a patch series about libifying `git apply` functionality, and
>>>>> using this libified functionality in `git am`, so that no 'git apply'
>>>>> process is spawn anymore. This makes `git am` significantly faster, so
>>>>> `git rebase`, when it uses the am backend, is also significantly
>>>>> faster.
>>>>
>>>> I just tried to git-am these patches, but patch #78 did not make it
>>>> to the list.
>>>
>>> That's strange because gmail tells me it has been sent, and it made it
>>> to chriscool@tuxfamily.org.

#78 moves 4000k lines around and ends up ~260k in size, I think it may
have hit vger limit.

>> Instead of waiting for the patch to appear on the list, you might want
>> to use branch libify-apply-use-in-am25 in my GitHub repo:
>>
>> https://github.com/chriscool/git/commits/libify-apply-use-in-am25
>
> Hmm, that branch doesn't correspond directly to the patches you sent
> out (there are 86 commits, some marked with draft. I think commit d13d2ac
> corresponds kinda to patch #83, but .... ).
>
> I think I'll wait to see the patches as you intend them to be seen. ;-)

I git-am'd the series then compared with the rebased version of
libify-apply-use-in-am25 on master. 33198a1 (i.e.
libify-apply-use-in-am25^) matches what was sent in content (didn't
compare commit messages).
-- 
Duy
