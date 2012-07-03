From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Tue, 3 Jul 2012 14:43:01 -0400
Message-ID: <CAKON4OwJAdAMG2_LD6Eh8d=zx+5Hwn_aqRKW-MF5e8k=esCUkA@mail.gmail.com>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
	<7vsjd9wkek.fsf@alter.siamese.dyndns.org>
	<CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
	<20120703180439.GC3294@sigill.intra.peff.net>
	<CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
	<20120703184018.GB5765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:43:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm846-0003Ql-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab2GCSnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:43:04 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61246 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab2GCSnC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:43:02 -0400
Received: by vbbff1 with SMTP id ff1so4438386vbb.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+swX7oOkfx5bmUeapHYvBdH3LszPzxhGVyg7qnEx6w8=;
        b=C5Ra/+HLI5DWT7fferhgjL4LKgf4owFgwIg9N9v7+TedVqStFvDP8W2YTh4YXaCqiV
         gZ9Sak2JAJJ2HAiHHAGu4AZ5ZpKkX1cnXC+dd0ck/tcrHlb/XKwpbwcOQtlQC+d+lfE/
         P5Ob+ZUFL27QTw6wu/lbxM38SqhEwWJ2+Mwiq93JanPEH+sw/403/lxAPi5aW3e1BNuR
         4lF9c/oDa+w409brW00Xg5TrSnVd1THCLiaJZzy8gaS4vISIpHBQ1OgHC/tUiVL12sQf
         /9nd69Mw5KvXNw84CtJ74Q4d+qc+JR5DZM2D39lmsfO+jNhMS4FFPBO02O/q5hlx8U05
         Zkaw==
Received: by 10.52.70.116 with SMTP id l20mr7309452vdu.19.1341340981804; Tue,
 03 Jul 2012 11:43:01 -0700 (PDT)
Received: by 10.52.65.143 with HTTP; Tue, 3 Jul 2012 11:43:01 -0700 (PDT)
In-Reply-To: <20120703184018.GB5765@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200932>

On Tue, Jul 3, 2012 at 2:40 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 03, 2012 at 02:34:59PM -0400, jonsmirl@gmail.com wrote:
>
>> > and now:
>> >
>> >   $ git push origin :bogus
>> >   error: unable to delete 'bogus': remote ref does not exist
>> >   error: failed to push some refs to '$URL'
>>
>> This error return would have made my mistake obvious.
>
> Thanks for confirming.
>
>> Might want to add a paragraph to the doc saying this is how you delete
>> remote branches since it is not an obvious solution. I found it via
>> Google and a question asked on stackoverflow.com
>
> It's already in git-push(1):
>
>   OPTIONS
>      ...
>      <refspec>
>        ...
>        Pushing an empty <src> allows you to delete the <dst> ref from

I was searching for "git delete remote branch". Can out add the word
'branch' in so that Google will find it?

>        the remote repository.
>
> but if you have rewording suggestions, or a suggestion as to where else
> to mention it, please do.
>
> -Peff



-- 
Jon Smirl
jonsmirl@gmail.com
