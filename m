From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 16:02:19 +0100
Message-ID: <1301410939.3012.12.camel@wpalmer.simply-domain>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
	 <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com>
	 <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com>
	 <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com>
	 <5A9D499C-26AC-401E-B21A-1F8E03FBAC4B@gmail.com>
	 <AANLkTinjbXzdfkxVRPPSXJj6Z0mMrikzdi2V8N5YAGR-@mail.gmail.com>
	 <04C85603-1737-42BC-A037-2C45D5315435@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 17:02:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4aRG-0003wn-19
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 17:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab1C2PC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 11:02:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36261 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab1C2PC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 11:02:28 -0400
Received: by vxi39 with SMTP id 39so198868vxi.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=ddueT903ygjvkSyvr6dfQNbbs2u06OOyKcMkDsp+zn4=;
        b=AF0tRfZ+atLuk58C8uTAZu20Lhp1hsvzKwSxCpoNMhUNID+uJG106FYTBZVvPx3Ueq
         +kO0EHouEAabYDbPjHgSnnEGjKYE5RzF6rV+tLv8hKYwABkR6DlLJqj7oVYA6AHEJbo6
         8OatxIMgeVaa0yy7pxA0UL/Pta8mp3J9UL3ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=xwMusSd9G22ilU1e+a0gRA6EEYr5CqtHq1KF4h3kPmvYCICF4bpPBJ4hdnEA8TATgS
         VO4dBy/J3GPcVR9xwldtDQRwLLMLaQulJkQRVoAFrMeEm3gs/aQuigeHANrSsi1fhFYj
         ncdyImzdB4PqrHrNgmGssMu1WLwNpY3kC5w40=
Received: by 10.52.91.232 with SMTP id ch8mr7718465vdb.85.1301410947077;
        Tue, 29 Mar 2011 08:02:27 -0700 (PDT)
Received: from [192.168.2.64] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id n5sm978005vcs.34.2011.03.29.08.02.21
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 08:02:22 -0700 (PDT)
In-Reply-To: <04C85603-1737-42BC-A037-2C45D5315435@gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170274>

On Tue, 2011-03-29 at 06:12 -0700, Joshua Juran wrote:
> On Mar 29, 2011, at 5:49 AM, Nguyen Thai Ngoc Duy wrote:
> 
> > On Tue, Mar 29, 2011 at 7:44 PM, Joshua Juran <jjuran@gmail.com>  
> > wrote:
> >> On Mar 29, 2011, at 3:58 AM, Alex Riesen wrote:
> >>
> >>> On Tue, Mar 29, 2011 at 12:10, Lynn Lin <lynn.xin.lin@gmail.com>  
> >>> wrote:
> >>>
> >>>> only have two commits
> >>>
> >>> Than yes, "git reset HEAD^; git commit --amend" seems the best  
> >>> solution.
> >>
> >> Actually, that should be:  `git reset --soft HEAD^; git commit -- 
> >> amend`.
> >
> > "git rebase --root" does not seem a bad idea though. I need to amend
> > initial commit a few times and end up using "git reset" without
> > --soft.
> 
> Or perhaps have `git commit --amend` issue a warning if doesn't  
> actually amend anything. ............................................

I like this idea. It's been in my notes for a while, but seems like it
has a lot of potential to make existing scripts noisy for no reason.
I do agree with the change, however.

The only constructive thing I'd add, as it's sitting in my notes right
next to "Warn if "git commit --amend" introduces no changes":
 - Add "git commit --reword", like --amend, but without the above
   warning

This would fit in with the existing names from "git rebase -i".
--fixup (for "like --amend but do not ask for a message") seems like a
sensible addition to those to, also following the lead of rebase -i, but
--fixup=<commit> already means something different (though related), so
it is probably a bad idea to overload --fixup with no =<commit>.

> ........................ Sometimes you just want to change the commit  
> message, so you wouldn't want a warning in that case.  But other times  
> you're adding changes and updating the commit message at the same  
> time, so you'd want a warning if you forgot to git-add or use --soft.   
> A new --fix option to commit could work like --amend, but fail with an  
> error if no changes are staged.  Another option is for --amend to list  
> the staged changes in the edit buffer, or a warning when nothing has  
> changed.
> 
> Josh
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
