From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Fri, 24 Sep 2010 00:21:24 +0000
Message-ID: <AANLkTinjwP+UjVstEZ-ny75t5=R3dQfxF2VThooVzSGW@mail.gmail.com>
References: <1285015029-23103-1-git-send-email-avarab@gmail.com>
	<7vsk11sjf9.fsf@alter.siamese.dyndns.org>
	<AANLkTimKp+u2QGhR=zFYTSALcxRUr=LQewYRK83uh+U1@mail.gmail.com>
	<7veiclshoe.fsf@alter.siamese.dyndns.org>
	<AANLkTinMkc6nH2+tLBVym7pSSzvTEBbgiqJSD5w3G3kz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 02:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyw2f-0001bf-H8
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 02:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab0IXAV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 20:21:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41949 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0IXAV0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 20:21:26 -0400
Received: by iwn5 with SMTP id 5so1868649iwn.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nQFaDAdiTwK1m2NClGRTrTHv72lOr/zJgbwXb+9oj1I=;
        b=fL40vXSWz+u24RcHC5mkWZCuHNr4cgpkaHCFrKpVJC6hUJtsmk0Yqvhojb+pmphHO6
         S82gEZodBXlvcd0aUs12tOQKvLAx2x+UeuwXYQ54Zdlbnc9grR8VFKHhz82ABjlr0bKW
         zDwO0wYoBCet9K5G/avFWCtLyEJLIqDkytEQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TeaiJiaMTJdk9r8yFu+BPja7qWq9c89RVces6AiQt4nIJe9x5SRj+kJa6ELFVFHTfq
         JKs/TfmfBpyxJKIaS7TCjpqTMVHZsYqA/qWKaKu+IrRHbg4udCcR27lMKHqGCoEoSeEx
         NG7z88qxISwPOTHigKZqabo63HktAWgIr49z4=
Received: by 10.231.14.140 with SMTP id g12mr2897743iba.84.1285287684702; Thu,
 23 Sep 2010 17:21:24 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 17:21:24 -0700 (PDT)
In-Reply-To: <AANLkTinMkc6nH2+tLBVym7pSSzvTEBbgiqJSD5w3G3kz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156926>

On Wed, Sep 22, 2010 at 19:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Wed, Sep 22, 2010 at 19:26, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Oops, I didn't try running "make doc". I could write a
>>> Documentation/git-sh-i18n.txt manpage, but it would probably be bet=
ter
>>> to just remove the patch adding it to command-list.txt, no?
>>
>> If it is not a documented end-user level command, it shouldn't be in=
 the
>> list.
>
> Ok. I've ejected that patch out for now, and fixed a two minor bugs
> One NO_GETTEXT_POISON test was in the wrong patch, and I completely
> removed the test that checked that $GIT_ROOT/share/locale wasn't ther=
e
> under NO_GETTEXT=3DYesPlease from the series altogether.
>
> I've updated the ab/i18n ref at GitHub, you can pull that.

I ran exhaustive tests on it, i.e. checked out each commit in the
series and ran the whole test suite on each one, with both
GETTEXT_POISON=3D and GETTEXT_POISON=3DYesPlease. That turned a few min=
or
issues that I fixed.

The result can be pulled from ab/i18n at git://github.com/avar/git.git
like before.

I'm *really* done fiddling with it now. At least for *this* pull reques=
t :)
