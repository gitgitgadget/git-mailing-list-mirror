From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 25 Apr 2007 12:35:47 +0200
Message-ID: <81b0412b0704250335h70dd7cf8l69bb302f0c5f1f92@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <46a038f90704170333t38992792m77ddb3d927b21842@mail.gmail.com>
	 <81b0412b0704170739te4c35f0m8e4a3cd5bad440cd@mail.gmail.com>
	 <56b7f5510704250158v5d80feb7gb82db0da2349eb8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Pietro Mascagni" <pietromas@gmail.com>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 12:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgeqm-0004Ic-Mo
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 12:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992571AbXDYKft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 06:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992572AbXDYKft
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 06:35:49 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:62351 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992571AbXDYKfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 06:35:48 -0400
Received: by an-out-0708.google.com with SMTP id b33so2120ana
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 03:35:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gttxu9JQccNZeYpNWtJk9FU2dTRvtx+f6jUyQOKexe3O7RhpHU5Lr+s0NeEvEEWHkN1l9sTIAseK38JIFoSYzv/eAdMHYeGoR46tz9FJON9uTOA+PXzC8T1m3aLdUwiTE92hcXZB7wts9CgoZ7Xy6WuWLjkCtdBL4SFL4Rfmjf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rpg2NKQnjNkLDtBwHDSHdciSFG50tRPA+bg0jig41sS0JSOcbDuhrbe2kE8KdMJ19axw4niM2vc9QZpM6ofvRa6NQax1C3XimAG8uwmzfDs8hLI5yMEy6Xl7xYrZ50qm/Cj7sLraov6DxMhq6bQFUtmOragceSvyCKeIfBNKlzo=
Received: by 10.100.190.8 with SMTP id n8mr2578anf.1177497347196;
        Wed, 25 Apr 2007 03:35:47 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Wed, 25 Apr 2007 03:35:47 -0700 (PDT)
In-Reply-To: <56b7f5510704250158v5d80feb7gb82db0da2349eb8f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45517>

On 4/25/07, Dana How <danahow@gmail.com> wrote:
> On 4/17/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 4/17/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > >  - Old school SCMs allow you to branch, but are unable to keep track
> > > of merges in any meaningful way. Every time you merge, history is
> > > lost. GIT (and other DSCMs) have excellent branching _and_ merging
> > > facilities.
> > This one was a bad argument too. Curiously, and I cannot explain why,
> > ability to branch is considered a weakness of GIT ("because it confuses
> > the integrators", them being old mean men). The Perforce is said to
> > be "vastly superior to everything" on these grounds: "it also has
> > branching support, but luckily(!) it is hard enough for simple
> > developers. Was not their (Perforce's) fault, they just included it
> > to keep up with the market". Almost exact wording (I had to translate it).
>
> You are also trying to gain traction in a Perforce environment?
> I'd be interested in any more details you might have;

Well, as I have failed on every attempt get the idea through,
I am not sure I _have_ any useful details which can be shared.
Right at this moment I'm working on importing/exporting scripts
which hopefully can impress my colleagues enough to use git
(P4 is almost universally hated). The problem is complicated
by the fact we have to use a homegrown program which replaces
"p4 sync" (as it is somewhat handicapped in its ability to specify
what revision of what part of a project to sync).
At the moment there 4 scripts: one to workaround the mentioned
tool (unrelated to git), one to put the data into index (must use
perforce to get the real names of the files, the local names
constantly get mangled by windows), one to commit the index
along with information about the clients state (mappings aka
client specification, revision lists and custom information this
dumb tool of ours needs) and one to export git changes.
All this is very loosely connected and integrated, so I can use
them independent of each other. This also means that there
is a lot of hand work to do, though. I can share the last three
scripts, if anyone interested (the first is of no use to anyone,
except me).
