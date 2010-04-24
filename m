From: Wincent Colaiuta <win@wincent.com>
Subject: Bug#578764: 'commit -a' safety (was: Re: Please default to 'commit -a' when no changes were added)
Date: Sat, 24 Apr 2010 18:59:33 +0200
Message-ID: <8B19818F-6578-420B-974D-28C9E3283FD4@wincent.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <20100422155806.GC4801@progeny.tock> <m3633hdw9u.fsf_-_@localhost.localdomain> <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com> <20100424164247.GM3563@machine.or.cz>
Reply-To: Wincent Colaiuta <win@wincent.com>, 578764@bugs.debian.org
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Jakub Narebski <jnareb@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Goswin von Brederlow <goswin-v-b@web.de>, 578764@bugs.debian.org,
        git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org Sat Apr 24 19:03:20 2010
connect(): No such file or directory
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Envelope-to: glddb-debian-bugs-dist@m.gmane.org
Received: from liszt.debian.org ([82.195.75.100])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>)
	id 1O5ilB-0004n9-4K
	for glddb-debian-bugs-dist@m.gmane.org; Sat, 24 Apr 2010 19:03:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id CE1F813A51C5; Sat, 24 Apr 2010 17:03:16 +0000 (UTC)
Old-Return-Path: <debbugs@busoni.debian.org>
X-Original-To: lists-debian-bugs-dist@liszt.debian.org
Delivered-To: lists-debian-bugs-dist@liszt.debian.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id 9481A13A5196
	for <lists-debian-bugs-dist@liszt.debian.org>; Sat, 24 Apr 2010 17:03:16 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank bug
X-Spam-Flag: NO
X-Spam-Score: -2.599
X-Spam-Level: 
X-Spam-Status: No, score=-2.599 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2.599] autolearn=ham
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id 3VK8zlfVhLdm
	for <lists-debian-bugs-dist@liszt.debian.org>;
	Sat, 24 Apr 2010 17:03:10 +0000 (UTC)
Received: from busoni.debian.org (busoni.debian.org [140.211.15.34])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by liszt.debian.org (Postfix) with ESMTPS id B2B1613A515D;
	Sat, 24 Apr 2010 17:03:10 +0000 (UTC)
Received: from debbugs by busoni.debian.org with local (Exim 4.69)
	(envelope-from <debbugs@busoni.debian.org>)
	id 1O5il1-0007Hu-0H; Sat, 24 Apr 2010 17:03:07 +0000
X-Loop: owner@bugs.debian.org
Resent-From: Wincent Colaiuta <win@wincent.com>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Gerrit Pape <pape@smarden.org>
X-Loop: owner@bugs.debian.org
Resent-Date: Sat, 24 Apr 2010 17:03:05 +0000
Resent-Message-ID: <handler.578764.B578764.127212838526120@bugs.debian.org>
X-Debian-PR-Message: followup 578764
X-Debian-PR-Package: git-core
X-Debian-PR-Keywords: 
X-Debian-PR-Source: git
Received: via spool by 578764-submit@bugs.debian.org id=B578764.127212838526120
          (code B ref 578764); Sat, 24 Apr 2010 17:03:05 +0000
Received: (at 578764) by bugs.debian.org; 24 Apr 2010 16:59:45 +0000
X-Spam-Bayes: score:0.0000 Tokens: new, 24; hammy, 150; neutral, 174; spammy,
	1. spammytokens:0.999-1--perks hammytokens:0.000-+--H*f:sk:2010042,
	0.000-+--HMime-Version:Message, 0.000-+--HMime-Version:framework,
	0.000-+--HMime-Version:Apple, 0.000-+--H*i:sk:2010042
Received: from outmail149101.authsmtp.com ([62.13.149.101])
	by busoni.debian.org with esmtp (Exim 4.69)
	(envelope-from <win@wincent.com>)
	id 1O5ihk-0006mK-AE
	for 578764@bugs.debian.org; Sat, 24 Apr 2010 16:59:44 +0000
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt5.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o3OGxeU7074008;
	Sat, 24 Apr 2010 17:59:40 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o3OGxbMw092097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 Apr 2010 17:59:39 +0100 (BST)
Received: from [192.168.1.6] (175.Red-88-3-72.dynamicIP.rima-tde.net [88.3.72.175])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o3OGxYVP002647
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 24 Apr 2010 12:59:36 -0400
In-Reply-To: <20100424164247.GM3563@machine.or.cz>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: c5166e5b-4fc2-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJC0VH aBodB0JJdwdEHAkR AmEBXl1eU1Q/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNF3ofSU58 QR4XUBl7cEtEe3dx ZwgxW3FdWhF/J1t5 FB1WCGwHMTF9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcXJUOSc9 HhN7ejl+dS5WJilJ U0lNMlsJEw4xE2x0 fxQPFC4iVUEISSwu KwBuNllUU00WN0Az LRNkUB1QLB8fDEVY GAlGACZfKFQaDzUm Fw4SVEISHTEcKQAA 
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Resent-Date: Sat, 24 Apr 2010 17:03:07 +0000
X-Debian-Message: from BTS
X-Mailing-List: <debian-bugs-dist@lists.debian.org> archive/latest/617650
X-Loop: debian-bugs-dist@lists.debian.org
List-Id: <debian-bugs-dist.lists.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-bugs-dist-request@lists.debian.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145691>

El 24/04/2010, a las 18:42, Petr Baudis escribi=F3:

> On Sat, Apr 24, 2010 at 01:10:24PM +0200, Wincent Colaiuta wrote:
>> El 24/04/2010, a las 11:40, Jakub Narebski escribi=F3:
>>> I'd like for 'git commit -a' to *fail* if there are staged changes =
for
>>> tracked files, excluding added, removed and renamed files.
>=20
> Thanks for this suggestion, this is exactly what I wanted to propose!
> +1 here.
>=20
> I think this could even be made a default in some time, I don't see =
any
> useful workflows this could prevent and adding -f is trivial enough =
for
> those who really want to go forward.
>=20
>> For me this is going to far. While we don't want to make it _easy_ =
for users to shoot themselves in the foot, neither do we want to make it =
difficult or impossible for them to get the tool to do things that =
_might_ be a mistake. And what's the risk here? Accidentally committing =
too much is not a destructive change, and can be easily undone.
>=20
> Have you ever done this mistake? If you have done some extensive index
> editing, it is actually a major PITA to restore, and can be even
> destructive if your index and working tree are too much out-of-sync
> (this does happen to me not so seldom while I also use -a a lot for
> trivial commits).

Yes I have occasionally committed more than I meant to, but rarely much =
more, and almost never due to using "git commit -a", seeing as I hardly =
ever use it. I am of the "commit early and often" school, and my most =
common pattern is committing tiny batches of changes which I review =
frequently with "git diff" and then again by staging them with "git add =
--patch" (aliased as "git patch" seeing as I use it so often).

>> IMO, the fact that the commit message editor is populated with a list =
of changed files that will be included in the commit is enough for =
people to see what's actually going to happen.
>=20
> BTW, I almost always use -m instead of the commit editor. ;-)

Are you not a big fan of "subject line + justification" commit message =
format? Consider it one of the perks of using the format: your editor =
will show you a nice summary that gives you yet another chance to =
double-check what you're about to commit.

Cheers,
Wincent
