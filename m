From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: t7800 test failure
Date: Tue, 24 May 2016 19:20:21 +0200
Message-ID: <CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	<vpqk2ijs8p2.fsf@anie.imag.fr>
	<xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 19:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5G0J-0003rb-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbcEXRUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 13:20:22 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33225 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcEXRUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 13:20:22 -0400
Received: by mail-yw0-f172.google.com with SMTP id h19so22769086ywc.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=MTIn2hLV7hj2DpJakVwkzaMpemU31vXphebAYRfjjng=;
        b=nL8BBRY2qMe9CQrQmT4U9ZDFgvS0QwFfv7DFsEKC3qk9P7sJit1p9F2kvdJHJk7iyV
         dbMCYNBcbBd5QWdxY8Q5nxvrV56+HRICzBksGylA256HHAm/w9wV28k+sGQeDVqM7eWn
         JELe2ZlpK30IaoCFpojGc37CvLcPUIIyePO3Lg9UVgQ8gjcAh6cfUoecvLzni1r9KX2v
         7jzXARJdhnUkzNJiXsJePFA8ruZII3jvwlRR+bnWUyZ44oda5wHZ59iK6OghvRcnDgPM
         SAupK5holr5B7khbmMilm+FoyZhTdpn1+GiNrtoK08Gsn35QGWODL8H5O4e1jLWr61nb
         wH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MTIn2hLV7hj2DpJakVwkzaMpemU31vXphebAYRfjjng=;
        b=j6iTU0qv8GFxLNSmpap4Dvbmf0jCd7klit4LZHhtb5tT5IEjs8GRte576XNNqAMt3V
         MAH7FYfG3BZD8r25GrsgA7LYczgYwqtLF280KvEpHEU3tKKSyv5/tMK7fGazzf38VPja
         1peV462mb8YWyld44tQnmdkXoFSleD/EEjzIB+8IUiToU9X6AdbYS2fmiVmLJxFENa0F
         nhDv3Qk5AsUyz+GqpN9j/NqflyriyXaDHDCgJbW5k8FkRQawv4SJPsA4t91/4EoLmVGZ
         FWvifrXF19URIySBQ23sO/SgPKRJdtf5hBcUBIScSfv/iD3aHDF2Kstqr/eQyxMaDtYH
         A8Nw==
X-Gm-Message-State: ALyK8tITyBS7m9fjj/OAUB7NRw9xgiM2+ph54NkkFEtvcin0qWiy6QxVrcDJ5EQZUS1G7p9ARuwJSxWkBrIMwg==
X-Received: by 10.37.80.133 with SMTP id e127mr2973512ybb.162.1464110421262;
 Tue, 24 May 2016 10:20:21 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Tue, 24 May 2016 10:20:21 -0700 (PDT)
In-Reply-To: <xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295507>

On Tue, May 24, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Armin Kunaschik <megabreit@googlemail.com> writes:
>>
>>> t7800 fails on systems where readlink (GNUism?) is not available.
>>
>> I don't think it's POSIX, but it is present on all POSIX-like systems I
>> know. On which system did you get the issue?

It's not available in AIX or HP-UX.

>>> +readlink() { ls -ld "$1" | sed 's/.* -> //'; }
>>
>> This is much less robust than the actual readlink. For example, if ->
>> appears in the link name, it breaks.
>
> I wouldn't allow it in our scripted Porcelain, but the environment
> of our test scripts are under our control, so I do not think it is a
> problem ("ls piped to sed" has been an established idiom before
> readlink(1) was widely accepted, by the way).

I think so too. Maybe I can improve the sed expression a bit, but
it will never be a universal readlink replacement. But it doesn't have to.
It's defined locally for this one test only and it does the specific job.

>> It would be acceptable as a fall-back if readlink is not present, but
>> shouldn't activate the "ls" hack by default.
>
> Yup.

Ok, how can this be implemented within the test environment?
