From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-gui: Automatically spell check commit messages as the user types
Date: Mon, 04 Feb 2008 02:14:08 -0800 (PST)
Message-ID: <m3d4rd58ri.fsf@localhost.localdomain>
References: <20080204084153.GA9997@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Flott <adam@npjh.com>, git@vger.kernel.org,
	Christian Stimming <stimming@tuhh.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 11:14:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLyLe-0005DS-CP
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbYBDKOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbYBDKOM
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:14:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:18482 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYBDKOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 05:14:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2865022wah.23
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=KE302LiFWKuHOPPwUJGKjTiXixiz4mIBS06ChqWG56k=;
        b=ZdSzD7hxCA09Ffa+hiMc7PxXItbTvZI1YP6a4gABzJmXeBTO9GVAdm3I3KAk/hr+h053dq3OnfxXyYeOwpq6MHjbmRhM4wCAUP+MW4PXgU9oUO1Qx16LtWy1zGAuRnHqr/kwT0XVKk2DPy5QvfixhsF6sScpadnZcnYyJBxFYEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=M9z8xiLUbIk448UihSgjO5OJUVORzs/hZeQ/K2FuSui/yEf8Lg+O/DI+0e0hjPyc3tMsrPVs/nLaXNQ3UkCZ48euNFK3hE+fYsXn90wwv3D3KrKuIGuqaP3BO92dq4NOOAQY/oC951/TBNOpi9eyk+H+UchrJL87JY10qHC5Kgw=
Received: by 10.114.254.1 with SMTP id b1mr127487wai.140.1202120050695;
        Mon, 04 Feb 2008 02:14:10 -0800 (PST)
Received: from localhost.localdomain ( [83.8.221.201])
        by mx.google.com with ESMTPS id k10sm19337925nfh.17.2008.02.04.02.14.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 02:14:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m14ADw68022750;
	Mon, 4 Feb 2008 11:13:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m14ADsU2022747;
	Mon, 4 Feb 2008 11:13:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080204084153.GA9997@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72484>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> [This is also in my `pu` branch on repo.or.cz/git-gui.]
> 
> As you can see the commit message was rather long.  I used this
> feature the entire time while writing it, and I have to say, it
> saved me from my horrible spelling and typing skills.  It also
> didn't feel like there was any significant lag, although every
> once in a while it will mark a word that you are in the middle
> of typing as misspelled, and catch up and correct that once you
> finish the word.  I guess that's what you get for slowing down
> and taking a few extra milliseconds to move the fingers.  :)

> Personally I prefer this style of spellchecking over the "lets show
> a modal dialog and ask the user to check one word at a time through
> the document".  Mainly because this style gives you full context,
> while the modal dialog forms almost never do.

IMHO both modes have their use. The "flyspell" mode can show you
errors as you type, so you wouldn't repeat mistakes (running spelling
only on finished words is a good idea), the "modal dialog" has its use
for final chackup, as it is much easier in this mode to use "ignore"
or "ignore all" for the word which is not in dictionary and you know
it is correct, select one of proposed corrections or write your and
use "replace" or "replace all", and add word to local dictionary, and
change language (if done right of course, i.e. with highlighting and
going to the word currently being corrected, and not hiding/covering
the text being corrected so you can see the context).

BTW. you can check how Emacs does that in its flyspell-mode, and how
it does checking lazily; I guess the code should be readable even
knowing next to nothing about Emacs Lisp
 
> I'm not sure how to configure Aspell for other languages, it just
> magically came up with English on my system.  Since git-gui has i18n
> support almost everywhere else I want to get that settled before
> this topic merges into my master branch.  I've CC'd Christian and
> Johannes as they have been a big help in the past with the git-gui
> i18n effort and I would value any input they might have.

aspell {-d|--master}=<dictionary>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
