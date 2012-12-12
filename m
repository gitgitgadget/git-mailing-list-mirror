From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Thu, 13 Dec 2012 00:49:02 +0100
Message-ID: <CALZVap=4hx6bwbuDpR5PUt-b6EtVAskw1FRo5N7zuvQRcGaqdQ@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org> <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org> <CAH5451=4dqqMnQa-R6O4ZrHOPSpHU9joWqf2UuOkbLtU9f8bkQ@mail.gmail.com>
 <CALZVapnzYBhPU1nR=eCSnm73c9-SpHq34DHu7OWCkouCQS0FxQ@mail.gmail.com> <7vobhy25wd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:49:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiw3Y-0003ol-3H
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab2LLXtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:49:23 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38812 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab2LLXtX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:49:23 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so5432370qaq.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 15:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qM138FyTEPWVwcoFe+nz/Epgfo2GUao8PRfqM1gbAMg=;
        b=fxq84MbftB8NF5GWxB4E6DJaOP5yrz2okiLod059bWga5jU8YUygNDSJTWQvagPwCw
         U/lylFIidc/L40s3cugkMoxTkuUTKrPI7rvDzkNIIhuwj0gJ0KTQ/k5a0DkKyabv7dtK
         0267FG/OjYlcUtGOKg1qnUnkk99OD/t2CSKGoayl9eAZqr6cDZ4YnALA0dlMvQ3so8En
         LddIAecQ+PWKC3pFm+tPpWFzhGndHBzSelodxZzCis6PkNWelZp+VARvE98c7s7ln/DM
         4dnncyTiCktG2ZUsTgQYNI+zoQ3fri0j+hSZp3ujDOIGs1rEmwVZTyO+5fccbPOe1lqu
         7QqA==
Received: by 10.49.48.45 with SMTP id i13mr6103155qen.48.1355356162306; Wed,
 12 Dec 2012 15:49:22 -0800 (PST)
Received: by 10.49.63.68 with HTTP; Wed, 12 Dec 2012 15:49:02 -0800 (PST)
In-Reply-To: <7vobhy25wd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211422>

So, how can it be fixed? or is diff command's problem?
Javier Domingo


2012/12/13 Junio C Hamano <gitster@pobox.com>:
> Javier Domingo <javierdo1@gmail.com> writes:
>
>> I must say it is _quite_ helpfull having the diffs well done (natural
>> diffs as here named), just because when you want to review a patch on
>> the fly, this sort of things are annoying.
>
> I do not think anybody is arguing that it would not help the human
> users to shift the hunk boundaries in the case Kevin's original
> message demonstrated.
>
