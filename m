From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Wed, 23 Sep 2015 22:48:55 +0200
Message-ID: <CANy2qHciYR_=QeEYi-RNG3ay6+ZQk04FUwX1cY+Lf5c-cSJRHQ@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
 <1441633928-18035-1-git-send-email-bernat@primeranks.net> <CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
 <xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com> <CAPig+cS7ObsWjqbLytCKp1PGF+224TYhC734dNa_HXYQ7p+GgQ@mail.gmail.com>
 <xmqq6133a6tf.fsf@gitster.mtv.corp.google.com> <CAPig+cRnVzRoyKOzPSJZd4JK_hB+_CBn0kjg4yYv=wWb-5vf7w@mail.gmail.com>
 <CALYJoz3xoiB2pVT+r0Nz+EYdE91WX6ypdmieMs1uubg=Vs4bog@mail.gmail.com>
 <CANy2qHcy=UD8xBeGVqGuEHVAgEvCSejt4LXk=vtpfQGSRkTg7g@mail.gmail.com> <xmqqzj0e4eu6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R8OhYm9yIEJlcm7DoXQ=?= <gabor.bernat@gravityrd.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:49:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zeqyd-0004d0-R8
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbbIWUtR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2015 16:49:17 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33040 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbbIWUtQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 16:49:16 -0400
Received: by wiclk2 with SMTP id lk2so1683024wic.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=uskxv6nayuOj1XdjY3JMcqorG+Oor00X7u84IE2NtYA=;
        b=ZjVP7oudYHt5suJjgRy8AywlGjwK8zgvtomxNqXAQqiqDFmtKz0Me+zOxwQ+tOnHIG
         k8YlbsAP3fUn2DUZgAeuQOQgP0MtU6gsonxwLEchaprIM+tvkPmWiea0HqyFWJsq1Ibp
         ChHE+lzw/9D/fvlLwF9Mtw+et2Pn76Ovt3br25GQqK8RfkozmCWulgKDJUhFMSZ3Qdof
         45ZtmLX8nhk55HcWLdjYxaUTlcjur3CZKGrE8YF1OBz6R2UG4Zs6UAsUyBsbpctHn46M
         7mHmlJ7GbX6XuGYY8uuWd+jznDTH/kKV4FV/zRUHaBqyCMdK+BDRIKC8v8FKjhDHrWhk
         5eGA==
X-Received: by 10.194.91.193 with SMTP id cg1mr44101076wjb.88.1443041355022;
 Wed, 23 Sep 2015 13:49:15 -0700 (PDT)
Received: by 10.194.72.134 with HTTP; Wed, 23 Sep 2015 13:48:55 -0700 (PDT)
In-Reply-To: <xmqqzj0e4eu6.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: GQdtVdwwdb4Hh5BSCYkjZUY6G-4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278515>

On Tue, Sep 22, 2015 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Gabor Bernat <bernat@primeranks.net> writes:
>
>> On Mon, Sep 21, 2015 at 11:24 PM, G=C3=A1bor Bern=C3=A1t
>> ...
>>> Agreed, :) did not abandoned this, just got caught up with many stu=
ff.
>>> Thanks for the help,
>>
>> So do I need to do anything else with this? :)
>
> If you can fetch from me to see if the output from
>
>     git log -p origin/master..71400d97b12a
>
> looks sensible, that would be good.  There are two commits.
>
> Thanks.
I can sign this off as good and sensible. Nice work, thanks :)
