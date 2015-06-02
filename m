From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC v2 2/2] git-am: add am.threeWay config variable
Date: Tue, 2 Jun 2015 22:37:13 +0800
Message-ID: <CACRoPnSZ77mOvqRn+PLauDyQtjU8gDvtUKPmUzLo6Hc4CE+RvQ@mail.gmail.com>
References: <1433251472-29460-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqvbf6jko8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:37:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YznJh-0002AC-F8
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759317AbbFBOhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:37:17 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33792 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759077AbbFBOhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:37:15 -0400
Received: by lbcmx3 with SMTP id mx3so105789640lbc.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PUkbgA9vzZPuVl8h4DHaPVLVOmwO2LDMJjuzRhf9eUg=;
        b=DZTsXAHYpjtOySIhtiv3Skj/6wldWyG+qum+0ViOmGziePSjz9k7CiV6ymEIGMV3PA
         T5Ce0/X+Jgcec17eq3c60B9h3izn+Ysem4fd3FAicTSza6vRTiKR7LFDCDeEuMYx7k2V
         gJnEk3xmYtHT3P20i+JoGeCaknlVDsRnsAQ64LeYaTEAcEf/MIp/Ob3pbrXGf32i7M61
         K62ULIds+tTeAn1hcDAXcE4S2J7eyOtsJjT6cdGzHZaR2UBijbl9OyE2pySR3puDD7U2
         aPSmMitiRfil2F0Wi1r1vE3scwgac2/3BUelHHvHuKAA9Zw0r3f9u2Ivz1gebkSMF7jO
         Pv9w==
X-Received: by 10.152.30.4 with SMTP id o4mr25587977lah.74.1433255833778; Tue,
 02 Jun 2015 07:37:13 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 2 Jun 2015 07:37:13 -0700 (PDT)
In-Reply-To: <vpqvbf6jko8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270552>

Hi,

On Tue, Jun 2, 2015 at 9:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
>> +if test "$(git config --bool --get am.threeWay)" = true
>> +then
>> +    threeway=t
>> +fi
>
> I think you missed Paul's remark on this:
>
> http://article.gmane.org/gmane.comp.version-control.git/270150
>
> Not terribly important since am will be rewritten soon, though.

As the person who had to do four preparatory patch series' to fix bugs
for the rewrite of git-pull, I respectfully disagree ;-)

Regards,
Paul
