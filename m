From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Sun, 21 Mar 2010 14:55:03 -0300
Message-ID: <55bacdd31003211055r348f37b0sb4ff02c38c64722b@mail.gmail.com>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com> 
	<20100321171431.GE2557@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 21 18:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtPN6-0005En-Ja
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab0CURz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:55:26 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:49771 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0CURzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 13:55:25 -0400
Received: by ywh2 with SMTP id 2so1444120ywh.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=bz7bupW0OmdW9ZPvaqpM+Ytkdgn0oLUn0LOFLyJbWcI=;
        b=CJ8m3HJYFwRtsM/u2k9sGGRFRmDd3QPZ2XFy6PZ/4nwMFQn5k98IPKUkEoVoarDWuI
         /xdVZ8BQX6aKg0Y7LCoiYnioSDhkAL0MAopn8KMq4SgpLb+2SVeHdDv9RNxnSBdrbd+y
         5oSA+KGtJF4uE0pzeDq2lM6icXVIQ01KMkxOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=J9gOU/NCmTKpCzFACEdzmn7I+n39lK+sWH3QLfSOZW0KfBuEtkPb+C5zpudHxfTGYN
         VRkhTNKG3xrTm2I2Tp0mfvcL1FjBniH6DcYiD2uFR2IQJrWO1A1E2focMPqxJpR0jeDy
         V8gHFu9ulOHDkayTiQeK1YJpVf6H2KH1+mme0=
Received: by 10.150.93.20 with SMTP id q20mr2454765ybb.343.1269194123067; Sun, 
	21 Mar 2010 10:55:23 -0700 (PDT)
In-Reply-To: <20100321171431.GE2557@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142846>

Hi,

2010/3/21 Peter Baumann <waste.manager@gmx.de>:
> Sorry to skim in so late but --orphan sounds - at least to me as a non native
> speaker - a little strange. Yes, I know it means "without parents", but
> actually it would be the *last* thing I would search for after opening the
> manpage.

It is never late to contribute, even for skimming.  Free software are
organic and living things people can mold it whenever they want.

We are both non native English speakers but for me orphan is the real
obvious for no parents.  And that is the name of the command you type:
shorter and not similar to other ones is the best.

I don't care about names as long as its bearer does what it is
supposed to do.  But in this particular case I think it fits the job.

> Wouldn't --empty-parent or --no-parent describe the situation better?
> It actually has the benefit that it would match on a search for /parent/,
> which I would have searched for if I want to create a new empty branch.

--empty-parent try to give the "plumbing" idea but it is not really
'empty' but 'non-existant' and also it is not good to make
"porcelainners" (inventing this term) see it as an unparented though.

--no-parent is just added characters and make it feel as if it exists
a --parent too.

You WILL match on a search for /parent/ already.

> --
> Peter
>

Thanks for you contributing ideas.

Although I don't agree with you on this subject, I am very happy you
participated your ideas to me.  It is good to get some attention :-)

In this particular case I see Junio as a native English speaker better
fitted to comment.

Best regards
