From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] Makefile: Improve wording in a comment
Date: Thu, 5 Feb 2015 12:04:08 -0800
Message-ID: <CAGZ79kZdm6a7KDpNyWdLoG5Rc2f-1fCRk1pkg8U2RD3azotkBg@mail.gmail.com>
References: <CAHGBnuPnwE8K81C_9W65Jk1FMU==gMODOKvGYBbgNRNbvx_bag@mail.gmail.com>
	<xmqqr3u4kw13.fsf@gitster.dls.corp.google.com>
	<CAHGBnuPhXWXp+OfGsX4i5xOJK81qqua8cp2fDPb76HgaU5C0ww@mail.gmail.com>
	<CAHGBnuO3wgE_pLu1jcEyExhrzd+Fk_0Uqs23pFgf1NSZpUxVfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>, amyrick@apple.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:04:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJSes-0006hQ-MN
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbbBEUEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 15:04:10 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:64891 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbbBEUEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:04:09 -0500
Received: by mail-ig0-f176.google.com with SMTP id hl2so466642igb.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mPmuCwB2Dk/Fsr3QqWHU2A07PP+9UcMHV6Mg/gjn6m4=;
        b=RWiQYBmhvtPd1lpkUvjnfScQrCjcnvuEB5J1sIMmCXEh0PaeKA4WTo8uUih/hSp6Yo
         2s4c3BhsHdxbCFN+KwvgWhxf7tqz0Nx0ULXHz+f4+CI7xSlLtXnDpsfYNC223Rucu9qS
         iFr1oTXuLoA0FWBRDnTCbXsjryWplAW44e/fhTSDijwY/yEZVJr8Y0TkktJivvMkDu8U
         4W6wqy4EW66rT2Stz8lpCV2MefLO2Cr9xZg5kqiTZ5+8mFQm1/0Zhk1Nc3tF2ypNXqIM
         Fy3rY3l1XZNewak1fwPFhiF2MNV3st9Px4jGU+qH7lsge2gDYlvezebtNEzKAwo42Ouz
         NdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mPmuCwB2Dk/Fsr3QqWHU2A07PP+9UcMHV6Mg/gjn6m4=;
        b=BifcS1kC2I4o19GhTLO+HOIenAXmb+GEmTZIbYDadlF7UkmB7jPeHlTHySSGaZ4+gf
         SbxmT9cbuowpS5QVFfzsO5hnyOgLh084crLh+6V6FRGxl51M5Bsm/tnOa9j6Z9OkO+b6
         nudwn7xp2QhoYjM44KZ7YazBYxF0lwyzGr40Od8rZyfKP/kchsv+UvrwabRpz+QmBtFS
         5vJQcdzIH2T57yYJnJjH4RlIEGb2JCzNxlCGwoSuQUSy2c10TpIsaEOE5/MfWwz3eCW7
         aOPKMKdZ5InbPlLP72dvYY359e857OCBd5m+VjPP1NVgZiCcCCX5kY75ulBnsH9TwNlP
         PLGQ==
X-Gm-Message-State: ALoCoQkGhDn9skZgmUzlp/l57htutIpxE88wupSCVLBXxzm9vsrc+nbpsd6I1UNWP/ZJmIv9dUHZ
X-Received: by 10.42.207.129 with SMTP id fy1mr9055017icb.17.1423166648200;
 Thu, 05 Feb 2015 12:04:08 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 5 Feb 2015 12:04:08 -0800 (PST)
In-Reply-To: <CAHGBnuO3wgE_pLu1jcEyExhrzd+Fk_0Uqs23pFgf1NSZpUxVfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263397>

On Thu, Feb 5, 2015 at 11:22 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Thu, Feb 5, 2015 at 8:19 PM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>
>>> Is that an improvement?  Is the plural of "dup" (used as an
>>> abbreviation of "duplicate") "dupes" not "dups"?
>>
>> My view is that the abbreviation of "duplicate" is not "dup" but
>> "dupe", hence the plural "dupes".
>
> For "duplicate" the noun, that is. For "duplicate" the verb I'd be ok
> with "dup" as the abbreviation. "to dup" sounds and looks better than
> "to dupe" :-)
>

We could also not abbreviate that word to avoid discussion there.
