From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/5] Re-roll rr/revert-cherry-pick
Date: Wed, 7 Dec 2011 13:56:43 +0530
Message-ID: <CALkWK0k+GF9qjwYd_TzA3o8FqAH6G+cxREZ5r9x8E2G5k-mmmg@mail.gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com> <20111207081734.GG11737@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCqN-0004xS-Ub
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab1LGI1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 03:27:07 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51347 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1LGI1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 03:27:05 -0500
Received: by wgbdr13 with SMTP id dr13so864019wgb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 00:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jgoI1C23JF3cenLIfEvbF9LcmfVUwzjSbvd2ztCsrkI=;
        b=WezoLBJqVhKu9HMrOBkmGcJRy/dB5sf/G3d4AWhwEWgCgpCNofLI1zDV3lAzpGLK7X
         fEFSZLcvMC9pBHrt+Lnw40CJTa1xopBHLRgXTMsq9hhsnXt7q3rsO/tiSh/zAi0/ElqF
         UsB2Fft8zvDMuV7O8MveumyjVZHUbSjMrmGLs=
Received: by 10.227.209.85 with SMTP id gf21mr4878835wbb.5.1323246424504; Wed,
 07 Dec 2011 00:27:04 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 7 Dec 2011 00:26:43 -0800 (PST)
In-Reply-To: <20111207081734.GG11737@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186445>

Hi Jonathan,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> This is a re-roll of rr/revert-cherry-pick, with Junio's suggestions
>> ($gname/186365) implemented.
>
> Thanks for this. =C2=A0I am worried that some of my comments in previ=
ous
> reviews (especially about change descriptions) were not addressed,
> which could mean one of a few things:
>
> =C2=A0- you didn't notice them
> =C2=A0- they were wrong
> =C2=A0- you noticed them and they were describing real problems, but =
it
> =C2=A0 wasn't worth the time to fix them
>
> Fine. =C2=A0But I would like to know which case they fell into, so I =
can
> learn in order to do a better job reviewing the future and know my
> time is well spent.

I suppose they were a combination of all three.  I'm sorry- I'll try
to be more careful and communicative in the future.

Thanks for this round of reviews!

-- Ram
