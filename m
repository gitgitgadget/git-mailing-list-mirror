From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 06/25] gettextize: git-fetch formatting messages
Date: Thu, 2 Sep 2010 20:48:47 +0000
Message-ID: <AANLkTinZnaJDfhpec2UM-qVkQDc5Opif-GnUfnzP8f8Y@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-7-git-send-email-avarab@gmail.com>
	<20100902195936.GA2531@burratino>
	<20100902202816.GA20362@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:48:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGiJ-0005ce-Sw
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118Ab0IBUsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:48:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49742 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab0IBUss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:48:48 -0400
Received: by fxm13 with SMTP id 13so623692fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lfKbYl5mIIFoHJZFhJdexhdc/P/3+aNqvHA9c4509Cc=;
        b=d/Kv/8I6Xb0sIfIWj/hyzYabcZH1PUGrqhaK+vvYj0xhv/ntlNc+ThY6/x65aDTlWY
         eb+eALccckeCl1vNIuZ2huGnLs91BAENZ/FA7pIDtLLLCphvoJ7QKEsMYrPsvv385jJz
         OTZSzjMBIFNCwZT94nH3ElArqWZMXKhOOFacA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sCry6CqFgRWBBxUgkD3VDk+f0HPNQ/RX1jAd6ULwxgQrfkQ4xrNEMeU+/ahJdHWUvd
         d2IDW6YHLBCT7QHrZ6sLKoNyNDW0ZNL9A8isQ5FHFyZbjdeKo2qG32ChLSE/LdVA7nq3
         siG9YNZs7KJI5QvN7MOaA84LBlFuqnRfhP91c=
Received: by 10.223.124.205 with SMTP id v13mr4238623far.24.1283460527548;
 Thu, 02 Sep 2010 13:48:47 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Thu, 2 Sep 2010 13:48:47 -0700 (PDT)
In-Reply-To: <20100902202816.GA20362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155204>

On Thu, Sep 2, 2010 at 20:28, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 02, 2010 at 02:59:37PM -0500, Jonathan Nieder wrote:
>
>> (+cc: some fetch ui authors, just as a heads up)
>
> Thanks. I think Nico actually did the fetch code, though, and I more =
or
> less copied it for push.
>
>> > @@ -249,8 +249,8 @@ static int update_local_ref(struct ref *ref,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If this is the h=
ead, and it's not okay to update
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the head, and th=
e old value of the head isn't empty...
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(display, "! %-*s %-*s=
 -> %s =C2=A0(can't fetch in current branch)",
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T=
RANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(display, _("! %-*s %-=
*s -> %s =C2=A0(can't fetch in current branch)"),
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T=
RANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,
>>
>> Regardless of the answer, we should probably be either consistently
>> translating or not translating it within this patch. =C2=A0e.g. for =
not
>> translating (though I suspect translating is the better choice):
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(display, "!=
 %-*s %-*s -> %s =C2=A0%s",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pretty_ref, _("(can't fetch in current branch)"));
>
> I think you can translate "[rejected]" here, too.

Thanks. I missed that one.

> However, do be aware of the --porcelain output for git-push. It was
> tacked on much later, and I fear it may use some of the same strings.
> Some of them are perhaps OK to translate (the human readable bit at t=
he
> end, e.g.), but others maybe not. I haven't looked closely.

There's probably more potential issues like that because I didn't know
the code well, but hopefully not too many.
