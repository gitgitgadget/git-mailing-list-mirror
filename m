From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Sat, 12 Jun 2010 09:19:50 -0700
Message-ID: <AANLkTilPq8JYTodCA17Wt2G1QZZValgPlbC7sM_neHU4@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
	<422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
	<4C12B20F.3080709@gmail.com>
	<AANLkTinec7_D-WHRfetVRVvmG0EGoW4ZTdiTvoGMgJvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Wincent Colaiuta <win@wincent.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:20:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTR7-0000Zo-QG
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab0FLQTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 12:19:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33036 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0FLQTw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jun 2010 12:19:52 -0400
Received: by wyb40 with SMTP id 40so2092430wyb.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ylJo9fqWA9BEv/kTlb+4gMbUmRv/8nlnkSB3BoUeT9E=;
        b=L7WLFMPbJK6Vd7zcfSEJeICxVyPfCs/a9P9kpgX6gb2YjiJb9c8ngZkVOeAh9XF+ea
         wjEC5Z3ULtdFPzIMcSEmvDQjVM3EBGmrHrz+StahgyH82uAYhifpzGdIAJtzFpf3pbNV
         FbmqZvFXhXZNLfvbMkVgfLiUtJLyZm/m3c8Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wyFKztrRTlJRIHYC0SQnZ910o0AFWxWQTOCLoyy7k67e+w7b8S7tBBP4vMrLwgPSHa
         3HhyIGdB0I6fEFZo/42BRbu5mwruGEBpI4SMU8HPnTqvs4DPU9kYZFZhIGbHo58uZx59
         inqcj0SCGkIEXLx0aamXYOlFQb0wuvagkRY0o=
Received: by 10.216.164.20 with SMTP id b20mr632305wel.101.1276359590916; Sat, 
	12 Jun 2010 09:19:50 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Sat, 12 Jun 2010 09:19:50 -0700 (PDT)
In-Reply-To: <AANLkTinec7_D-WHRfetVRVvmG0EGoW4ZTdiTvoGMgJvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149011>

Hey,

On Fri, Jun 11, 2010 at 3:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Jun 11, 2010 at 22:00, A Large Angry SCM <gitzilla@gmail.com>=
 wrote:
>> Can a command be listed twice? Some of these commands _really_ belon=
g in
>> more than one category.
>
> Of course it can. But what specific commands do you mean?
>

=46or the sake of brevity and clarity I would prefer just choosing the
most appropriate category rather than putting any in there twice.  I'm
trying to stay as close to 25 lines as possible, which is also why I
now think we should remove 'show' from the list, too.  The point is
not to be as accurate as technically possible, but instead to just be
a bit more presentable to new users - help them parse the needed
command set a little easier than one big list.

Scott
