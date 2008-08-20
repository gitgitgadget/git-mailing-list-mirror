From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-aware Issue Tracking?
Date: Wed, 20 Aug 2008 11:52:24 -0700 (PDT)
Message-ID: <m3fxozsepa.fsf@localhost.localdomain>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
	<20080819175931.GH20947@spearce.org>
	<200808192121.30372.robin.rosenberg.lists@dewire.com>
	<48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org>
	<20080820152305.GJ10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsoH-00007Y-Hh
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbYHTSw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbYHTSw3
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:52:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:25175 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYHTSw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:52:27 -0400
Received: by ug-out-1314.google.com with SMTP id c2so826721ugf.37
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=aknRdEf28xdJndWfJUxE1PW9e/0t4XaOQb9suxGHm8Y=;
        b=NEQmq6/DPYqJiKcjM+GwGTbjr8B+smYqeUdc2WXZw2PWmsTsNmxDvMb1kKxqd/Nidv
         P2xg8XM71agbsCtORPvxz42VxLZdRoivxnNJMhClZ429tVz8kkY/WcYu2jJJZQnHmCjQ
         sW+mJuD+45cplV8AeKc361eMegGYgoGrCeUwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=n0hpHujIl42/xiu7IdG3r1wu0g4wYLFvN1tCsnazdN3VumExmiWZITmp9wNqD9Y8Cm
         pHXFr/J4A7twxjoGFKl9k+bDw3LOjUWJopct5/n5cXqqIxHJRAhZlZ11panEtJPCb7Vp
         rsTcuisZHAfGmibtux+9pPRixgZBvnMtl1avw=
Received: by 10.210.47.1 with SMTP id u1mr513171ebu.133.1219258345618;
        Wed, 20 Aug 2008 11:52:25 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.246.2])
        by mx.google.com with ESMTPS id d2sm1944878nfc.20.2008.08.20.11.52.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 11:52:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7KIpVDm023543;
	Wed, 20 Aug 2008 20:51:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7KIovqG023538;
	Wed, 20 Aug 2008 20:50:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080820152305.GJ10544@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93014>

Petr Baudis <pasky@suse.cz> writes:

> On Wed, Aug 20, 2008 at 07:13:26AM -0700, Shawn O. Pearce wrote:
> > I've thought about starting a code.google.com project just to use
> > the issue tracking system there.  I'm using an internal tool to
> > keep of issues for myself, but that's not fair to the end-users or
> > other contributors...
> 
> I have been thinking about issue tracking for some of my projects too,
> but I'm wondering, does anyone have a comprehensive picture of the state
> of the Git-supporting issue tracking tools, especially those that keep
> the tracked issues in a Git repository as well?
> 
> 	http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-73b23f376ebd0222d1e4b08f09158172aa34c24f
> 
> has three, but two of them are in Ruby, which is rather discouraging.
> But Cil (in Perl) is already "self-hosting", so it might be well usable?

There is also Bugs Everywhere, written in Python, which supposedly has
(some form of) Git support:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndToolsWishlist#be

There was also 'grit' by Pierre Habouzit, also in Python, which got
abandoned and removed (also from wiki):
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools?action=diff&rev2=203&rev1=202
If I remember correcly Pierre promised to write down what he learned
about distributed bug tracking from his work on grit[*1*], when he had
a bit of free time, but I don't remember him doing it...

See also "[RFC] git integrated bugtracking" thread on git mailing list
(http://thread.gmane.org/gmane.comp.version-control.git/48981) where
grit started, and later "[RFC] Idea for Git Bugtracking Tool"
(http://thread.gmane.org/gmane.comp.version-control.git/76411), where
you can find different distributed bug trackers, not all of them
thought supporting Git.

HTH.

Footnotes:
==========
[*1*] http://thread.gmane.org/gmane.comp.version-control.git/76411/focus=76565
-- 
Jakub Narebski
Poland
ShadeHawk on #git
