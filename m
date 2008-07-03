From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 12:15:37 +0930
Message-ID: <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
	 <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7f-0002yW-4A
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbYGCG70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbYGCG5k
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:40 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:54540 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbYGCCpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 22:45:40 -0400
Received: by fk-out-0910.google.com with SMTP id 18so505087fkq.5
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 19:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CmochXDL0+/FlHRrzY2VPY+p+Ju5ml0Ej5LLqH3p7P4=;
        b=NGEyzzVjYDudw62ATZHd9eJfNxgI91x0UIgRzOB1PnyhPEmN2r7Z0ZxLv8ds9egD8c
         dAWLiLIX4PGBak9zpr5z2QG9CC2g1kOZAvknuHPoRQ7jv2H8tdllTY9KWR2GFxOHoeWE
         GGp+szzBaKhmzV/Ilv1ZleiEHO2dCePkgSAtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=eBlnA98w82AbtsrlXXvrK+Q/ux8SJLwXI+znErw8r471zYkjQX9f3irXO+oAB9NXE0
         y62NEBv8HGo+QLX4p78Mwd/W9V0LZSxBoerP8Ynk7G1Mhh7Zo7ZOzhE6S6k3sFA0r9hg
         jI+lb4h2MtEQcOHcOOuUgqn/WIjegLy19pBR4=
Received: by 10.82.124.10 with SMTP id w10mr328197buc.18.1215053137775;
        Wed, 02 Jul 2008 19:45:37 -0700 (PDT)
Received: by 10.82.114.1 with HTTP; Wed, 2 Jul 2008 19:45:37 -0700 (PDT)
In-Reply-To: <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87246>

On Thu, Jul 3, 2008 at 10:42 AM, Mikael Magnusson <mikachu@gmail.com> wrote:
> 2008/7/3 Geoff Russell <geoffrey.russell@gmail.com>:
>> git diff --diff-filter=D --name-only HEAD@{'7 days ago'}
>>
>> finds files deleted during the last 7 days, but if my repository is
>> only 6 days old I get a
>> fatal error.
>>
>> fatal: bad object HEAD@{7 days ago}
>>
>> Is there something that says "since repository creation", ie., go back as far
>> as possible, but no further? Is there a symbolic name for the initial commit?
>
> There's no symbolic name for it, since there might not be only one initial
> commit. git.git for example has at least three root commits. You will
> probably get what you want with $(git rev-list HEAD|tail -1). If your
> history is very large, $(git rev-list --reverse HEAD|head -1) is slightly
> faster, but usually not enough to offset typing --reverse :).

Thanks for this, but I'm a little confused.

If I do a "git init", there must be a first commit after this? Isn't
this the first commit, how
can there be more than one first commit?

Cheers,
Geoff

>
> --
> Mikael Magnusson
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
