From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 2/2] completion: complete config variables for 
	--get/getall/unset/unset-all
Date: Wed, 13 May 2009 11:50:39 -0700
Message-ID: <780e0a6b0905131150q30e0bcacrff69cd78cd96ff34@mail.gmail.com>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com> 
	<1241832213-23070-2-git-send-email-bebarino@gmail.com> <1241832213-23070-3-git-send-email-bebarino@gmail.com> 
	<20090509034438.GZ30527@spearce.org> <4A09071A.1030107@gmail.com> 
	<7vtz3q91up.fsf@alter.siamese.dyndns.org> <780e0a6b0905121205r7a57a99as2cb0b94ead73199d@mail.gmail.com> 
	<7vtz3o4zu2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 20:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JXr-0007HX-NQ
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760381AbZEMSu7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 14:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760247AbZEMSu7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:50:59 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:12423 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758571AbZEMSu6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 14:50:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so1371902and.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qNvrrV+yeWRW0a3v31c4F5JXWY8OELV+PLwuyXisyZk=;
        b=rtC3SHq6EOi3rJ4LnJYXoIDZN0WA8YK46MHNhZuUwMbiiS3OX4w2vmhZ624bI9QlIm
         MyaXGxjkVuFwvD9gUKvDAbXy6yi7ybJ8c/2qz6RzEDxgVCsIgkUi5bWoFpvwpvlWcDbM
         7Dy7CE+JG/YnDMXS7dmIWE4NKRnybKohQbqrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gyHkvvZCkD9wdFONWT2Z1/l8kywnwxRBeBBotSJYIi/QQqPzbvMnYh1MGXuY2Bw2NM
         gAJuF/JEJHwAS8L5DlnY97DL+otpyMpNhp22nAlC956cfFlnValfNrKfKgQ3udXLaHrh
         P/bqNZqQrVOIrBxbrvywBfDmIG4+seUrHRwlw=
Received: by 10.100.128.18 with SMTP id a18mr1843854and.12.1242240659275; Wed, 
	13 May 2009 11:50:59 -0700 (PDT)
In-Reply-To: <7vtz3o4zu2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119088>

On Wed, May 13, 2009 at 11:33 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>>>> Subject: completion: complete config variables for
>>>> --get/getall/unset/unset-all
>>>
>>> Hmm, shouldn't this just be
>>>
>>> =C2=A0 =C2=A0Subject: completion: complete variable names for "git =
config" command
>>>
>>> ?
>>>
>>
>> This patch adds completion for set variable names when --get,
>> --get-all, --set, or --set-all has been specified. Completion of
>> variable names for git config already exists. Maybe this would be mo=
re
>> clear:
>>
>> Subject: completion: complete set variable names for git config
>> --get/get-all/set-set-all
>
> Actually I was shooting for shorter description. =C2=A0It is more lik=
e
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bash: complete variable names for "git con=
fig" with options
>
> perhaps?
>
>

Heh, ok. This sounds fine.
