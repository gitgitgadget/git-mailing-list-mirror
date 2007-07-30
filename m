From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2007
Date: Mon, 30 Jul 2007 15:40:55 +0200
Message-ID: <200707301540.56401.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com> <200707300221.23511.jnareb@gmail.com> <20070730033543.GP20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:18:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFccx-0006Iy-9X
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbXG3VRr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbXG3VRr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:17:47 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:1776 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964893AbXG3VRq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:17:46 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2452605mue
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 14:17:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=spoZPFqc+S37mxAhjHgwVBkeIzh4Mfd8F1SQ3zm3yZbhg3ssWJ2St5VV5EqS4rPEXccvZZB1VJFFYMVgk9EAst2mydoeLrfgHrV98jljmHoyxpDCuZRQUgPGnceESc+g4fLudEB7shX/F1MrFKW5vaHv6MDIu8LHdsrlOPtsqww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CfN8YUOyuJsqdZqcje8lqGSuaIkrJtSwAmBf7pVW07eo/V5TW9h8xMnggxgVxBTX7b9w+1KIVKV4TZBJbiLxpUP70D5VCjKm1z4pHHGkLJ8/MwcZNsZK4kmDW1d75RIMM851nJMtdrsvsrztJ2MgTzHrbY+HH7xU7BVyAO36VOU=
Received: by 10.86.86.12 with SMTP id j12mr4209407fgb.1185830263644;
        Mon, 30 Jul 2007 14:17:43 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id b17sm1358113fka.2007.07.30.14.17.41
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2007 14:17:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070730033543.GP20052@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54267>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Paolo Ciarrocchi wrote:

>>> git-gui ?
>>> 
>>>>     9. Which git GUI do you use
>>>>        (zero or more: multiple choice)
>>>>     -  gitk, git-gui, qgit, gitview, giggle, other
>>           tig, instaweb, (h)gct, qct, KGit
>> 
>> I consider git-gui an UI (like qgit or tig), not a porcelain. To be
>> a porcelains tool need to add some SCM functionality not present in
>> git-core.
> 
> Odd.  I consider git-gui to be a porcelain, just as I consider
> tig and qgit to also be porcelain.  Though I think git-gui is more
> of a porcelain than the others, as it tries to rely *less* on the
> core porcelain and just on the plumbing.  I don't always succeed,
> but I'm heading in that direction.
> 
> To me a porcelain is any tool that layers over the plumbing and makes
> it easier for the end-user to operate it.  Early git only had things
> like read-tree/write-tree/commit-tree.  Tying that all up into a neat
> "Commit" command for the end-user is the job of porcelain.
> 
> Anyway.  Just so long as git-gui is included in the survey.  I'm
> interested in seeing how many people use it, because I know it has
> a pretty decently sized userbase.  Which is probably going to grow
> in the future with the i18n work going on.

Well, if we use the notion that porcelain are tools which provide
high level access to core git, making SCM from git plumbing, then
being porcelain and being git UI are not mutually exclusive.

Nevertheless I'd rather keep them separate, and put git-gui in UI
camp, while egit (which I have forgot about) in the porcelain camp.

Or should I use "version control interface layers" instead of 
"porcelains"?

> Do we have any questions in the survey about the user's native
> language?  About their desire to have git translated into their
> native language?  Folks are now working on translating git-gui,
> and that work will be in git-gui 0.9.x, if not 0.8.1/2.  So it may
> be nice to know what languages our users are interested in.

----
About you

    1. What country are you in?
    2. What is your preferred non-programming language?

[...]

Internationalization

    1. Is translating GIT required for wider adoption?
    -  yes/no/somewhat
    2. What do you need translated?
       (zero or more: multiple choice)
    -  GUI (git-gui, gitk, qgit, ...), git-core messages,
       manpages, other documentation
    3. For what language do you need translation for?
----

Do you want other questions about internationalization and translating
git into one's native language?

-- 
Jakub Narebski
Poland
