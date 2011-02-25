From: Miles Bader <miles@gnu.org>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 13:30:28 +0900
Message-ID: <buozkpk91nf.fsf@dhlpc061.dev.necel.com>
References: <20110224112246.3f811ac2@glyph>
 <4D6672F7.4020101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 05:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PspK9-0006qk-HM
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 05:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab1BYEab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 23:30:31 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:41235 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab1BYEab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 23:30:31 -0500
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LH500C5XOIUISF0@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Fri, 25 Feb 2011 13:30:30 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LH5000ICOIT4BD0@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Fri, 25 Feb 2011 13:30:29 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id D316328088; Fri, 25 Feb 2011 13:30:29 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id BB3AA28070; Fri,
 25 Feb 2011 13:30:29 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac2.idc.renesas.com with ESMTP id PAN04593; Fri,
 25 Feb 2011 13:30:29 +0900
X-IronPort-AV: E=Sophos;i="4.62,222,1297004400";   d="scan'208";a="13475721"
Received: from unknown (HELO relay11.aps.necel.com) ([10.29.19.46])
 by relmlii2.idc.renesas.com with ESMTP; Fri, 25 Feb 2011 13:30:29 +0900
Received: from relay11.aps.necel.com ([10.29.19.46] [10.29.19.46])
 by relay11.aps.necel.com with ESMTP; Fri, 25 Feb 2011 13:30:29 +0900
Received: from dhlpc061 ([10.114.97.82] [10.114.97.82])
 by relay11.aps.necel.com with ESMTP; Fri, 25 Feb 2011 13:30:29 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 034AE52E1DC; Fri,
 25 Feb 2011 13:30:28 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4D6672F7.4020101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167875>

Michael J Gruber <git@drmicha.warpmail.net> writes:
>> git add -A && git commit -m "Message"
>
> "commit -a" is much like "add -u", at least when used without file
> arguments ("pathspec").
>
> "commit -A" does not exist, so that "git add -A && git commit" is your
> only way.
>
> Why does it not exist? Because you should at least
> "git add -A && git status && behappy && git commit".

The exact same argument applies to "git commit -a" of course, but it's
still supported.  Why?  Because it's a nice convenience for many common
situations.  It isn't the least bit unsafe if one does git status _first_.

> Also, "-A" supports a very "un-gitty" way of using git. This makes it
> unlikely that someone cares to implement it... (By "un-gitty" I don't
> mean a matter of personal taste, but a matter of fruitful habits.)

Nonsense.

The index is a great idea, and cool and useful in many situations; I use
it heavily, and wish other systems had something like it.  But there's
nothing "un-gitty" or "unfruitful" about directly commiting sometimes.

For the record, I usually use the index, but sometimes when the changes
are simple, I'll use shortcuts like "commit -a", because they're handy.
Typically I'll do "git status" _first_, check that everything's kosher,
and then do "git commit -a ...".  If "git commit -A" existed, I'd use
that in the same way.

-Miles

-- 
Mayonnaise, n. One of the sauces that serve the French in place of a state
religion.
