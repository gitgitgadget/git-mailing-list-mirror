From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] reset: update help text
Date: Sat, 2 Apr 2011 15:43:44 +0700
Message-ID: <BANLkTi=m-MYaQZ8_u8-CAXPaVpJi9QDkTg@mail.gmail.com>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
 <20110329210457.GA14031@elie> <AANLkTiknvWE9Fe3u88Jbis4Cgxd5ubqaR6MzYOJZ-AtM@mail.gmail.com>
 <20110331184246.GA19264@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 10:44:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5wRR-0005Xn-PP
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 10:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1DBIoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 04:44:15 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:46964 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab1DBIoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2011 04:44:14 -0400
Received: by pxi2 with SMTP id 2so1135561pxi.10
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=X8P10pDrqnfdLLvHy2EqAFFnvm5dydnDU4KqdjUWpk8=;
        b=nhimW3AxT4FZUddDJ6R7sXGYI60DUJbcgZLw7kwZmyfNzAHI0dr0d77mcOtum1nWCx
         sBxLaGbpn2H+lEtM6NqpW04IIysTZVUE7xffileyMQJo5wOKON3tQ0jZT97Qarzw6rfF
         fm+zdlDuyKvKKv7tLrdMgQoTg65Pn0Y9r0GcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=omgf2h+jJbXR8PEd9uNaSAwRt79evhHOA2/1S0Ijmm3ZWaChCIB4bOH+LgTQguce8t
         t0pTW8x2AQjb7WfKYLp2mEMTFOSI0OygBQQjthGXOR0o9eifbi4McZ023/fVa4DPg8QA
         YrH9D1r4TREzJ2KFceWPLzyh5no67gtqAmb0g=
Received: by 10.142.140.7 with SMTP id n7mr3786442wfd.214.1301733854084; Sat,
 02 Apr 2011 01:44:14 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Sat, 2 Apr 2011 01:43:44 -0700 (PDT)
In-Reply-To: <20110331184246.GA19264@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170644>

On Fri, Apr 1, 2011 at 1:42 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Nguyen Thai Ngoc Duy wrote:
>
>> To be honest, I have no idea what the above describes. I read 9bc454=
d
>> (reset: add option "--keep" to "git reset" - 2010-01-19) and figured
>> that --keep is like --merge except that "git diff" before and after
>> the reset is exactly the same, is it? I have never used --keep befor=
e.
>
> I use "git reset --keep" to
>
> =C2=A0- discard a bad commit: git reset --keep HEAD^
> =C2=A0- start working against a different commit:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b topic &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... hack hack hack without committing ... =
&&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: "oops, I thought I was on master but I w=
as somewhere else" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --keep master
>
> ..

Thanks. Your changes make sense to me now.
--=20
Duy
