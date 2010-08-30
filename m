From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH v2] builtin/merge_recursive.c: Add an usage string and
 make use of it.
Date: Mon, 30 Aug 2010 00:32:58 -0300
Message-ID: <AANLkTimEtAg0kmXRtc57XsF5Hpp8wqbn8tS0bz8q8K4+@mail.gmail.com>
References: <20100829214648.GE1890@burratino>
	<9e0261a0eebe275e2ed1fa651e5ab80c35f6048c.1283120150.git.tfransosi@gmail.com>
	<20100830024259.GC4010@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 05:33:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opv7I-0003XF-5c
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 05:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab0H3Dc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 23:32:59 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51833 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab0H3Dc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 23:32:59 -0400
Received: by qyk9 with SMTP id 9so2521287qyk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 20:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5nx9n+J+JhX8dZ3fCDxpASFctYT9N1vejDx/Dhk3Aj0=;
        b=JdadNTvtpuGGcTrnQqcTNmLlNc83oG/vnOMm1OHhJCXU40PKUEM+QcWBGf9e4DvgJD
         BmF4Tim4kNY3PmzYlYPhnRuuVCTD/msBn6UoJ7wD7cggl1wB2zShGBS8Lc0LAtJ1zq8y
         ZtfOAz3RWRSsIkMB+C0B9/3gkvIF8tVrwnJkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KKqPTBxNN75HQve9GtA5BcqFOnBIFafyfaQp7he1xBNr3kpWiO+WdRaH3V3afCctxb
         ofH0tXzj79OVgSE37nJemTAQI4iOfTjz+qKjxOiQiGaFd3SJwNSrMmp2g1qjzlrB6fSt
         Gz7AU//BywC1xCtdI8reHDsv8eOcQ2Bxmds34=
Received: by 10.224.54.68 with SMTP id p4mr2528505qag.114.1283139178187; Sun,
 29 Aug 2010 20:32:58 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Sun, 29 Aug 2010 20:32:58 -0700 (PDT)
In-Reply-To: <20100830024259.GC4010@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154763>

On Sun, Aug 29, 2010 at 11:42 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Now that you've researched it, wouldn't it make sense to include an
> explanation for this %s in the log message?
>
Sure, added an the explanation of %s in the usage string and the exampl=
e too.

> Still, ack on this part.
>
Thanks.

>> @@ -37,19 +40,19 @@ int cmd_merge_recursive(int argc, const char **a=
rgv, const char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(arg,=
 "--")) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!arg[2])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!strcmp(arg+2, "ours"))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!strcmp(arg + 2, "ours"))
>
> My comment on the rest still applies: it is best if patches do not
> contain unrelated changes to unrelated parts of the files they touch.
>
Reverted these style fixes in patchset v3.
