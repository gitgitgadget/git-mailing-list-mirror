From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Wed, 4 Jun 2008 12:45:36 +0600
Message-ID: <7bfdc29a0806032345o98eb21dhb8714c8e04218a53@mail.gmail.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
	 <200806031856.11060.robin.rosenberg.lists@dewire.com>
	 <20080603225418.GP12896@spearce.org>
	 <200806040130.41654.robin.rosenberg.lists@dewire.com>
	 <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
	 <20080604042703.GQ12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 08:46:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3mlT-0007yS-Ia
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 08:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYFDGpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 02:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYFDGpj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 02:45:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:63916 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbYFDGpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 02:45:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1016400ywe.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8nHe2iNAOWC+qQFyQTwu0G3ijVpeHn49kaKjVfs0T9k=;
        b=wwnbRxz7QkuYEGxY/l3cMyP4pXhgAW3QOOBbTu28bZfDRCz2qFtlyCS6Uu4EEiq3uS7wBhAwPusRtGphWy+NLU287ANg6qVOelAErCFK3N7wEQpo5ve8tdd+b+XdENUazhLhO8IVSrx6DiMLCvkq9h+McbuFK8HwDBOPIudJCEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z21jIKumh0HfNU99TcIit628fJhjh0V/CtqfJ2w7vb1Ozx8Oa8j2IlF90Yvpn+e739wFI0uKHYzPMGzqV5JpsgP7fLQEK3dHVYHE6uJog06Ei1O9hYeOdaN3UnifUeXLunyAHLNS61IbaaWP74lnlygiIGRRaWF2Npz5QfoHxfk=
Received: by 10.151.51.18 with SMTP id d18mr1956461ybk.88.1212561936536;
        Tue, 03 Jun 2008 23:45:36 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Tue, 3 Jun 2008 23:45:36 -0700 (PDT)
In-Reply-To: <20080604042703.GQ12896@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83748>

On Wed, Jun 4, 2008 at 10:27 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
>> The first version I mavenized JGit I moved the source code, but I
>>...
>> welcomed or not.
>
> [please don't top-post on this list]

Sorry, but I thought that I was proposing something new and thus top-posted :)

>
> I'd rather us moving the code into a subdirectory than require
> a symlink.  For Eclipse this is easy to change the directory that
> the code is in, we just have to edit the .classpath to move the
> source folder lower in the tree.
>
> But this shows one reason why I don't use Maven I think.  The
> fact that we need a "java" directory to hold our java code.
> What if another build system wants a different name?  Grumble.

I am sorry for my ignorance, I thought that maven was the most widely
accepted java build tool, but what you said is a possibility.

>
> For the most part git-merge-recursive can handle a merge through
> this sort of rename.  But we'd like to do this sort of thing at
> some relatively stable point in time to try and minimize the impact
> it has.

When I was working with the moved source code git detected the renames
and propagated the changes, but I had to scrape it because of my
stupidity my mavenized jgit was in jgit folder that clashed with the
jgit shell script :). I would say once the move is done it would be
safe to continue.

>
> --
> Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
