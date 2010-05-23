From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Mon, 24 May 2010 00:46:06 +0200
Message-ID: <1274654766.25555.25.camel@Luffy>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	 <AANLkTilIihNTDPZ5NIKUzsPEZ2Gpusm-10FCBVifvNuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: David Bainbridge <david.bainbridge@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 00:46:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGJw4-0001gn-1c
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 00:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab0EWWqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 18:46:14 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58577 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0EWWqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 18:46:13 -0400
Received: by wwe15 with SMTP id 15so130841wwe.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=G2MS3j7tDMBwzeNEsejTgg3B7nsQSPpS/7qiyjvgSGA=;
        b=K01+AoUocvvsboW0UQ5khKplXvI2qA6RdNTN9RyX4lHl13JQDY/pbSpzKsslTRJCqI
         FZzJOBAhk5XYiH5Cjhl2MMlOC+WoGlDl5K371No0fHOO8mLxNNkubjEIee5FCDnhEmK9
         Y+3ku4lVZglemkocKCw9RuiN6djL65CAndnJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=vwW/AI67Os+WiaYZ+KFTfKBPMqmnRgbqLhxp4+k12yPZSbKgsMu/aKiAzuP+Bz1fOB
         7b/Tv6HFMUzdxdqeoC/CJ8RLr/H5bUdbnEq8JF9/SJeQ8kMuOziuI2ihELVCf+bzWDcU
         9xMM2Ixl87oQTStSMml7Ok6/W+AB5igGVn8bI=
Received: by 10.227.155.135 with SMTP id s7mr4521251wbw.168.1274654771773;
        Sun, 23 May 2010 15:46:11 -0700 (PDT)
Received: from [192.168.1.2] (host32-6-dynamic.52-82-r.retail.telecomitalia.it [82.52.6.32])
        by mx.google.com with ESMTPS id h22sm26769124wbh.21.2010.05.23.15.46.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 15:46:10 -0700 (PDT)
In-Reply-To: <AANLkTilIihNTDPZ5NIKUzsPEZ2Gpusm-10FCBVifvNuw@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147596>

Hi David,
I'm quoting all your email with no cleaning here because I think you did
not included the git mailing list as a mistake.

Il giorno dom, 23/05/2010 alle 22.09 +0200, David Bainbridge ha scritto:
> Hi Daniele,
> 
> On 21 May 2010 16:55, Daniele Segato <daniele.bilug@gmail.com> wrote:
> > I work as a Developer (mainly Java and web applications) and I'd like
> > to introduce my company to the use of Git.
> 
> This is a trend that I am seeing in the company I work for too.
> 
> > There are, more or less, 30 developers working in different projects
> > from junior to senior developers.
> 
> > We use Subversion as versioning system.
> >
> > The developers are used to work with Eclipse (an open source IDE) that
> > happen to have a Subversion plugin and they all works on Windows
> > platform.
> > I'm the only one who work on a Linux box and use git-svn from command
> > line as a front end to Subversion.
> 
> So you are in a minority ... it's useful to recognise this. Others in
> your company may not share your views.

I KNOW other will not share my view. Another team leader with more
experience then me already told me that "moving to something different
of subversion is of no interest to him because he don't want to learn
something new"[1]. This happened during a random chit-chat when I
casually asked: "what would you think about moving from Subversion to
something more advanced?"
The topic dropped suddenly after it, I did not pushed it further :)

> > I already know of (some of) the advantage of using git, but I'm also
> > aware that it's not that easy to change other people mind on what they
> > used for years.
> 
> Not only that - it depends who decided to use Subversion and why. Was
> it a management decision, or was the decision made entirely by
> developers?

I think that the decision has been made a lot of time ago without any
particular reasons. Probably that just was the more diffused versioning
system, the one used and learned by almost all the developers around
here. (aka: you don't have to teach it to new employers, they usually
already know)

> Is Subversion used only during development or do you maintain the
> products in Subversion? In other words, is Subversion seen as a secure
> central repository for the company's intellectual property? If so,
> they may not take kindly to a DVCS unless it is deployed with some
> degree of centralization.

Both development and maintenance. Every developer signed an agreement to
not give any company sensitivity information away without the
authorization of the company itself, so I don't see any particular
difference in security between Git and Subversion. May be I missed the
point here anyway.

> Do your products have a short life time (less than a year) or do they
> have to be maintained over several years? If it is over several years
> then Git and Svn may also have to co-exist in the company for that
> time, and people may have to use both depending on what they are
> working on.

Again: both short and long life time projects.. I know they will have to
co-exist but I think that if the company get used to git will not go
back to subversion as I wouldn't unless given with no choice.

> Are there any security issues that need to be addressed? - especially
> if everyone is working on laptops and taking them home, or traveling
> with them.

Everybody work on laptop, but I don't think I get the issue here: be in
danger of someone stealing source code? Doesn't this have the same
security issue with subversion? (but the fact that with git you get all
the repository and not just a single version).

> I guess I am saying that you need to look at the extent to which the
> COMPANY is dependent on Subversion. This will affect your decision
> about who to talk to about migration - and who you will need to
> convince.

Usually in my company new technology comes from the developers
themselves, they have to promote and propose the idea themselves.
Managers don't care how you do thing technically. So if I really want to
introduce git I'll had to do it in my spare time: building up the
infrastructure to made migration easier as possible, be sure to be able
to handle all the issue that I can encounter and then begin to made my
team work with git.
After that I can show my manager that I increased the productivity and
that could made them decide to migrate the other teams too.

> All of which is aimed at item 4 in your list.
> 
> > 4. give my managers some reason to migrate/begin to use Git instead of
> > Subversion
> 
> Training, migration and so on will take time and therefore cost money.
> Yes, you can do it without management support but it will be a lot
> easier if you do have their support. Get this wrong and you may be
> seen by management as putting development at risk - and with only 30
> developers, they may see this as putting the company itself at risk.

I had to *start* it without the management support. And, to avoid the
risk of being seen as a risk I had to do this in my spare time. :)

> In the end the company has to ship products to make a profit, so
> focussing on that always helps :-) In small companies 'the management'
> may be the shareholders too!

Yes, that's the harder part.. I can see the benefit of using git for a
developer but I can't see the benefit for my manager.
Productivity is hard to quantify.

> This is an interesting topic that I guess affects more than a few of
> us that subscribe to this list.
> 
> Also, I must admit that I reacted to the way in which you expressed
> the question ... What's the best way to MAKE my company migrate to
> Git? This has a very evangelical tone to it, so I would tend to
> express this in other terms when discussing it in your company.
> 
> Answering your question is more about people than the tool itself.

Probably you are right, but I wrote here exactly to ask for advice on
the best way to propose git.
I know that the "evangelist" method will not lead me anyway within the
company, I'd like to have some suggestion on that :)

> 
> Hope this helps. And do keep us updated ... this is interesting!

I'll do.

> Regards
> 
> David Bainbridge


Thanks David for your suggestions.

Regards,
Daniele Segato

[1] a note: this may sound like "I don't care about new technology".
That's not exactly the case, you can read it like this: "I already have
a lot of thing to do (too much thing) and I can't add anything else
without going crazy".
