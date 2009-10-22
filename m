From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 22:24:22 +0100
Message-ID: <26ae428a0910221424n9f45d9bg379fb6609b4eace0@mail.gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
	 <m3hbtrdu1r.fsf@localhost.localdomain>
	 <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 23:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N159L-0007Hg-J8
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 23:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbZJVVYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756810AbZJVVYU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 17:24:20 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:33975 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812AbZJVVYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 17:24:18 -0400
Received: by ewy4 with SMTP id 4so1059674ewy.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=VVvFZ/RtuzZIPJDgDavTCvPZCvPnb4bm23efleWE1BY=;
        b=wQrnOb2fyiTxdi0PCKLuMjFNdDjNg9BQLlNVpDSLa4UYhqO8oXtzLmR1uipP7czrYt
         +0Ks6Xpbn4GPTn1yVyjjUVn02A3Cm9jIUMh/D89wYoJd22/qto1XLF9Oo+kox1SokqoX
         +LZ2QyqnDxbrEdACbVU+H+1eeD28AcdxTmvHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=ai8yP6ToZV0PfRpk21r6DJ+zEXZ/bwJWsLrYHJhvhJGP2M67P4r/4KT3mtGJMoBnXd
         +rYPyXFpaCY+PL18CTb6S7dKqduGfxy6GVM1fmNX3Ea41HMIF02ciZV/FhZ8S4Fb4Yco
         uu6WJ4oQwHLrpCUPyidGea9LOwxUCIchTTUas=
Received: by 10.216.90.203 with SMTP id e53mr3515865wef.86.1256246662338; Thu, 
	22 Oct 2009 14:24:22 -0700 (PDT)
In-Reply-To: <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
X-Google-Sender-Auth: c955efa36da2dfcd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131066>

2009/10/22 Howard Miller <howard@e-learndesign.co.uk>:
>> You can use either "git merge --squash" or "git rebase --interactive"
>> (changing 'pick' to 'squash').
>>
>
> Actually thinking some more.... I don't understand something about
> this. I don't actually want to merge or rebase with anything. I just
> want to say "make those commits a series of commits on a branch into
> just one commit with a new message". I seriously suspect I'm missing
> the point somewhere but what has that got to do with merging or
> rebasing?
>
> Thanks again
>

Oh..... more reading of the help. It's this I take it...

" For example, if you want to reorder the last 5 commits, such that
what was HEAD~4 becomes the new HEAD. To achieve that, you
       would call git-rebase like this:

           $ git rebase -i HEAD~5"

Would it be ungrateful to suggest that the existence of that option
isn't clear from the synopsis at the start of the help? :-)   I guess
I can put the SHA1 identifier of the first commit in my branch too?
Anyway, I'll go and try it and see what happens.
