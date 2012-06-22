From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 15:33:05 -0700
Message-ID: <CAE1pOi0zkDa=scowaaT=VdLjdYL2UPW++e0ZXLrzU6kncX8-ow@mail.gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <CABURp0oCrmJzfFtX9UujMfoTPeCBPeuri6pb4nTq57XvuO98aQ@mail.gmail.com>
 <CAE1pOi3pe4KKeJ4B74T8besvbiJh-dJz5efB-qJLsbmK+f_YLQ@mail.gmail.com> <CABURp0rhVi+pi4YjCfQqMpcjV2rYKQHPQ3QUZ49h0gjERAS4Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:33:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCPz-0005Ds-NA
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab2FVWd1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 18:33:27 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:57082 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab2FVWd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 18:33:27 -0400
Received: by gglu4 with SMTP id u4so1966649ggl.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZDGv7qwaTjAiWLq6HxSDmC1FBs+Niuf1dH+mvFkOQgE=;
        b=XNdgzyPwirBQ4hu9lDvOt5F7iZCs1aqWVA9SY9Da+DQRXZuBDn84yABON/UognRSWs
         gCQ1skw2HKGMMeU6pXK05HtHnejVWLodrH1j4wQiRdsMX17/cV1hhWN5mWEHhwH+Izpg
         Ql2vOa2XBUVys6MR79HtcgHBx6bisCpcmHNtKSiNTFIQ/6nzoEXXbqOhGaxlElVpoMuo
         gZs0TJWObr7k9j2gokTiaytAH5h/9goq2s75YAtReeaBTwy6OZKmKoJhFzjdHZI5f6z3
         A3eHSb2JFaJTUVXPlYcISZurMayWvdDJfbjCf0qxumfpAjF/nfZ4ib4BagV8oG/MruFd
         KQPQ==
Received: by 10.236.185.198 with SMTP id u46mr4358547yhm.33.1340404406415;
 Fri, 22 Jun 2012 15:33:26 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Fri, 22 Jun 2012 15:33:05 -0700 (PDT)
In-Reply-To: <CABURp0rhVi+pi4YjCfQqMpcjV2rYKQHPQ3QUZ49h0gjERAS4Qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200482>

On 22 June 2012 15:10, Phil Hord <phil.hord@gmail.com> wrote:
> On Fri, Jun 22, 2012 at 4:14 PM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>>> You can also compare the commits to see what the differences are.
>>> This may trigger =C2=A0the developer's memory about how it might ha=
ve
>>> happened.
>>
>> The only differences seem to be the SHA-1s.
>
> Can you tell me which SHA-1s they are? =C2=A0It will be easier for me=
 to
> guess at the reflog contents, then.

You mean which SHA-1s in the reflog? It's the ones listed as @{"18
hours ago"}: rebase: ... Sorry, I should have pointed that out.

The reflog lists the SHA-1s that the dev had and that were pushed to
origin/master (so B', C', and D' in my original description). The ones
that were on origin/master originally (and are/were on my local
master) are different (B, C, and D).
