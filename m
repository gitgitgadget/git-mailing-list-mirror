From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: fix issues with COMP_WORDBREAKS
Date: Mon, 16 Apr 2012 13:44:58 +0300
Message-ID: <CAMP44s3cM5nZnN6W6KCw-aVdT_-Ax1YTopHkR6b0msSsHhQDmA@mail.gmail.com>
References: <1334524654-13482-1-git-send-email-felipe.contreras@gmail.com>
	<20120416003850.GH5813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 12:45:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjQg-0007ED-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab2DPKpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 06:45:00 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41611 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab2DPKo7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 06:44:59 -0400
Received: by eekc41 with SMTP id c41so1252243eek.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=swkJbbY6msNhXYvdYS3dzey8PQJwBOaJ4stKMgercQM=;
        b=xhpTYt+ZjgY/8QhFKTJDGHwE+UJV0VxPIfBpfvCaN3n/i9ABZKv/ce3y7+bvhz2Jyk
         zeYDSxM5fxcqwhyEj3fj0Vm68XJEfjo5ZOWuM/L6v9B0jVOFRfGtvzEccf2hRNneimv5
         qG19acph14xgiy4uwdLerIEkkgo6kispu3h+YnkF+0Yips2stC1OR1y1DpxGgyP4pUM6
         valNZ7REf3lqaxMjliHFgyOQqqm5rqGW6Qa38Kd+BM/KHq8F9Mj87sO6u2ON6m0tjdLW
         ORyrSQSAC9b6mpDAkc0iMawvr2DwdwHX+pQ74m5lwik5uZFg8g+onWKpNoKH0Sm9R933
         9RZA==
Received: by 10.14.96.6 with SMTP id q6mr1504756eef.6.1334573098508; Mon, 16
 Apr 2012 03:44:58 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 03:44:58 -0700 (PDT)
In-Reply-To: <20120416003850.GH5813@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195610>

On Mon, Apr 16, 2012 at 3:38 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> In fact if COMP_WORDBREAKS doesn't contain a colon the completion ge=
ts
>> all messed up. For example:
>>
>> =C2=A0git push origin master:<TAB>
>> =C2=A0git diff master:<TAB>
>>
>> The "master:" prefix would be added again, unnecessarily.
>
> Thanks. =C2=A0Yeah, that sounds broken.
>
> Unfortunately the patch introduces a regression: if after loading the
> completion script I set COMP_WORDBREAKS not to contain a colon, then
> with the current completion script
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git show HEAD:Docu<TAB>
>
> completes fine, but with the patched completion script it seems to
> get confused and strips off the HEAD.

I don't understand, I tested this and it was working fine, but not any =
more =3D/

Maybe I was testing on zsh.

I guess this should be dropped then.

Cheers.

--=20
=46elipe Contreras
