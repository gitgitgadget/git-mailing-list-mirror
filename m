From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Git, Builds, and Filesystem Type
Date: Thu, 9 Feb 2012 20:04:13 -0800
Message-ID: <CAE1pOi3Qk2qESza3QpwxbediYTOQxZ8WvpcfiE7FpkUZ9CwUjA@mail.gmail.com>
References: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com>
	<201202091453.38564.mfick@codeaurora.org>
	<CAE1pOi387-bimYEG4bjFOjaCwhPeDyLRj7wOJgyuKSCrZ9kBFg@mail.gmail.com>
	<201202091634.36563.mfick@codeaurora.org>
	<CAE1pOi1O10XeROv+sQRwAAVQ0PneMZTOaEfny-Oz2Sp+=z+aiA@mail.gmail.com>
	<14de0389-6497-4e74-baa5-129b0c1560a3@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 05:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvhic-0000Eh-HC
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 05:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228Ab2BJEEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 23:04:14 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53147 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab2BJEEN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 23:04:13 -0500
Received: by mail-gy0-f174.google.com with SMTP id r11so1294187ghr.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 20:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Uca+IBUTyVWuHdlFpTf8D/Y96hk6H0nEwPba5Cgg2ic=;
        b=qLvSgsGBTKXcp/sWechV0l5rNZodSb8PQ7M5RKlE+b06vXvFyUekxaUskTdH2oy9Yn
         x4ItbE6GPdZHKJlmyZm2YQIR8c9Jq1fCP99kV77DFNfeP1SjSsWwqGAHYiz2Ex6Jpt8u
         62txpbHARD/osrUydvfETiau69WD9YsntqZgM=
Received: by 10.100.231.4 with SMTP id d4mr2019078anh.37.1328846653609; Thu,
 09 Feb 2012 20:04:13 -0800 (PST)
Received: by 10.236.73.130 with HTTP; Thu, 9 Feb 2012 20:04:13 -0800 (PST)
In-Reply-To: <14de0389-6497-4e74-baa5-129b0c1560a3@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190376>

On 9 February 2012 18:08, Martin Fick <mfick@codeaurora.org> wrote:
>>That would be quite
>>tricky. I have a group of some 60 projects, each with their own
>>"target" directory which would have to be mounted on tmpfs. And the
>>"target" directory is created by Maven, not by me. Not to mention tha=
t
>>I shut down my computer at the end of the day. :-)
>
> Sounds like a laptop? =C2=A0Hibernate?

No, a regular desktop that I shut down every night. It makes quite a
bit of noise and I would rather not waste power.

>>I think I would prefer a somewhat more persistent solution. I
>>certainly have enough space for a very big swap partition. So the
>>whole of ~/my-project would fit on tmpfs. I'm just not sure about
>>making it persistent at the end of the day.
>
> Link your .git dir to a persistent location.

I don't think that would help all that much. I would still lose
anything I had not committed or stashed. And I would still have to
rebuild every day.

Perhaps something together with unionfs? I'll think about it.
