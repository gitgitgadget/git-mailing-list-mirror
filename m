From: William Hall <will@gnatter.net>
Subject: Re: SVN migration
Date: Sun, 04 Jul 2010 18:55:38 +0100
Message-ID: <4C30CB1A.2030407@gnatter.net>
References: <4C1957EF.6070504@gnatter.net>	<4C25D783.4070602@gnatter.net> <AANLkTimtGoNQe2-nA_Qn_qsZP2Iley9x6TU3Ht28Eg4t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Bainbridge <david.bainbridge@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 19:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVTQC-00061J-2K
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 19:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088Ab0GDRzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 13:55:50 -0400
Received: from mail.qualtersystems.com ([74.200.89.103]:47997 "EHLO
	mail.qualtersystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab0GDRzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 13:55:49 -0400
Received: from localhost (mail [127.0.0.1])
	by mail.qualtersystems.com (Postfix) with ESMTP id A61CF2B68C77;
	Sun,  4 Jul 2010 18:55:48 +0100 (BST)
X-Virus-Scanned: amavisd-new at qualtersystems.com
Received: from mail.qualtersystems.com ([127.0.0.1])
	by localhost (mail.qualtersystems.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVTNsUMTVS07; Sun,  4 Jul 2010 18:55:41 +0100 (BST)
Received: from [192.168.1.85] (xambo.qualtersystems.com [82.152.227.154])
	(Authenticated sender: will@mail.qualtersystems.com)
	by mail.qualtersystems.com (Postfix) with ESMTP id C32DA2B68BB9;
	Sun,  4 Jul 2010 18:55:40 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <AANLkTimtGoNQe2-nA_Qn_qsZP2Iley9x6TU3Ht28Eg4t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150226>

Hi David,
Thanks for your thoughts!

I agree with your points. To an extent, management don't really care how 
we implement SCM - as long as it's effective and secure they will trust 
the "tech-wranglers" to do the right thing and not impede upon the 
company's workflow. Fortunately the industry in which I work is VFX, so 
"cutting edge" software is at the core of what we do. I am not imposing 
Git because of my own personal preference, I honestly believe that SVN 
is simply not the right tool for the job - which will increasingly 
involve multi-site collaboration that spans departments as well as 
timezones. The ability for two disparate teams of developers to 
collaborate effectively without polluting the global codebase is essential.

The limitations with SVN are becoming more and more apparent - 
especially now that we have now embarked upon a fairly radical shake-up 
of our existing software stack.

I have explained all this with senior management, some who have heard of 
Git (and its reputation) and they pretty much say "about time too".

The hard part is that we have two tiers of developers - core software 
techies (C++, python) and scripters (python, MEL - these are the people 
who make VFX movies, for example, happen). The former will have no 
problem with Git, the latter probably just don't care - they just want 
to check stuff in and out.)

What I need to do is create this hybrid system that enables the 
scripters to pretty much carry on as usual, and to provide the necessary 
tools to do SCM more effectively - ie without the overhead of a brittle 
SVN environment. If all goes well, we'll take the plunge and make the 
switch permanent.

Yes, the technical sell for Git is the easy part, the cultural sell will 
be harder. It's up to me to make the business case to the bean-counters 
and make the technical transition painless. So far, so good.

I've posted this before, the scripts I am using are available at -

http://github.com/innerhippy/svnAndGit

The more eyes on this the better...

Cheers

Will




On 03/07/10 12:37, David Bainbridge wrote:
> Hi William,
>
> I have been following this thread with interest so I thought that I
> would just throw in my thoughts!
>
> While maintaining synchronization with Git is part of what is needed I
> suspect that this will not entirely convince the management of your
> company that Git is the way forward.
>
> They probably see Svn as a safe repository ... The company's assets
> (intellectual property) are on a central server that is backed up, and
> the contents of that repository can be audited and so on. They may be
> thinking about things like SOX compliance too.
>
> So if you want them to accept Git as a replacement for svn then you
> need to understand and address these concerns. This means that you
> will have to have a conversation with them. To a large extent this a
> people thing ... technical solutions won't necessary convince them.
> They are running a company based on the knowledge and information they
> own - and they want to make sure that it doesn't get lost, stolen,
> corrupted, or whatever. And they are accountable to the shareholders
> for this.
>
> Also, you say that they have been using Svn for donkey's years, so
> from a corporate perspective it probably does what they want and need.
> Otherwise THEY would have decided to change it.
>
> I am in a similar situation and while developers clearly want to use
> gIt, the motivation from a corporate perspective is less clear and can
> be perceived as introducing risk. So we are looking at the wya in
> which repositories are set up, the topology of git repository
> networks, use of Gitosis. Gitolite and Gitorious, and so on, to
> provide some security in the corporate environment.
>
> Every company will have a different view of this so there is no
> 'right' answer. A lot depends on the type of product you produce and
> how long it will need to be supported. If you have products that need
> to be supported for 10 years or more then promoting a tool that is 5
> years old may also raise some eyebrows! You need to have the answers
> ready :-)
>
> Get it right and you will be seen as a hero who understands the
> business. Get it wrong and you will consigned to the religious nerd
> category who just wants to promote his favourite tool ... which I
> would hope is not the case :-)
>
> Good luck with this ... you are not alone!
>
> Dave Bainbridge
