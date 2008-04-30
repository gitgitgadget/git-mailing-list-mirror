From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Tracability in git commits
Date: Wed, 30 Apr 2008 11:32:00 +0100
Message-ID: <1209551520.5010.20.camel@dax.rpnet.com>
References: <1209473739.5642.31.camel@dax.rpnet.com>
	 <m3lk2vodw4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 12:33:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr9cf-0001ae-3W
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 12:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbYD3Kc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 06:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755750AbYD3Kc0
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 06:32:26 -0400
Received: from tim.rpsys.net ([194.106.48.114]:48552 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755586AbYD3KcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 06:32:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id m3UAWAQn026556;
	Wed, 30 Apr 2008 11:32:10 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 26274-09; Wed, 30 Apr 2008 11:32:06 +0100 (BST)
Received: from [192.168.1.3] (dax.rpnet.com [192.168.1.3])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id m3UAW0VL026534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Apr 2008 11:32:00 +0100
In-Reply-To: <m3lk2vodw4.fsf@localhost.localdomain>
X-Mailer: Evolution 2.12.1 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80825>

On Wed, 2008-04-30 at 03:06 -0700, Jakub Narebski wrote:
> Richard Purdie <rpurdie@rpsys.net> writes:
> 
> > I've been wondering about whether its possible to provide some degree of
> > traceability of commits to a shared git repository. The potential
> > nightmare scenario is one developer making a commit pretending to be
> > someone else.
> [cut]
> 
> If you really need that, perhaps you would be better with using
> Monotone, with its elaborate security and trust-related features?
> 
> IIRC we recommended Monotone to IPSec folks here...

The project I'm thinking about is OpenEmbedded which used to use
bitkeeper and switched to monotone when bitkeeper went private only.

The issues with monotone are ones of poor performance, particularly with
the usage patterns we have, lack of good branching/merging capabilities,
lack of good web interfaces, high server load, some breakage issues and
a now general ill feeling amongst OE's developers.

Whilst monotone has improved tremendously from where it was, I'm not
sure certain features we need are going to appear in it within the
medium term which makes git look attractive.

When we switched to monotone we also lost our bitkeeper history which
I'd like to see us reunited with. I've been trying to make a sane
conversion of the bkcvs dump to git using git-cvsimport and the bkcvs
mode of cvsps but I'm having problems which I'll perhaps mention in
another email once I've had time to try and understand them properly.

Its by no means certain OE will switch but we want to setup a git trial
system and see exactly what we gain/lose. Evaluating the 'security'
consequences of a move is part of the equation. hg is another option
under consideration but not many of us have experience of it and we're
wary of choosing an SCM with a smallish userbase again amongst other
things.

Cheers,

Richard
