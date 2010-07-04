From: David Bainbridge <david.bainbridge@gmail.com>
Subject: Re: SVN migration
Date: Mon, 5 Jul 2010 00:01:30 +0200
Message-ID: <AANLkTik7yYzUQ7RDaOTYvNIUOxHr6tHfY8cnOoUnVuio@mail.gmail.com>
References: <4C1957EF.6070504@gnatter.net>
	<4C25D783.4070602@gnatter.net>
	<AANLkTimtGoNQe2-nA_Qn_qsZP2Iley9x6TU3Ht28Eg4t@mail.gmail.com>
	<4C30CB1A.2030407@gnatter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: William Hall <will@gnatter.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 00:01:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVXG0-0005OA-Mr
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 00:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007Ab0GDWBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 18:01:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59117 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab0GDWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 18:01:40 -0400
Received: by pwi5 with SMTP id 5so1251387pwi.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tOIIiBofwrXbt8ipOVeY55ORaw40q1H5Hn20W7b8IfM=;
        b=mu9eQBlkL/h+GkfH7qqjioBmuHgEkR1rY07Njo4cVaR7O0eAOAeFbV5JvuOITLuz0J
         g5XnCWuAgnSzdXfiqV/8XyWLP1KaTgu4iieQa5IOWB1dxRk2miLPBASWV2nQrpXUQq/y
         fltHyYJow9C2WkaPE2GxgXZkNQOxutu+X0CTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WIEdBoXGcCfCYzb4SZ/z9bDDWjIG5CKpc+2x5dhTmbdRyosjxsYASb/Qwvl6Srofev
         NmViUs0rflhGqyUpTWdouWA6Nrmd9Xxxg90I9gzPgmcNBbTcB+ZLVPB2kd5Iv5TEWpTF
         2Ba57YsHmNcsqEHs7ZlygR1LLzZrxYww+Vpvk=
Received: by 10.142.125.19 with SMTP id x19mr1522424wfc.44.1278280900112; Sun, 
	04 Jul 2010 15:01:40 -0700 (PDT)
Received: by 10.142.70.11 with HTTP; Sun, 4 Jul 2010 15:01:30 -0700 (PDT)
In-Reply-To: <4C30CB1A.2030407@gnatter.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150233>

Hi Will,

You seem to have all the bases covered :-)

It seems like they have been continuing to use SVN just because it was
there, and there was no one willing or able to take them somewhere
else, even when the business was changing around them.

The geographical distribution is an interesting one, because somehow
someone needs to understand what progress is being made with the
product development. With Git it can be easy for people to hide their
'dirty little secrets' for far too long. This doesn't really matter in
open source development, but is an issue for in a commercial
situation.

I tend to prefer a central repository and then judge progress by what
is there. If it isn't there it hasn't been done ...

Unfortunately Git books are not so hot on this aspect of deploying Git :-(

Maybe there are some other ideas out there ...

All the best,

David Bainbridge
Sweden









On 4 July 2010 19:55, William Hall <will@gnatter.net> wrote:
> Hi David,
> Thanks for your thoughts!
>
> I agree with your points. To an extent, management don't really care how we
> implement SCM - as long as it's effective and secure they will trust the
> "tech-wranglers" to do the right thing and not impede upon the company's
> workflow. Fortunately the industry in which I work is VFX, so "cutting edge"
> software is at the core of what we do. I am not imposing Git because of my
> own personal preference, I honestly believe that SVN is simply not the right
> tool for the job - which will increasingly involve multi-site collaboration
> that spans departments as well as timezones. The ability for two disparate
> teams of developers to collaborate effectively without polluting the global
> codebase is essential.
>
> The limitations with SVN are becoming more and more apparent - especially
> now that we have now embarked upon a fairly radical shake-up of our existing
> software stack.
>
> I have explained all this with senior management, some who have heard of Git
> (and its reputation) and they pretty much say "about time too".
>
> The hard part is that we have two tiers of developers - core software
> techies (C++, python) and scripters (python, MEL - these are the people who
> make VFX movies, for example, happen). The former will have no problem with
> Git, the latter probably just don't care - they just want to check stuff in
> and out.)
>
> What I need to do is create this hybrid system that enables the scripters to
> pretty much carry on as usual, and to provide the necessary tools to do SCM
> more effectively - ie without the overhead of a brittle SVN environment. If
> all goes well, we'll take the plunge and make the switch permanent.
>
> Yes, the technical sell for Git is the easy part, the cultural sell will be
> harder. It's up to me to make the business case to the bean-counters and
> make the technical transition painless. So far, so good.
>
> I've posted this before, the scripts I am using are available at -
>
> http://github.com/innerhippy/svnAndGit
>
> The more eyes on this the better...
>
> Cheers
>
> Will
>
>
>
>
> On 03/07/10 12:37, David Bainbridge wrote:
>>
>> Hi William,
>>
>> I have been following this thread with interest so I thought that I
>> would just throw in my thoughts!
>>
>> While maintaining synchronization with Git is part of what is needed I
>> suspect that this will not entirely convince the management of your
>> company that Git is the way forward.
>>
>> They probably see Svn as a safe repository ... The company's assets
>> (intellectual property) are on a central server that is backed up, and
>> the contents of that repository can be audited and so on. They may be
>> thinking about things like SOX compliance too.
>>
>> So if you want them to accept Git as a replacement for svn then you
>> need to understand and address these concerns. This means that you
>> will have to have a conversation with them. To a large extent this a
>> people thing ... technical solutions won't necessary convince them.
>> They are running a company based on the knowledge and information they
>> own - and they want to make sure that it doesn't get lost, stolen,
>> corrupted, or whatever. And they are accountable to the shareholders
>> for this.
>>
>> Also, you say that they have been using Svn for donkey's years, so
>> from a corporate perspective it probably does what they want and need.
>> Otherwise THEY would have decided to change it.
>>
>> I am in a similar situation and while developers clearly want to use
>> gIt, the motivation from a corporate perspective is less clear and can
>> be perceived as introducing risk. So we are looking at the wya in
>> which repositories are set up, the topology of git repository
>> networks, use of Gitosis. Gitolite and Gitorious, and so on, to
>> provide some security in the corporate environment.
>>
>> Every company will have a different view of this so there is no
>> 'right' answer. A lot depends on the type of product you produce and
>> how long it will need to be supported. If you have products that need
>> to be supported for 10 years or more then promoting a tool that is 5
>> years old may also raise some eyebrows! You need to have the answers
>> ready :-)
>>
>> Get it right and you will be seen as a hero who understands the
>> business. Get it wrong and you will consigned to the religious nerd
>> category who just wants to promote his favourite tool ... which I
>> would hope is not the case :-)
>>
>> Good luck with this ... you are not alone!
>>
>> Dave Bainbridge
>
