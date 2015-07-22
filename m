From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Feature Request: Passing a number as an option to git tags for
 displaying latest tags
Date: Wed, 22 Jul 2015 11:36:00 -0700
Message-ID: <CA+P7+xpkt+23rdiKt4Cx=+K0m9cgLnd9u+g4f1W+k=-FSNumXg@mail.gmail.com>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SGFsaWwgw5Z6dMO8cms=?= <halilozturk55@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:40:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHywq-0007cN-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 20:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbbGVSkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2015 14:40:52 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36536 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbGVSkv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2015 14:40:51 -0400
Received: by igbij6 with SMTP id ij6so143445798igb.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PVmXKZ+zqThVScfIgm4Udn1zm4dPNE9PIVilQ4ERp9Y=;
        b=HXfEyxer3uCm6rTKyl9nKc7kTX9E4wmg1/O/Pr91h3e3qub6iwYddjP5+4m8+EeE4f
         +L07q3m9JmNdggNeTuTXgBg/MKG7uulOWASZEhr5vr8LrbR/qXoKw0MKfJIVXKiQ+YvR
         +sOEhPFD6dgsP6oawitqK3wVETJowbuyjHr1OjSEHnLRLbDDGeTpDHKhCO7k4KamAM8x
         sB3Kb2lCBGYwCud9L1usrAR1baJigtr1LOcf1mMPpQ+8wqhmpILkuDGECcML8CRDTOmW
         2EuScV63XSPJQGbYv6dxBY8LUVud3VDmZR1+wR4IzmZwgBxLnMw/OzLXbVPJ2Cg5dI+Y
         iI4g==
X-Received: by 10.50.33.82 with SMTP id p18mr34529533igi.8.1437590179886; Wed,
 22 Jul 2015 11:36:19 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 22 Jul 2015 11:36:00 -0700 (PDT)
In-Reply-To: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274451>

On Wed, Jul 22, 2015 at 10:17 AM, Halil =C3=96zt=C3=BCrk <halilozturk55=
@gmail.com> wrote:
> Hello team,
>
> Passing a number as an option to "git tags" command should display la=
test tags.
>
> e.g. "git tags -5" will display last 5 tags only.
>
> Similar behavior to "git log -5"
>
> Thanks,
> Halil
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


While interesting, this would only really work for annotated tags. How
would you define order? tags are normally shown in sorted lexical
order (or version-order if you pass the --sort parameter).
Non-annotated tags do not contain the date time, and using the
commit's date information may not be accurate. While it is possible to
say show "the 5 most recent tags on a particular branch of history"
that would be using the log to determine this.

What exactly would you expect the behavior to be with tags? That might
help figure out what could be done instead.

Regards,
Jake
