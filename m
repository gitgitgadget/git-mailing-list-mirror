From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: [ANNOUNCE] Git v2.7.4 (and updates to older maintenance tracks)
Date: Mon, 21 Mar 2016 10:33:38 -0300
Message-ID: <2342B066-CDD4-4EA6-8AB4-AC093AAF4DA7@FreeBSD.org>
References: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com> <680C4CDE-233E-4603-B3F1-D68EB126620F@FreeBSD.org> <CAPig+cSOjFqcKGaZC1HWGdp7aCg7Dog1GvFYPYRbShARPm9ODQ@mail.gmail.com> <20160320194313.GB6288@sigill.intra.peff.net> <CAPig+cR7d0UF08fQy5uXW8U+7rdjGSO1drMxm6LOV-KB40mwPw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 14:33:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahzxu-0003rB-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 14:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbcCUNdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2016 09:33:46 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:34159 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbcCUNdp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2016 09:33:45 -0400
Received: by mail-qg0-f65.google.com with SMTP id j92so11081448qgj.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XdYuAqJE/1gyhoyoSk58CSpSQfuISef85cHTPhHqE/8=;
        b=kwpf4Hipj5vtUIHbH62nTF3gMzYQt74jryBKMi+SMUUWFMba/pKarJHnP1ThbE2rYw
         eprVN2jNJ9rUW0zetr5McnxfEDg+FWGdGDyXkERbw4dNWWvr/Hqas2Zd5Y4D3KWJzZoa
         KBnhJvx05B9fXZpZmQA49UoqFU4t+sepOvEKNG8WnXuWqEE2GmPE9CpmnXe57cS6k++b
         2g0aqv7RSUgB1pYm5CrOubzcqwt4joH9jtlMFn7po4pB/KMhZh/yWllP8DfuM+i6UKrk
         dgHd4ApCfaQORXc9pgtmHebfvJgMDnfF3zqPph3dc78qr99vase7nOs4dEb/ZVRzp6hF
         qH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:mime-version:subject:from:in-reply-to
         :date:cc:content-transfer-encoding:message-id:references:to;
        bh=XdYuAqJE/1gyhoyoSk58CSpSQfuISef85cHTPhHqE/8=;
        b=DuUWS3WSmNtVJantNyWg0Ugmt5HFeDVxXLAKLCWmuGbcsFJ+f1Vfz6N5DjH5waP2mw
         EcZeCELO4kfSHyiawjf0xqQWuet2//ooqfPusD/6twCtvtxIcC2JBAX3Kc0B7AIY+ihL
         3vBzqm90Wjecbf4WEsF4bB/iw6/gLYOPKvxCiGyepR9M8SpeUGpxoqUOMIPCxD994BOo
         iSVic4pmnV1jYRpAtWQKI+RWgp4414hkrv2MoGyNsosuU7hBN8ya949euthPEvB8wU3N
         BRG/DoP5uksmUtanK5GDRZrj3fNowAZWWyxjRendB++uAGPwxYryqmjNszEMylyQ8nyB
         xAIg==
X-Gm-Message-State: AD7BkJJis1xYrrE+X2yRFIWUBp9pDcKmofO1Z2zGDGMjKrSW0pNRtS6QuhhGmeZN5GQcgw==
X-Received: by 10.140.96.85 with SMTP id j79mr40335374qge.10.1458567223134;
        Mon, 21 Mar 2016 06:33:43 -0700 (PDT)
Received: from mbp.home (179-125-143-18.desktop.com.br. [179.125.143.18])
        by smtp.gmail.com with ESMTPSA id d65sm12210212qgf.30.2016.03.21.06.33.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 06:33:42 -0700 (PDT)
In-Reply-To: <CAPig+cR7d0UF08fQy5uXW8U+7rdjGSO1drMxm6LOV-KB40mwPw@mail.gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289417>

> On Mar 21, 2016, at 01:41, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
>=20
> [cc:+Torsten]
>=20
> On Sun, Mar 20, 2016 at 3:43 PM, Jeff King <peff@peff.net> wrote:
>> On Sun, Mar 20, 2016 at 01:07:52PM -0400, Eric Sunshine wrote:
>>> On Sun, Mar 20, 2016 at 11:32 AM, Renato Botelho <garga@freebsd.org=
> wrote:
>>>> 2.7.4 fails to build on FreeBSD 9.x, that uses by default gcc 4.2.=
1. I=E2=80=99ve fixed it adding an extra dependency to make force it to=
 require gcc 4.8+. Here is the output:
>>>>=20
>>>> combine-diff.c: In function 'diff_tree_combined':
>>>> combine-diff.c:1391: internal compiler error: Segmentation fault: =
11
>>>=20
>>> Interesting. This appears to be the same bug as [1].
>>>=20
>>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/287486/=
focus=3D287789
>>=20
>> Yes. AFAICT that version of gcc is simply buggy, and we are not doin=
g
>> anything illegal or even particularly exotic. Given how old it is, I=
'm
>> not sure it's worth worrying too much about it, but I am happy to wo=
rk
>> around it if somebody can figure out how to do so.
>>=20
>> I spent some time trying to bisect gcc, but had trouble getting a
>> working build for a gcc that old.
>=20
> I installed FreeBSD 9 and managed to reproduce the compiler crash.
> After a bit of experimentation, I devised a simple work-around and
> submitted it as a patch[1].
>=20
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/289397

Thank you! That works fine.
--
Renato Botelho
