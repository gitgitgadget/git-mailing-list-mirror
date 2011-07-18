From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/17] sequencer: Announce sequencer state location
Date: Tue, 19 Jul 2011 01:14:31 +0530
Message-ID: <CALkWK0n4yXJ8HvCzcXMUda6oUyC2M32n25Sn5oKPzw0Huqvo8g@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-11-git-send-email-artagnon@gmail.com> <20110712185638.GA14909@elie>
 <CAGdFq_ijTh-m7+zRFAyqvhN5k_BrC1TPdc3y47h=tBUiz6QF2A@mail.gmail.com>
 <CALkWK0k1pX6rjGh8U6ZdDFk3qFcbj-UjU-Q-Z76hn6HV46pncg@mail.gmail.com> <20110717191931.GH27787@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 21:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QitkR-0003Kg-49
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 21:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab1GRTox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 15:44:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61586 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1GRTow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 15:44:52 -0400
Received: by wwe5 with SMTP id 5so3500813wwe.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=z4d7teQuDXN9dABbxd0OJYkuTh87+1gG/A50BAMdHJA=;
        b=dztXLcElx2rTYJ6gzE3eVixl2wzNmnzz9Wa+M00YOGsc7LXpkdv4bJ1aft78cbMsRO
         PwHpC40ErePSyZOzfTa/6ak21GR8NzHnnUsgODQQ5Cwaf42e84fdlaGd6FW+1Vt1B3lU
         mW9lkKPaaPTgABKe3q8d5fErMo6DYpG9Ve+v4=
Received: by 10.216.175.206 with SMTP id z56mr1677527wel.66.1311018291108;
 Mon, 18 Jul 2011 12:44:51 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Mon, 18 Jul 2011 12:44:31 -0700 (PDT)
In-Reply-To: <20110717191931.GH27787@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177401>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> I don't think we should advertise it on stdout or stderr. =C2=A0I th=
ink of
>> a safeguard that only very few people will use. =C2=A0Ofcourse, docu=
menting
>> it somewhere like Documentation/technical will make sense once we ha=
ve
>> something usable.
>
> Yuck. =C2=A0Documentation/technical is for API, protocol, and design
> documentation. =C2=A0One should not need to read Documentation/techni=
cal in
> order to be able to use git!
>
> If the worry is that such a hint would be too noisy, it can be
> protected by a configuration variable using the usual advice
> mechanism.

Okay, although I'm not inclined to do this right away.

>>> If I were doing it, I'd squash this with the patch that introduces
>>> "git cherry-pick --quit", to give an example of how the new functio=
n is
>>> meant to be used (and tests!).
>>
>> I would have done that too, except that the "reset: Make hard reset
>> remove the sequencer state" patch depends on this. =C2=A0So, I don't=
 think
>> it's fair to squash it into either patch.
>> I can definitely write a better commit message though (wait for the
>> next iteration to see it).
>
> Would it be possible to introduce "cherry-pick --quit" here, and make
> the later patch only do one thing, namely adding the check to prevent
> a cherry-pick in the middle of a pending cherry-pick?
>
> In other words, I don't understand why the "reset --hard" workaround
> would need to come before "cherry-pick --quit".

*pants* That was quite a challenging rebase.
I think I managed to get it right after several attempts -- we'll find
out soon enough.

-- Ram
