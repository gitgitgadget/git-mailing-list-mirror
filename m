From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: simplify __git_complete_revlist_file
Date: Wed, 2 May 2012 01:46:32 +0200
Message-ID: <CAMP44s0z5ghcDQOeL1TrJJ7nw4=tN5MhACqcmf4EjxsNNWiQnA@mail.gmail.com>
References: <1335897776-3726-1-git-send-email-felipe.contreras@gmail.com>
	<7vfwbj79od.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 01:47:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPMmk-0002Z7-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 01:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab2EAXqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 19:46:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60450 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab2EAXqd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 19:46:33 -0400
Received: by eaaq12 with SMTP id q12so9835eaa.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cwbRNCVrywibZaNnPCzkVON5J97KKjpxtqSd2cmdhTI=;
        b=fessVfgZTeR+nAt837wp5MyT+aZxeYBAYs6CkAhT6P1osa6CqpOVnRLjNiLrjxQjVt
         tlZDjwO+C5a6Qzo/Od0H8EXYV/vApWvXr+GAxja7nFwghcyvWNqIbJOPCfoci6S03oeb
         QUuZWlXZErZeaLcU7rr13rSgjuKB2Rp+JMJFPuY6xqVW7bRNsatuxltc+WyXBqtFeXRS
         qoROwK/65csK/EMWyc4loXAHYbUjVlCcCEa94Otx7nx0OtCS6MtsRnadsfzPCx1/Isvy
         8XhVyoxBh/fovRurxtnvrgGolPSp7k5jqrh/vkxVNdpNw68l6wlX0pF0jEwqxzU6RtfM
         Igcw==
Received: by 10.213.15.134 with SMTP id k6mr1865287eba.78.1335915992722; Tue,
 01 May 2012 16:46:32 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Tue, 1 May 2012 16:46:32 -0700 (PDT)
In-Reply-To: <7vfwbj79od.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196770>

On Wed, May 2, 2012 at 1:39 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Use new __gitcomp_nl; this is the last place that uses COMPREPLY and
>> compgen directly.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A06 ++----
>> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 31f714d..d877a23 100755
>
> This seems to be based on 'maint', which has 31f714d, but I see two h=
its
> with "git grep 'COMPREPLY.*compgen' contrib/completion" there, so I a=
m not
> sure if that is where you wanted it to apply.

The last place that is not the __gitcomp* functions, of course.

> I see this was not addressed to me (neither was the other zsh one), s=
o I
> take it that the patch is still for discussion, at least for the purp=
ose
> of today's integration round. =C2=A0Ping me when it is ready for eith=
er 'pu' or
> 'next'.

I'd say at least one person should say LGTM before asking you to integr=
ate it.

Cheers.

--=20
=46elipe Contreras
