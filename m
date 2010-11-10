From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: import determinism
Date: Tue, 9 Nov 2010 23:40:52 -0500
Message-ID: <AANLkTi=y_DKRRU43ro3WDz2rSDGL9xASfsinoj8Ya9PT@mail.gmail.com>
References: <20101107202535.GA18766@nibiru.local>
	<AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com>
	<m2lj54u9uj.fsf@igel.home>
	<AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com>
	<m2d3qgu50c.fsf@igel.home>
	<20101109134337.GA19430@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "weigelt@metux.de" <weigelt@metux.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 05:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG2WW-0008Ss-QO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 05:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0KJEky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 23:40:54 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62137 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0KJEky convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 23:40:54 -0500
Received: by iwn10 with SMTP id 10so289404iwn.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 20:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=lt5zsKYbS+5RF0fnpA1k+byBfW5E25AaRPG1IFKpsoE=;
        b=qa+VyzKw4+I6PwC5neGDcLQ8+k0c4QnSzqgjm0ipRK7spsWuZdpvUeU/Eqgnp9OgED
         zhtABeDhtLJuz53/3UcOpXZoHbAwP6Bx01V9QVQkmsM48u7NQRBoYdvTMLXr2+m27u/2
         046PWsJR/dnGQEGP+HWgZgzhZ61rQrdT1zkfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=C56mIyzpzIRcT6PphtjduFRHGdItir5v+/BW6e/04WLm96jz3Og6gNF6moz+nJyFXd
         X3d3bgMgHH/24KMBRepYOGNn3eqPIJlk/gW39q1i4/y8ifWOtQS5RoM+WJBbHkVxMBQN
         c3Gtv4er27oaGO7SJJhxU8xcDuBOIrYt9ZwGI=
Received: by 10.231.59.77 with SMTP id k13mr6087292ibh.41.1289364052455; Tue,
 09 Nov 2010 20:40:52 -0800 (PST)
Received: by 10.231.16.65 with HTTP; Tue, 9 Nov 2010 20:40:52 -0800 (PST)
In-Reply-To: <20101109134337.GA19430@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161131>

Every full clone is a good backup. If nobody is doing a full clone...
the do back them up. That's my recommendation.


M

On Tuesday, November 9, 2010, Enrico Weigelt <weigelt@metux.de> wrote:
> * Andreas Schwab <schwab@linux-m68k.org> wrote:
>
>> > For cvsimport, it is not deterministic. Given cvs'
>> > ambiguous/buggy/inconsistent internal semantics around some
>> > operations, cvsps makes educated guesses about what happened.
>> >
>> > Later commits can affect those educated guesses.
>>
>> The OP was assuming an unchanging repository.
>
> My assumption is:
>
> * the original cvs repo will have later additions
>  =A0(so I'm incrementally importing)
> * no commints (besides cvsimport) in the git mirror, but others
>  =A0for off from there
> * the mirror could get lost in an desaster (no separate backup)
>  =A0and should be recreated afresh in that case.
>
>
> The point behind this is: I'm running a growing number of cvs2git
> mirrors and dont want to do full backups of them.
>
>
> cu
> --
> ---------------------------------------------------------------------=
-
> =A0Enrico Weigelt, metux IT service -- http://www.metux.de/
>
> =A0phone: =A0+49 36207 519931 =A0email: weigelt@metux.de
> =A0mobile: +49 151 27565287 =A0icq: =A0 210169427 =A0 =A0 =A0 =A0 sky=
pe: nekrad666
> ---------------------------------------------------------------------=
-
> =A0Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
> ---------------------------------------------------------------------=
-
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
