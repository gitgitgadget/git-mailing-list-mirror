From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/GSOC] Git Beginner | Warnings for potentially destructive commands
Date: Sun, 27 Mar 2016 00:36:03 -0700
Message-ID: <CA+P7+xoy0OqnEiHZAtWbMsqL6SUO7n1DRHTj_DMJEN3y5JKZoQ@mail.gmail.com>
References: <56F51089.2050703@gmail.com> <xmqqd1qi4fvi.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqkqfccQtWeKbURZt21i+gw=b7f0YHHuqeNzM7TH2m+6g@mail.gmail.com> <vpqfuvdi87u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sidhant Sharma <tigerkid001@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Mar 27 09:36:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak5FN-0001up-Mb
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 09:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbcC0HgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 03:36:25 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34089 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbcC0HgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 03:36:24 -0400
Received: by mail-io0-f177.google.com with SMTP id e3so36066227ioa.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TzZ1ul6nyI1GpGq3C3Va4EYjenH/zGW+eT1M7IES44g=;
        b=ufDEYFF7Z6nhOiopizJWUM7UtoOfFG+EqaAmrVI6x2O/HXXN/n9Y0eY+InwqjYjy3E
         3pVPLRJjIg/MuzgTqdP4KPwFgfz+ja9PgeoH3rliemM5a5bCjZih6bmrLSaLsqP/fGv9
         +3TJ4NXdNSH6V5Talje7hKe5U3oTPfIfsaXew19hTfqSvlaGIMRkfEBE9QdqmC5kSi5K
         7vuuwD9FVNxTd5oRZx4cvmalOgH6WNYnHf6EBR2aFKB+6xBSAWwJCHmBhc6TWYpnt+lN
         GuvVvzXrJS0ArnIG9SmuYcyqJ+AlRrY64UBmVzCoCvph3B+7/1egPbMTdK8S5OnnCWEG
         p7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TzZ1ul6nyI1GpGq3C3Va4EYjenH/zGW+eT1M7IES44g=;
        b=N7Hh2CftpDDAb5/RlnIfUTpDgK3oROR59AytK2knbWQDmeNfBHwqfxOkbTyvFhAdRE
         eLUKAOG7IqWMpH1OzulvgnuBn8buVQh7aC6cQ8sBQ0xSDRChFaMfAeR3aqzVQgH2TWSq
         /b4jSyUjebyf6w95v0SDgShCHPrgDXnrmwKxceokOoAO9/b+48GljZ4tKL3+khjrucik
         mpknusCJtGwVfb6P7KLpw6f8wJ5ciUG74yY5o8fEtjz0RHj1jY/j2iIa8dUCZGOKpFK3
         01d6/ZjxvSXKc+DqaAUp0P8oLfXhroiGCstBfG1qK385WoFuOxVtKD6QdaK32I2pNHnt
         a/Qw==
X-Gm-Message-State: AD7BkJJcfSzLwgWa6qXE7xr2kuR8TPk5jldNs3Y6bUy4/qALfw2WTN2TvKg398wllIVxIYppMDtOFWSji3cXkg==
X-Received: by 10.107.136.83 with SMTP id k80mr8223716iod.0.1459064183260;
 Sun, 27 Mar 2016 00:36:23 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Sun, 27 Mar 2016 00:36:03 -0700 (PDT)
In-Reply-To: <vpqfuvdi87u.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289999>

On Sat, Mar 26, 2016 at 8:12 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> If possible, I would suggest aiming for generating the actual topology
>> that the user is seeing, customized so that it gives relevenat
>> information, rather than static examples.
>
> Using the real topology in a useful way is actually pretty hard. It's
> quite easy to throw the output of "git log --graph --oneline ..." to the
> user, but as soon as the rebase deals with more than a handfull of
> commits, we'd want to simplify the history to show something
> understandable to the user (which by definition should be a beginner if
> he uses ggit), like replacing long sequences of commits with "..." or
> so. That is hard to get right.
>

Yes, in which case we should go Junio's route of not using anything
from the real topology.

Thanks,
Jake
