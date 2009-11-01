From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp time 
	with --claim
Date: Sun, 1 Nov 2009 21:14:56 -0200
Message-ID: <55bacdd30911011514r1be6e09fobe2751588ed5166e@mail.gmail.com>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com> 
	<1257101127-8196-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5sixbd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 00:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4je1-000568-CH
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 00:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbZKAXPM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2009 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZKAXPM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 18:15:12 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:63805 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZKAXPL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2009 18:15:11 -0500
Received: by gxk4 with SMTP id 4so3747112gxk.8
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 15:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fFsWX7QHG+dHQ7owR0r3QH6iIDjyE6ydszu9QijDjaU=;
        b=XFTsphZjFXEXm1NCGxbvu9iBLi6yE3KQJUBFnFBBDPfG8Go0V86hmtaEtJ8Zojo2ok
         jdJ6mJK222+y9hktBpB/8CgDGjMw2ZvM+r/BcSKQxXasQHV7bSUKsczX9aGG3jqmkUpS
         Dcx0/gUIwKuBf7lJFilQdW9Arbb7nMr+ei/xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uHhZ0sJT/1WO2xoy2oOLt/MYx+6tasD2PRBUJQYDt/fKr9wQewZxYrGmHfKgc5KpRd
         fsZCLA4+pNGjR/GnitR6uGFP6DnwjH2YKvKPGxHJ1jxoryoEhwlkPxEV+UBmQb6oJv9q
         icgg9XAnOXPlr6bjTXaV/ToX4tdCIsodbrbT4=
Received: by 10.150.128.14 with SMTP id a14mr7192563ybd.221.1257117316098; 
	Sun, 01 Nov 2009 15:15:16 -0800 (PST)
In-Reply-To: <7vr5sixbd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131883>

2009/11/1 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> + =C2=A0 =C2=A0 OPT_BOOLEAN(0, "claim", &claim, "acquire authorship =
and restamp time of resulting commit"),
>
> It is unclear from where it is "acquire"-ing, nor what "restamp" mean=
s.
>
> Here are my attempts to come up with better wording:
>
> =C2=A0 =C2=A0"ignore author and timestamp of the original commit (use=
d with -C/-c/--amend)"
> =C2=A0 =C2=A0"the commit is authored by me now (used with -C/-c/--ame=
nd)"

Two new suggestions:

"reset authorship and timestamp to you (-C-c/--amend)"
        # On this case "you" can be changed to "commiter" but the text
is going to be bigger
        # and wrap.

"make me new author with new timestamp (-C-c/--amend)"

I am just waiting for your answers to this e-mail and to the previous
one so I can send you another patch.

Regards
