From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Thu, 9 Oct 2008 22:25:29 -0600
Message-ID: <51419b2c0810092125w38c2eaffgc023cec207731a3e@mail.gmail.com>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
	 <20081009061136.GA24288@coredump.intra.peff.net>
	 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
	 <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
	 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <48EE1F58.2060707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Caleb Cushing" <xenoterracide@gmail.com>, git@vger.kernel.org,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 06:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko9aQ-0002R6-At
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 06:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYJJEZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 00:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbYJJEZb
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 00:25:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:46700 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYJJEZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 00:25:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so372542rvb.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rVaP3zEn//INwJKd/xyFa/Zgg9R9+nb88wMtp0Or3vY=;
        b=Y+uDtsK0zx/J4fvGX3Q0vACdzUNF/CHIxWZDEvB4kdyJGNlFlpDiSdDMiZ/vk6OqHG
         EhzMB190eW6jK71ErtNe2Y/lWa5PTjwR3cqQSaIRJ/QThrnBGBDVkjxmyx6eH3WDOgPA
         DCoRbr8Qe9J50VZGRMSVQRQ3Mo+NTZ1+Rz2Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bv+mjvwXGYOBeYi5VseLz21lRJMYKerAeCD5zk3XcfA0YOtBzSeW1/zfyCsNeJg8V3
         1lOFCSSplAd/Zl6zNw8HesQAgyESGDnfJP2+CfMTwxlysxh10gE/mIVSVXYXP5yIu4Je
         wl3GZYdV34P5Hw+j55xXj/omt5IrdxMOkTNmo=
Received: by 10.141.197.14 with SMTP id z14mr721452rvp.283.1223612729914;
        Thu, 09 Oct 2008 21:25:29 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Thu, 9 Oct 2008 21:25:29 -0700 (PDT)
In-Reply-To: <48EE1F58.2060707@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97910>

On Thu, Oct 9, 2008 at 9:12 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
<snip>
> A few radical suggestions might be:
>
> 1. make ls-files and diff --name-status use compatible letters
>
> 2. rename git commit -n to git commit -b (as in bypass), make git commit
> -n do what's expected ("--dry-run", n as in duNNo yet)

Ouch.  Please not -b.  I guess I need to get my other suggestions
upstream if I want to avoid option conflicts like this...

> 3. rename git status to git commit -n
>
> 4. make git status generate git diff --name-status like output

I'd really prefer to be able to get staged vs. unstaged information
out of status.  And the single-letter output, like what cvs/svn/hg
have, is less descriptive here.  (Sure, git status could use some
cleanup IMO, but a word instead of a letter for modification status is
a usability improvement in git over those other systems for new VCS
users.)

> (3+4)'. make git status -l generate git diff --name-status like output
> (l as in status Letter) as an alternative to 3+4

That seems nicer.


And another radical suggestion (wasn't this brought up before too?):

5. Allow limiting the status output to a set of paths.  diff, log,
add, grep, etc. can all take a subdirectory name and limit their
operation to files recursively underneath that path, but git status
doesn't do so when you run 'git status DIR'.  I know why it currently
behaves as it does, but it sure seems like unnecessary UI
inconsistency.


Just my $0.02,
Elijah
