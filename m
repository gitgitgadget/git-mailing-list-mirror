From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 17:56:50 +0200
Message-ID: <CAGdFq_hRmSif4=V+9h8=S1fWfPCj+meRY8xGyfgv=SWk+DrBQw@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se> <201109260915.29285.mfick@codeaurora.org>
 <CAGdFq_iuY0-PBDOmtz1pRvh6J9EDRiRJHsWkTN_cHjGU20PYTQ@mail.gmail.com> <201109260948.25312.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 17:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8DYo-0007Uy-Aq
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 17:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab1IZP5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 11:57:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65166 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1IZP5b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 11:57:31 -0400
Received: by gyg10 with SMTP id 10so4265271gyg.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=g0B0gKVVtmGbs3W5WUhjVyso9WCbqJK8NupBcb989kg=;
        b=LNBZSdk2MmF/E5x63DodxYCplZpuwcHagR/6NSlb6MQqueRIhfEmV++1jmdpCI7aCj
         +FrkY+l9HVEZW+eyR4r5xxNVNo5rQUQBfT+7aa4KY1TYXWGVWSD0WobvZrqx/0hTni9D
         qyKXgkmICwrEQaaqeEFozb+zzVyk1KZrJ8SmY=
Received: by 10.68.7.132 with SMTP id j4mr30899624pba.102.1317052650056; Mon,
 26 Sep 2011 08:57:30 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Mon, 26 Sep 2011 08:56:50 -0700 (PDT)
In-Reply-To: <201109260948.25312.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182126>

Heya,

On Mon, Sep 26, 2011 at 17:48, Martin Fick <mfick@codeaurora.org> wrote=
:
> Hmm, I was thinking that too, and I just did a test.
>
> Instead of storing the changes under refs/changes, I fetched
> them under refs/heads/changes and then ran git 1.7.6 and it
> took about 3 mins. =C2=A0Then, I ran the 1.7.7.rc0.73 with
> c774aab98ce6c5ef7aaacbef38da0a501eb671d4 reverted and it
> only took 13s! =C2=A0So, if this indeed tests what you were
> suggesting, I think it shows that even in the intended case
> this change slowed things down?

And if you run 1.7.7 without that commit reverted?

--=20
Cheers,

Sverre Rabbelier
