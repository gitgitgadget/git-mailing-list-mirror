From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: RFC: Subprojects
Date: Thu, 12 Jan 2006 11:25:33 +0600
Organization: AcademSoft Ltd.
Message-ID: <200601121125.33696.lan@ac-sw.com>
References: <43C52B1F.8020706@hogyros.de> <200601120919.08354.lan@ac-sw.com> <46a038f90601112046u13d7075dsc2108111e2462152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 06:25:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewuxz-0008MT-Vz
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 06:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWALFZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 00:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWALFZk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 00:25:40 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:32715 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030289AbWALFZj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 00:25:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id 105D5BD2A;
	Thu, 12 Jan 2006 11:25:38 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08479-07; Thu, 12 Jan 2006 11:25:35 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id BA5A4BD24;
	Thu, 12 Jan 2006 11:25:35 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id A08B38E33E0B; Thu, 12 Jan 2006 11:25:35 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 158328E33DFE;
	Thu, 12 Jan 2006 11:25:34 +0600 (NOVT)
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: KMail/1.8
In-Reply-To: <46a038f90601112046u13d7075dsc2108111e2462152@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14545>

On Thursday 12 January 2006 10:46, Martin Langhoff wrote:
> > I really miss this feature. This is the last stopper for moving from CVS
> > to git for out project.
>
> What about using nested checkouts? They work great with git as-is,
> just add an .gitignore file.
>
> As Linus points out, there are many good reasons why a top-level
> commit should _not_ commit the nested subproject. And once you are
> observing that rule, what's left then? git status and git diff <HEAD>
> can show an aggregate of top-level and nested subprojects, but that's
> ease-of-use -- not something only.
>
> What is your show stopper?

I would agree to make separate commits for each sub project.

1. I need to have ability to make tags, branches thru all subprojects.
2. Update (pull) sould update each subproject, it is hard to update them by 
hands.
3. The need of some sort of checkout script (can be solved by storing this 
script in base project, but it would be much nicer allow git fetch all 
subprojects)

Nothing else I can imagine.
