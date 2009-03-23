From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 8/8] user-manual: simplify the user configuration
Date: Mon, 23 Mar 2009 13:02:23 +0200
Message-ID: <94a0d4530903230402y402daf8fw822f87feb6e9fd8c@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-9-git-send-email-felipe.contreras@gmail.com>
	 <0A3F8ECD-EEFA-4DB0-AFED-AEE7DAFE8DB3@wincent.com>
	 <94a0d4530903221601hb3bf8aelf98b22ee560dfb7b@mail.gmail.com>
	 <7viqm1az1k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 12:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llhx7-0005Gq-L6
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 12:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbZCWLC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 07:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755386AbZCWLC1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 07:02:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:42166 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbZCWLC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 07:02:27 -0400
Received: by fg-out-1718.google.com with SMTP id 16so350527fgg.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kyjcBH0pMPdcnnTzP4th7FVUshUHhpGfpReFDU5h/pc=;
        b=dlBAOW7/Gm8oKLW54wShrL2TC6TatuPXQlmr0bXckA2odrsW6jSzp1cMWP0fvUv+L9
         nv6o8jT6AyBpaShM8QBDOWMbHQO8s4PPaonyOJ6am4tMYxngVZlj0YnpNbYQiZYMG5os
         ZXuw/1PUaNrrcnXcs4Et6AgkS+u24jwbBGiaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NWNv6jA3iXgadcZT/M5vovRyDdbDYCvk51OeYMTSpwYP3+mYwWsHzaRvPmrZGxsDmr
         QBAbkHeNUjil827uLnUM3tkq7d1EzigpHswz4AlNlg0H0YkJUVXQE3Zzz8joEHHir75j
         9POG79z9degVl7BnmoVbI40jxZNQ7H1ALRHb8=
Received: by 10.86.65.9 with SMTP id n9mr3507975fga.55.1237806143965; Mon, 23 
	Mar 2009 04:02:23 -0700 (PDT)
In-Reply-To: <7viqm1az1k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114289>

On Mon, Mar 23, 2009 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> See this lengthy thread:
>>>
>>> http://article.gmane.org/gmane.comp.version-control.git/106634
>>
>> I've obviously seen that thread because I started it.
>>
>> Can you write more than one line to explain your point?
>
> The "lengthy thread" look lengthier than necessary because it has a
> more-or-less unrelated side topic ("where is $HOME on Windows"), but =
I
> think the main point by WIncent is that onus lies on whoever repeats =
the
> previous discussion to provide what is different in this round to con=
vince
> others to read the patch. =C2=A0For example, this
>
> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.git/=
106657
>
> was not answered by you in the previous round, and I do not think thi=
s
> round is any different.

Was I supposed to answer it? I am trying to address the points raised
in those discussions in this patch series.

> I personally find that between what Wincent presented in
>
> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.git/=
106673
>
> as "Something like either ... or ...", the first one that shows the a=
ctual
> configuration file contents and then mention 'git config' a good enou=
gh
> compromise.

Except that in the previous patch[1] (#7) I'm adding a new global
section that explains how to configure git in different ways:

I don't think it makes sense to explain "either ... or ..." each time
we deal with 'git config' in the manual if it's explained in the very
beginning.

[1] http://article.gmane.org/gmane.comp.version-control.git/114163

--=20
=46elipe Contreras
