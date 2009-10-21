From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Wed, 21 Oct 2009 13:29:09 -0400
Message-ID: <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> 
	<alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <7vzl7pyvzl.fsf@alter.siamese.dyndns.org> 
	<7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com> 
	<7v7huspjg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0f0B-0003GS-47
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbZJUR3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 13:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbZJUR3Z
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:29:25 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:37945 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbZJUR3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 13:29:24 -0400
Received: by ywh40 with SMTP id 40so4703755ywh.33
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=74GZmRlrVYnW7IsDc5OnrqmNvQtWAoQjvklDrmqb3GU=;
        b=IJLiRe1ymRIK9LdHU0j+uLtaSaO2BXOM45Sn2NMTdbVDoOV1J4MpBYk5hFwvQml2SX
         4Ol8YK/bQYPKvfj0JI+wBINRM+4JG8pAprzvDHkixLvo+2tXn3aE3tgIZ+R6mW2KlV/g
         lIaKENluRwyNcRLMpQAt5LlU6TUX69PLL+iPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VRsS82VGfNCpEa0UWXqhc5NM7c841GmX95AgQbkBURmFJy0/LOQqxTO5vWMt0VNpIw
         0X0I8VYN9WW8I4mPJ8MAdtfhC4yJrTsKJN4aikxG41cScw12J0IxUOYwXTnFfftQqlQw
         IciqyrpYIA8L4vkTMXHqnNXod/QwJFTI3mIZ8=
Received: by 10.150.89.8 with SMTP id m8mr13473324ybb.310.1256146169217; Wed, 
	21 Oct 2009 10:29:29 -0700 (PDT)
In-Reply-To: <7v7huspjg0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130943>

On Sun, Oct 18, 2009 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> On Sun, Oct 18, 2009 at 10:01, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OPT_SET_INT(0, "nodwim", &dwim_new_lo=
cal_branch,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "do not dwim =
local branch creation", 0),
>>
>> Isn't there a special negation support for --no-something in parse-o=
ptions?
>
> There probably is, but this is a whetherbaloon patch without document=
ation
> and pretty much Porcelain only, so I took the lazy route.
>
> Helping hands in polishing it up is very welcome.

I find the idea of an option for "don't do what I mean" to be pretty
entertaining.  Or maybe just misleading :)

Have fun,

Avery
