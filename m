From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git 
	log --grep=foo".
Date: Tue, 27 Jul 2010 13:46:46 +0000
Message-ID: <AANLkTilUTblhzPKiIsugHMDeK-W4gL4eUyyP6KSZbIb5@mail.gmail.com>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTim1S_IYbPArQqX91OOPtoh2-rIWmTRon50_j2p3@mail.gmail.com>
	<vpqsk355ea6.fsf@bauges.imag.fr>
	<AANLkTikcKd4nEZuot5fyZyiLqwAWl4gQyqtNg2512SKM@mail.gmail.com>
	<vpqmxtd3vj7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 15:46:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdkUe-0002Ss-O7
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 15:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab0G0Nqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 09:46:47 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43430 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0G0Nqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 09:46:46 -0400
Received: by pzk26 with SMTP id 26so1353180pzk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c4w/Lgwx/Dw2IctLYhcbymL6Huzhe/2rmYAdPrAGI58=;
        b=JXeoOxnIMHG/T/t1gR0uf4bfKoyguDXH6jQg2RX2fpd1FBtrdJdCFAg92FFzoaaV7h
         Rfn49maNRqpCTCaU4nUAwjwtar2yyg4C21ye5g7P9WuQdRHPJuWciK3j9cYKpCgLh7Fm
         9dd1tbfD1PhPYTLnzLyFJXpdYwshEechZrZws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TAbNqwRwkd0sEZ93SROSWNh3VyZ76xcxICq4U3Wcg458OKQT1IWz4ikSJRMlPfWfsg
         fjXbgpaMscRmT2yPYuAhvGHs4QqGPxQ7ZBjfOR/bvgl0lSRPbR2P5Iwihfa3AsSlCu4i
         ch3A+6RaNlaDz5X7C7J8FdJ3ngcYY3xWuYNkw=
Received: by 10.114.172.2 with SMTP id u2mr13123092wae.198.1280238406243; Tue, 
	27 Jul 2010 06:46:46 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 06:46:46 -0700 (PDT)
In-Reply-To: <vpqmxtd3vj7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151942>

On Tue, Jul 27, 2010 at 13:26, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Jul 27, 2010 at 11:56, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>
>>> Sure, that's why the patch is just an RFC. I wanted to start the
>>> discussion before diving into the repetitive task or migration to
>>> parse-option for others, and I picked --grep and -S because they're
>>> the ones which annoys me the most.
>>
>> Ah, there was nothing to indicate that,
>
> Except if you read carefully ;-)
>
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This small patch serie is a very early RFC: it implements the featur=
e
>> for just two options.

Ah, missed that. Sorry for the noise.
