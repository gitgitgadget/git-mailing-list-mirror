From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Mon, 4 Apr 2016 22:12:59 +0530
Message-ID: <CA+DCAeRqY7-qZt-upa5=nY8OkUL4Q76ogk5nrF_WAaiFiWOy1A@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
	<CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
	<CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:43:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an7aq-0003LH-LO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 18:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbcDDQnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 12:43:01 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33764 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbcDDQnB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 12:43:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id d3so2452574qke.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=9jAED6Eb3Qxvegjk4KMP45zxyblz4nPjB2PQhgPgw0Q=;
        b=fMDCmkvqK5pAh2Ah0G3MHOkCPUfcWTjlFsHQo7H+TFELIOeldyhn8OmRVZS2L2SFk+
         6xLxQV0QAyrMD4dXm0SY5Ltn+45RGE5A2DnI6LiE/dmu4+Q+OQ5M1NUgIXTHPnXzgFl3
         3+vDzQFF5vbTFt7XhUJE1boflH541Pl9+KImqc5pPoCaWQfiNZQULcOc/DJ+PWGsHphE
         mQHwmON+6D5zHTK41TDSBXv7bgYzRsZev+RqzJhtU6W6qWQPqohDJXP/asuovQHpnoeh
         Neb33ocyyos1Qu/wBRJBNUHpKmGjpHkeVqKUdde0Ql07K0vxQN54OGQ9P2E3DZ/4Khl3
         qPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9jAED6Eb3Qxvegjk4KMP45zxyblz4nPjB2PQhgPgw0Q=;
        b=PHiaeGnDEERmjHHXjqgtornEUzaHbVbV67MGgRmKc3S7eW3+aU7UrScpp+WNBvHmPW
         /uwe8MckursMOqMa99SPY6lyDBz8BDuDknt2LOnm7OeS8NVUXbJcn/vDtqXY4Ema/OFi
         hkCWtlzXtoKTQgNKRuvHpjd0lbD3YyIhgUL+fsdEQv1YFJDjyPf5OPsZHM64tfbOCVXC
         EP38KNTHRa+BtaclfNaMMVhNikPaIuTUChbp1ciE2tm+Vtn9EvwSoz03iTx7E6qMxe28
         fpr4ShKcEg838goUWqdxCDqf2drIcHeFhbiNPNtjm7uTNrwains+k0WDDiDWnQ6mOA4e
         vEPg==
X-Gm-Message-State: AD7BkJJlBZ++pdXQoMWUW4NeodfpF67vLZg9Ci4QFUm996YMlIDSDEaMuQOetjSydtlGJISQ5NKzehEFAxgt/g==
X-Received: by 10.55.79.207 with SMTP id d198mr33893620qkb.49.1459788179922;
 Mon, 04 Apr 2016 09:42:59 -0700 (PDT)
Received: by 10.55.10.135 with HTTP; Mon, 4 Apr 2016 09:42:59 -0700 (PDT)
In-Reply-To: <CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290696>

On Mon, Apr 4, 2016 at 12:58 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Apr 1, 2016 at 6:27 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>> In test_autostash() there's a line
>>
>>     echo test_cmp_rev HEAD^ copy &&
>>
>> Originally it should have been
>>
>>     test_cmp_rev HEAD^ copy &&
>>
>> but this raise following error while testing
>>
>>     ./t5520-pull.sh: 684: eval: diff -u: not found
>
> This is caused by the custom IFS=',\t=' which is still in effect when
> test_cmp_rev() is invoked. You need to restore IFS within the loop
> itself.

Thanks for pointing it out. I made a mistake by not considering
the consequences of setting IFS=',\t='. I tried it out again and
this time all tests passed perfectly.

I should  been more careful in the first place while playing
with IFS, but instead of that, I kept on thinking that there is some
other problem with the script which lead to me making foolish
changes in the script like putting an echo before "test_cmp_rev ...".

It was nice of you to take out some time and point it out :)

Also now that I have sent v2[1] of this series, which goes
in different direction as far as implementation of these tests
are concerned. I think the script now is useless (but I
learned a bit about shell while writing it).

Thanks,
Mehul
