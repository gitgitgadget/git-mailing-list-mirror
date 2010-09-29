From: Andreas Ericsson <ae@op5.se>
Subject: Re: Another way to compare tools: is it possible to transfer full
 history?
Date: Wed, 29 Sep 2010 13:19:31 +0200
Message-ID: <4CA320C3.6090006@op5.se>
References: <loom.20100928T153519-936@post.gmane.org> <4CA20169.2040606@dbservice.com> <loom.20100929T130008-795@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuomo <tuo.tie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 13:19:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0uhL-0000cn-4r
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab0I2LTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 07:19:37 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44572 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753408Ab0I2LTh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 07:19:37 -0400
Received: from source ([209.85.215.178]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTKMgx9Uc9LWYZ9BfZOW/9kUlRw4Puqc9@postini.com; Wed, 29 Sep 2010 04:19:36 PDT
Received: by eyh6 with SMTP id 6so190098eyh.23
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 04:19:34 -0700 (PDT)
Received: by 10.213.34.70 with SMTP id k6mr1242581ebd.65.1285759174558;
        Wed, 29 Sep 2010 04:19:34 -0700 (PDT)
Received: from clix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id a48sm12212554eei.19.2010.09.29.04.19.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 04:19:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <loom.20100929T130008-795@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157552>

On 09/29/2010 01:03 PM, Tuomo wrote:
> Tomas Carnecky<tom<at>  dbservice.com>  writes:
> 
> Which tools belong to the same class with Git?

All repositories from pure distributed version control systems can be
transformed into git repositories and git repos can be transformed into
a repository of a pure distributed version control system, but not all
repositories can do so without information loss since all dvcs systems
store and represent things different and have (slightly) different
capabilities.

Octopus merges have been mentioned. I'm sure there are other things,
such as the three different tag-types we have in git, that can't be
properly represented by other scm systems.

Exactly which those are and how it affects conversions from one
system to another is something you seem to want to learn without
actually doing the job of finding it out, and I doubt anyone on this
list knows every detail you're looking for (although the complete
information you're after might be available in scattered form among
the population on this list).

> 
> Is it possible to make a round-trip Mercurial->Git->Mercurial or
> Git->Mercurial->Git without loss of any information?

That depends. If the git repository has no octopus merges and no tags
of a type that can't be represented in mercurial, I believe it should
be possible.

Try and find out.

> I would expect that
> Mercurial->Git->Mercurial might produce some differences if files have been
> renamed or moved between directories, but other than that?
> 

Possibly. Again though; Try and find out.

> What particularly interests me is how the conversion handles unnamed Mercurial
> branches?

Probably as detached heads. There's nothing special with having commits with no
refs attached to them in git.

> I am asking this because at work, I had to ponder once if it would be
> possible to transfer histories from Synergy (ex Continuus) to some other tool,
> and found it very difficult to imagine how to create named branches from the
> version DAGs Synergy uses. You can never be sure if a new version is a successor
> of its predecessor on the same branch or the first version on a sub.branch,
> because Synergy doesn't treat them any differently. users often try to organize
> the branches in ways compatible with other tools, but since Synergy has no way
> of enforcing any of these methods, there is no guarantee of consistency. The
> worst-case scenario is that every single version is its own branch. So, I really
> would like to know how the unnamed branches from Mercurial are transferred to
> named branches in Git?
> 

So now we get to a proper use-case. You want to convert a Synergy repository to
something else, and you've been looking at mercurial and git.

So let me ask you a question; What have you done so far to find out the answer
to the questions you're looking for, apart from asking here how a theoretical
scenario would pan out?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
