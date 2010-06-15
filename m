From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Tue, 15 Jun 2010 03:10:45 +0000
Message-ID: <AANLkTimWDB4bULi6BwzwCF-euScTqyU-WILIuqocDJLQ@mail.gmail.com>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
	<m3631lp9oe.fsf@localhost.localdomain>
	<AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
	<AANLkTinsD3WVpldxSS2K1Gk05D87nQv_rA3D-BjlBXGD@mail.gmail.com>
	<7v1vc99em7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 05:11:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOMYE-0000AP-4z
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 05:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359Ab0FODKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 23:10:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62322 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab0FODKq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 23:10:46 -0400
Received: by iwn9 with SMTP id 9so4048716iwn.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 20:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z/W9Gn4AYnzAM0lM72ezeRjIfh4GxSlz1NZvvg/8C+A=;
        b=Bss5q8KpwfNhyszYZy3SM0HhhB7tzQv2zo4ahYwT/nVF9SADKflJLoghc/ALHzoBom
         iymuhC3v0YVk5Xz3LKrYn0xM12H40oKXAwKZRfkMQqiS9WBIJ0uVsE3sATXK/kKHBjBW
         1y6lG+yl+IBqUa1wQEtWO4TBkNQZfg1NUeMw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GZhQ9uce/qU8r4dJHcvRImgA4TbK8PwstxRCN5piKkNLiJFBQ1rSZNIfmGMq+alg6B
         Hc1mjlaSuDfvqsiTy7/s9N02hYWMqrNHgWNlI+R3y9XOKbR37GIBrKY8Hu+HjK9oCK1W
         oldDd7LFMRZpKwfw9tx3nR4I0ZuDaiuQIC7kQ=
Received: by 10.231.188.156 with SMTP id da28mr7373813ibb.196.1276571445860; 
	Mon, 14 Jun 2010 20:10:45 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Mon, 14 Jun 2010 20:10:45 -0700 (PDT)
In-Reply-To: <7v1vc99em7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149153>

On Tue, Jun 15, 2010 at 03:08, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Jun 14, 2010 at 22:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
>>> On Mon, Jun 14, 2010 at 21:49, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>> I'll re-submit a version of the patch with a better commit message
>>> which addresses all of the below.
>>
>> Since the series just made it into pu is that still wanted or needed=
?
>
> It very much is. =C2=A0There isn't that much difference between being=
 in 'pu'
> and being in the mailing list archive. =C2=A0Queuing in 'pu' is just =
to help me
> not to forget about the series, nothing more. =C2=A0Depending on how =
further
> discussions go, the series can be replaced with an improvement or eve=
n can
> be dropped as a whole as unusable.
>
> In this case, the explanation in the commit messages and/or documenta=
tion
> are found to be lacking, and you already know what the improved versi=
on
> should look like, so I think it makes sense to replace the series wit=
h a
> new version (v3?)

Thanks for the explanation. I'll submit an better version of it soon.
