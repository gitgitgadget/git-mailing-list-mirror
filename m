From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 04 Jun 2008 04:09:18 -0700 (PDT)
Message-ID: <m3iqwpzccs.fsf@localhost.localdomain>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	<7vmym1zny4.fsf@gitster.siamese.dyndns.org>
	<18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
	<m3mym1zkus.fsf@localhost.localdomain>
	<18c1e6480806040130k3851a89an3fcf986feb661226@mail.gmail.com>
	<D11EAC1A-B59E-4857-A31F-809809310E40@wincent.com>
	<18c1e6480806040302k74156d47p4e878fef62d21b87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Wincent Colaiuta" <win@wincent.com>, git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 13:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3qti-0004z8-EQ
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 13:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbYFDLKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 07:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759959AbYFDLJh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 07:09:37 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:25132 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758770AbYFDLJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 07:09:25 -0400
Received: by mu-out-0910.google.com with SMTP id w8so28401mue.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Jaf/27uYKWfH/4MDVFUIekMYYnexIpw9m0HfxSXy8uM=;
        b=h/pU3nmMgU6ECiTFhAvrO8L6SDRWP3oIEQCdOOvZs2FvU8i8bJEPao7uic/q8V97mj
         GgfUj5qc10pPLPiIVvZH9eNrOB8q4GG2m0j77c0l28OylyUlVxzKnhXuMiPIAlDT16MN
         G03C7vMnwMkLfLSaYZOMi9N41lII78csTColw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=opEP71AP0+KP0yM2DZNkg2HKLm9j3ejUTEIGVscXdKfysoOCb1lY7X2rFQrcQw8j0z
         Yl0Hw2vWEkXFE6FigXhEFQTLUeYa7r41iVDL2kazdj2gPp8VMqeIjGW3SxOw0PNZMgLw
         RTsA4Ezyl0BdPJXL1OZLBG9F+Ub/bymLaMHMQ=
Received: by 10.103.202.13 with SMTP id e13mr1469599muq.3.1212577760251;
        Wed, 04 Jun 2008 04:09:20 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.131])
        by mx.google.com with ESMTPS id s10sm1990323muh.10.2008.06.04.04.09.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 04:09:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m54B8rI4003255;
	Wed, 4 Jun 2008 13:08:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m54B8aDu003251;
	Wed, 4 Jun 2008 13:08:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <18c1e6480806040302k74156d47p4e878fef62d21b87@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83772>

David <wizzardx@gmail.com> writes:

> On Wed, Jun 4, 2008 at 11:39 AM, Wincent Colaiuta <win@wincent.com> wrote:
> >
> > Sounds like it would definitely work but it also sounds like a lot of
> > repetitive "busy work"[1] which could be avoided by using finer-grained
> > topic branches in the first place.
> >
> 
> I see where you're coming from, and I am learning to work more in this
> way. Using git has made a big difference to how I develop. Not just as
> a SCM, but also for improved work-flow. eg trying out things in code,
> and storing failed attempts for later reference/retries/etc if it
> doesn't work out.
> 
> My problem with your post is, even if you take this to the extreme
> (topic branches for every fix that you want to make), there will still
> be cases where while working on one fix (maybe disruptive to the main
> branch), you uncover problems with master and start fixing it in your
> topic branch.
> 
> It isn't always easy to fix the problems in master (that you're seeing
> in topic) by changing back to master and making another topic. Maybe
> you can only (easily) find & detect the problems in master because of
> other changes in topic (eg: WIP unit tests) that you aren't ready to
> merge yet.
> 
> So you would probably have to jump back and forth between your topic,
> and your new 'fix problems in master' branch a lot to track down the
> issues and get the fixes into master. This sounds like a lot more
> 'busy work' than simply cherry-picking (multiple) those fixes out of
> your topic branch into master, and then rebasing your topic branch :-)

For this I think it would be best to use some kind of patch management
interface on top of Git, be it StGIT or Guilt (interface of the latter
is based on Mercurial Queues, hence former name Git Queues (gq)), see
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools (there was also
Patchy Git (pg) tool, but it is no longer maintained).  I personally
use StGIT, therefore all examples will use this tool.

Then you would be able to go back and forth between patches (commits),
correct them, with some difficulty even split or join them.

Now the workflow depends if you are third-party contributor, sending
patches upstream via email, or if you are project maintainer, and
others pull from you.

If you are third-party contributor, sending patches upstream via
email,using "stg mail" or "git format-patch" plus either "git
send-email", or your favorite mail program, you would do the
following, on your topic branch:
  1. edit, going back and forth between patches
  2. "stg mail" patches to maintainer
  3. incorporate feedback, going to 1. if necessary
  4. fetch from upstream (I use "git fetch"/"git remote update")
  5. rebase your patches ("stg rebase <upstream>")
  6. remove applied patches (which should be empty) from stack,
     using "stg clean -a"; remove patches by hand if necessary
     ("stg remove <patchname>").

If you are maintainer / main contributor your workflow would be a bit
different.  Instead of emailing patches you would probably "stg
commit" them, turning them into ordinary commits (removing from patch
queue) when you finish working on them, then probably merge (parts of)
feature branch into one of stable branches ('maint', 'master',
'next',...).

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
