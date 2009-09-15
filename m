From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 15:46:43 +0200
Message-ID: <46a038f90909150646t25c48d7ar1cfe4052ad0bb3b6@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
	 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
	 <26ae428a0909150627n4e5935bcxdcdf0fdd33a44aa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYMy-0007zj-Bh
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZIONqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 09:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbZIONqr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:46:47 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:53982 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbZIONqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 09:46:46 -0400
Received: by ewy2 with SMTP id 2so475458ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=v1mHAYEDJhFS97tcZnHUVrbq8R2uhUrNaJip6kz1g44=;
        b=i9ilMpXAV+LQVjAQGuzhEmKaMpIC5ODhamLU8nyAn9znHK21+Z1ST6dVDWVNUtX9qe
         0aSrNqto3fEspQJUcO/ZHAm/tOSml9TvO8dLleEHteaM9ac2dy8eM1BuCdiPr9+abhIK
         hKZB4W6iOnWvLdDxP6aBZ6FMBk2T3Mbfb0w7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wqjTT7MPuceWNin+IGqpsGFtEf2yW0pq1WEFfMNL+nlGAFbtFCZPCYJmuD/kDqn8IZ
         gEr6/1hRAayZLyNrcsWHGfKx7RTZlbkl5jGGt+pSkIfVKwfJ9GmJEor6Ax6j51kUTBW8
         pHLBuJzPMo8HeD3oTkzaSMaV5I2iioCa5ittQ=
Received: by 10.211.132.3 with SMTP id j3mr3735346ebn.81.1253022403432; Tue, 
	15 Sep 2009 06:46:43 -0700 (PDT)
In-Reply-To: <26ae428a0909150627n4e5935bcxdcdf0fdd33a44aa8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128561>

On Tue, Sep 15, 2009 at 3:27 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> What's to stop me.........
>
> * The "wrong" branch just tracks a remote so I can just dump it once I
> have this fixed - (delete it and recreate it?)

Absolutely perfect plan. In fact, there's a way to "sync" your local
branch to the remote one:

 git checkout X
 git reset  origin/X

(assuming that the remote branch is 'origin/X')

> * after my 'reset' the files I have in my working copy (still the
> wrong branch) should be the latest version ('git reset' does not
> change the working copy I think?)

correct (git reset --hard OTOH will discard your changes)

> * So can I grab these files (they are mostly new), checkout the
> correct version, and just overwrite the existing files? I'll loose
> some history but not much and I don't care

Oh... well if there were other changes to the same files in the other
branch you could be carrying "other" changes. git diff to make sure
you're committing what you want.

> Seems too easy :-)

It is :-)


m

-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
