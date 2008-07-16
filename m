From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 01:48:49 +0400
Message-ID: <20080716214849.GF2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:50:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJEsm-0003HT-Ue
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbYGPVs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756061AbYGPVs4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:48:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:11070 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbYGPVsz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:48:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2515974fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tC9xIfaNp5IoRuKTyRm0ERmsBxqN2MQdSnw25Fr1N18=;
        b=IVyyxZg4a34hoceX2U7nJMA2fkPEO48QFEs4cdmfhucBPgiOqTRmrWPeUj6XSlQEYN
         fosi9wVVPl8j6KEdvGcU2FpkoeG2rDrK4NceuexzII0WxU3LdbAvFB+LyGgyAhoT1YJc
         Q/jscVug0WUTPlpPNc9J1+a2xwCP+duBkINhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OARuEcRbN9ISgaqMl3BXhve2tVzHxRjJk1so6QCHM69wVZZAV0j5pnNQExtTlypOZm
         WVp9hD1oN1fmwEvR3AKeMqKc8CiXSBmOnxZ7XaWisPBm+2Z3Ol4kWIKoqcCIG0fdy65D
         kXMo6pCh34vs1rpgVzQuhMZgZBDWTRJlbdJKE=
Received: by 10.86.76.20 with SMTP id y20mr2766489fga.41.1216244933847;
        Wed, 16 Jul 2008 14:48:53 -0700 (PDT)
Received: from localhost ( [85.141.190.235])
        by mx.google.com with ESMTPS id 4sm3467959fgg.9.2008.07.16.14.48.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 14:48:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88764>

On Wed, Jul 16, 2008 at 06:21:02PM +0100, Johannes Schindelin wrote:
> 
> I had the pleasure of introducing Git to a few users in the last months 
> and in my opinion, restricting myself to teaching them these commands 
> first helped tremendously:
> 
> - clone, pull, status, add, commit, push, log

Yes, it is a good list, and I think it is very important at the
beginning to limit the number commands to 7-8, otherwise many users
may be confused. And, of course, it is better to stay away from all
command-line options at first...

> 
> All of these were presented without options, to keep things simple.
> 
> In particular, I refrained from giving them the "-a" option to commit.  
> That seemed to help incredibly with their embracing the index as a natural 
> concept (which it is).

Most things that we call as "natural" is those that we got used. Once,
you got used to it, it seems very natural, and the index is not
something that is really difficult to learn, but I don't think that
everyone may understand it fully. Some may use Git for many months and
only then suddenly discover that "git diff" does not show all
uncommitted changes, but only changes between their working directory
and the index. It may sound strange, but it happens.

> Now, it makes me really, really sad that Git has a reputation of being 
> complicated, but I regularly hear from _my_ users that they do not 
> understand how that came about.

I think this reputation is largely due to people who open Git user
manual, read about >100 commands, were horrified and stopped learning.
Git is a powerful and very flexible tool, thus to use it to its fullest
you may really need to learn a lot, but it does not mean that you can
use it and be much more productive than with other VCS knowing only a
small fraction of all options. Thus if you can explain to users in terms
that they understood and connect that with their workflow, users may
find Git easier to use than SVN...

> 
> Am I the only one who deems teaching plumbing to users ("I like it raw!  
> So I teach it the same way!") harmful?

There is only one thing that seems to be true about teaching Git (or
anything else) -- there is no single method that works equally well
for anyone. Having said so, I must admit that teaching plumbing will
be probably not a good idea for most users, yet there are some who
prefer bottom-up approach. Some users will prefer to connect Git
functionality to their particular needs and solving some practical
tasks that they do day in, day out, while others may prefer to start
with more abstract things like DAG, structure of data, etc... For
the later users, when you explained these basic things, you do not
have to explain commands at all. They may occasionally ask you
something like: git grep works fine for me when I need to find
something in arbitrary file at some particular revision, but how
about finding something in a particular file at arbitrary revision?
Then you say -- look at git log, it should have the grep option. It
is usually all explanations that you need to provide for them. The
rest, they will quickly pick up on their own. Yet, majority users are
not like that. They seem to prefer to start with specific use cases
and only basic porcelain commands... So, I agree with you here.

Dmitry
