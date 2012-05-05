From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: simplify __git_complete_revlist_file
Date: Sat, 5 May 2012 17:19:21 +0200
Message-ID: <CAMP44s3gbWCn=dB0sgDLSjfDyWFAj5zzQeHOL0exBMVP2UVgbw@mail.gmail.com>
References: <1335897776-3726-1-git-send-email-felipe.contreras@gmail.com>
	<7vfwbj79od.fsf@alter.siamese.dyndns.org>
	<CAMP44s0z5ghcDQOeL1TrJJ7nw4=tN5MhACqcmf4EjxsNNWiQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 05 17:19:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQglb-0006NV-4V
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 17:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab2EEPTW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 11:19:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37112 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab2EEPTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 11:19:22 -0400
Received: by eaaq12 with SMTP id q12so1057299eaa.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wqHa43fK5SvsuhWHbglKpcyfv8iB23/iadoxmGo5rz4=;
        b=BQExxyub5yp6Ud9NP4vB1stGNy8maBh07myN7J1Xfeq8Kr08jqFQbGTP4hgl0Yf/R5
         HeRbCEvdOTH619WZgIc7Rm1XoS0GWVAosD2Vxs7KnzyyFyhQFO61BPhS2vMwvOrvYEgu
         eWR4nGZ1AvUd5DJFz7Yu3qPaTPdjtaQWf21Ss08daSh7CpBkAQSF4ZtDlxssDiKF1wI6
         A8cLFdcM+9MBmLqNMLrqeZzhIimKJJrmIX71d2xuy6oN5rdl4u5lcY/dJnED2XApVESo
         yrEF8yMdOJwIxc30O0bzqtzY8XwW/EARI5/N9d5ech1H8RS2bADNjUtZcO/jR9vAYLr7
         v/rw==
Received: by 10.14.96.129 with SMTP id r1mr1749551eef.86.1336231161209; Sat,
 05 May 2012 08:19:21 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 08:19:21 -0700 (PDT)
In-Reply-To: <CAMP44s0z5ghcDQOeL1TrJJ7nw4=tN5MhACqcmf4EjxsNNWiQnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197117>

On Wed, May 2, 2012 at 1:46 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 2, 2012 at 1:39 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:

>> I see this was not addressed to me (neither was the other zsh one), =
so I
>> take it that the patch is still for discussion, at least for the pur=
pose
>> of today's integration round. =C2=A0Ping me when it is ready for eit=
her 'pu' or
>> 'next'.
>
> I'd say at least one person should say LGTM before asking you to inte=
grate it.

Nobody has raised any issues with this, so, please merge it to 'pu'.
This is so straight-forward that it might make sense to move to 'next'
through.

Cheers.

--=20
=46elipe Contreras
