From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 10:20:29 +0200
Message-ID: <CAGdFq_hvR1MPF33YFcjDCzCM0iOO2zpiiePFFS4dBabu84cwTg@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se> <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
 <201109261539.33437.mfick@codeaurora.org> <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <davidbarr@google.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 10:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Suk-0001jd-Ot
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 10:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab1I0IVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 04:21:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33576 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1I0IVK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 04:21:10 -0400
Received: by yxl31 with SMTP id 31so5055440yxl.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VpdlwbEvcZaCi4tsH0hGdK+4exEm9Sgu/KTaj4W4u5Q=;
        b=QfhSHJ0S6wx6kJ2ScT6ukCy3sWFFalaTBRFiY/3Oi7pM6eYS0VpJLcCVsAQkhogiLL
         CIJ1erw/MQfspJn6ILcquh9BiiwKv8cq8G/JlH9Xt0XG9wnBBZYqez6EhYv3ENOQIsN1
         VzuvifUp0Ct0p6aSi32yAorI/h6g9/6psNG3g=
Received: by 10.68.33.164 with SMTP id s4mr13294409pbi.119.1317111669162; Tue,
 27 Sep 2011 01:21:09 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Tue, 27 Sep 2011 01:20:29 -0700 (PDT)
In-Reply-To: <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182219>

Heya,

On Tue, Sep 27, 2011 at 01:26, Julian Phillips <julian@quantumfyre.co.u=
k> wrote:
> Back when I made that change, I failed to notice that get_ref_dir was
> recursive for subdirectories ... sorry ...
>
> Hopefully this should speed things up. =C2=A0My test repo went from ~=
17m user
> time, to ~2.5s.
> Packing still make things much faster of course.

Can we perhaps also have some tests to prevent this from happening agai=
n?

--=20
Cheers,

Sverre Rabbelier
