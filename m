From: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
Subject: Re: Make "terminator behavior" the default with --pretty=format: ?
Date: Tue, 22 Feb 2011 17:51:11 +0100
Message-ID: <AANLkTikGYOdJNGNXR1egPyMBhKpT=bby5fmr8MR9QTXt@mail.gmail.com>
References: <AANLkTimFYsG3x0uGX32Ozo6C_shHd4k8jnXNhYmy7Q80@mail.gmail.com>
	<1298393039.2286.14.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Feb 22 17:51:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrvSH-0000Pi-0M
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 17:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab1BVQvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 11:51:13 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60294 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab1BVQvM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 11:51:12 -0500
Received: by yib18 with SMTP id 18so3087242yib.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:cc:content-type:content-transfer-encoding;
        bh=IiK8Ig1p1U+RCkp5X2K1h2gZntvHGB6xr5vmLYAH6IQ=;
        b=aHbf21gA3El8cEMsP+N3YO8wCBSky4z69di5QSlVYT6qJJVw5WNRaOHfflKj+gQ5ya
         RtUT8JXtT7ctQkUeZC9+Jyp9S9rck4FlhSZKqHFR3Jn3aW1jVEc5rz9qqStw2muRFf9N
         9ss9RWyF3DJ54ECY477b+37xJqftrRruIH1DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type:content-transfer-encoding;
        b=kSonWy9cmRYvM/js9WVWOLwBsPJXwtc4aj9QFb3IA11Bi6SlZTwuy6iAlhIcvMwKyC
         t7XnGaExb2AvE8fetXgGYXyr//gbTHMFY4nmigK0tBB+/gEYxj7egf02i38HeyYHydNB
         gV1Lc9Ig60rOp5WOsk/QKYqq9+t4TFmImsgZM=
Received: by 10.90.88.17 with SMTP id l17mr3787385agb.191.1298393471380; Tue,
 22 Feb 2011 08:51:11 -0800 (PST)
Received: by 10.90.25.6 with HTTP; Tue, 22 Feb 2011 08:51:11 -0800 (PST)
In-Reply-To: <1298393039.2286.14.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167564>

On Tue, Feb 22, 2011 at 5:43 PM, Will Palmer <wmpalmer@gmail.com> wrote=
:
> On Tue, 2011-02-22 at 16:43 +0100, Hrvoje Nik=C5=A1i=C4=87 wrote:
>> Is there a reason, other than backward compatibility, for
>> "--prety=3Dformat:" to have separator rather than terminator semanti=
cs?
>
> The "default behaviour" is the behaviour which occurs when one /doesn=
't/
> specify something. For example: --pretty=3D"%H %an" uses terminator
> semantics.

I didn't know that you could simply omit the "format:". Is it
documented anywhere? The docs say:

       --pretty[=3D<format>], --format[=3D<format>]
           Pretty-print the contents of the commit logs in a given
format, where <format> can be one of oneline, short,
           medium, full, fuller, email, raw and format:<string>. When
omitted, the format defaults to medium.
