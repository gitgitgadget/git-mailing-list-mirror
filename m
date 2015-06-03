From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Stash Feature
Date: Wed, 03 Jun 2015 11:53:21 -0700
Message-ID: <86lhg0vd26.fsf@red.stonehenge.com>
References: <CAGmnFohE3ihA8T8srk1BpXg5z80tnjyUhdjFieXGYm=T0gkMUA@mail.gmail.com>
	<20150603185358.a30d606cc0c475cb17a048c7@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fabrizio Mancin <fabman08@gmail.com>, git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Dui-0004an-PG
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbbFCTBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 15:01:16 -0400
Received: from 001.lax.mailroute.net ([199.89.1.4]:50962 "EHLO
	out-001.lax.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbbFCTBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 15:01:15 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2015 15:01:15 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by out-001.lax.mailroute.net (Postfix) with ESMTP id 3m1zsJ5fpNzhYC0;
	Wed,  3 Jun 2015 18:53:24 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from out-001.lax.mailroute.net ([199.89.1.4])
	by localhost (001.lax.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id 9BmY0htwqyDI; Wed,  3 Jun 2015 18:53:23 +0000 (UTC)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by out-001.lax.mailroute.net (Postfix) with ESMTP id 3m1zsH5nRrzhYBw;
	Wed,  3 Jun 2015 18:53:23 +0000 (UTC)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 5718D1AAE; Wed,  3 Jun 2015 11:53:21 -0700 (PDT)
x-mayan-date: Long count = 13.0.2.8.14; tzolkin = 1 Ix; haab = 2 Zotz
In-Reply-To: <20150603185358.a30d606cc0c475cb17a048c7@domain007.com>
	(Konstantin Khomoutov's message of "Wed, 3 Jun 2015 18:53:58 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270723>

>>>>> "Konstantin" == Konstantin Khomoutov <kostix+git@007spb.ru> writes:

Konstantin> On Wed, 3 Jun 2015 17:22:57 +0200
Konstantin> Fabrizio Mancin <fabman08@gmail.com> wrote:

>> I've a little request for you.
>> What about saving date-time on git stash save command and show it on
>> git stash show stash@{xxx}?
>> I think it is a useful poperty to save.
>> 
>> What do you think about it?

Konstantin> This information is already there as a stash entry is
Konstantin> internally represented as a commit (with one or more
Konstantin> parents), and being a commit, it possess all the standard
Konstantin> attributes of a commit, including the creation timestamp.

git stash list can take a --format as well.  Here's a couple of my
aliases:

  sl = stash list --pretty='%gd: %h [%ar] %s'
  stashed = stash list --pretty='%gd: %Cred%h%Creset %Cgreen[%ar]%Creset %s'


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix consulting, Technical writing, Comedy, etc. etc.
Still trying to think of something clever for the fourth line of this .sig
