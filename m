From: ZhenTian <loooseleaves@gmail.com>
Subject: Re: I lost my commit signature
Date: Tue, 14 Jun 2016 17:56:36 +0800
Message-ID: <CAGrdoOoadz_1OV4eB1+yjCiDpKRe1T1CtCTu7cq1g+9CEc2DxQ@mail.gmail.com>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net> <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net> <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:56:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCl5X-0007VX-En
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 11:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbcFNJ4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2016 05:56:44 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34040 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbcFNJ4h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 05:56:37 -0400
Received: by mail-yw0-f175.google.com with SMTP id c72so149700030ywb.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EBI0EZUpva2zdmtE3SmOx6VTwpF9ZeeJAFtYEeXVn/4=;
        b=JFTK8BzRo98ZuATMDbljTWHAu1eeaH/m0DTrFOHNqu0GDLWHbBrcon6pcu4V3TRjzz
         r3AvMSfUTbSmpuzgTMFsrb4WhKVIvYG9OteVpn+C/0D2EiUcqnckRxE6TLp1D/1aZkBO
         ut28Y9a4elEZ7Gox6LcTEmmGvJv8yRb3kVOW5x3n/IfeXoK/jd2LFzU+ybPhW55XQkC4
         8YzSqQ8PnDuwY9Xv7z1bSimmLiwlVgQGShq7P1lxA3NDoxiZqLBv4HsQAezNRxoTJd+E
         syfroaPIH/dp6QWGkGHM8Cz61vJv/7trni3rP5ohN47TjgQ7Se1qH+7ZUuvV83ySMXXz
         I1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EBI0EZUpva2zdmtE3SmOx6VTwpF9ZeeJAFtYEeXVn/4=;
        b=iME6cBL7u+84oXn9yv6KeCV7im8E3dQOx4UWrE8v6E1m1MWVZhRGDt31D+n9RZoVaA
         WFhIS98WkQHfOBVqVm4rQ7izMACl3gtoCpcKP5Cx3IH/sCRrcFalrsGcivNf+lWczwN6
         Vk56LsDbau4agiTBGGkHUlCvkfnIdSnVMDqMoa3DM8cWM7VKrizVvJsBSBWumL8BFg2Z
         HojM48s0yeH3KRVcFag0BOp3CTkaBFgb5hFop2CnRGdjihhlZYDXGYZBX9lzGr0yTMaR
         3uOzWnDEVTqHZrT1eyqVnvU4raEja0NYqjAwyVOBXYiH79kcFGxXFvUhsKMuf0ir7AOo
         Vw2w==
X-Gm-Message-State: ALyK8tJtfwzkAitpsO7Wt0KNVLzeD3KHbbB3NaNZ/c888YkdqNsBoyVmoZyL6pkbzZ9SQsT4/E8khTIVZkiD/Q==
X-Received: by 10.37.202.201 with SMTP id a192mr8013989ybg.122.1465898196898;
 Tue, 14 Jun 2016 02:56:36 -0700 (PDT)
Received: by 10.129.85.203 with HTTP; Tue, 14 Jun 2016 02:56:36 -0700 (PDT)
In-Reply-To: <20160614094121.GA13971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297279>

Thanks Peff, I have setup to gpg.program, if any progress I will reply.

Over.
Sincerely,
=E7=94=B0=E9=9C=87


On Tue, Jun 14, 2016 at 5:41 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 14, 2016 at 04:39:38PM +0800, ZhenTian wrote:
>
>> I want to set gpg -v to pgp.program, but if I set it, it can't call =
gpg:
>> ```
>> error: cannot run gpg -v: No such file or directory
>> error: could not run gpg.
>> fatal: failed to write commit object
>> ```
>>
>> I have tried set gpg.program value to `gpg|/tmp/log`, `/usr/bin/gpg
>> -v`, `gpg -v`, `"/usr/bin/gpg -v"`
>>
>> only after I set to `gpg` or `/usr/bin/gpg` without any argument, it=
 will work.
>
> Ah, right. Most of the time we run such programs as shell commands, b=
ut
> it looks like we do not. So you'd have to do something like:
>
>         cat >/tmp/fake-gpg <<-\EOF
>         #!/bin/sh
>         gpg -v "$@"
>         EOF
>         chmod +x /tmp/fake-gpg
>         git config gpg.program /tmp/fake-gpg
>
> -Peff
