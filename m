From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: my git problem
Date: Wed, 30 Apr 2008 01:17:50 -0700 (PDT)
Message-ID: <m3prs7oixp.fsf@localhost.localdomain>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
	<20080427124454.6a606305.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
	<20080428114509.240ef4ae.akpm@linux-foundation.org>
	<alpine.DEB.1.00.0804281948270.19187@eeepc-johanness>
	<20080428120917.dd9f01e8.akpm@linux-foundation.org>
	<alpine.DEB.1.00.0804282012140.19187@eeepc-johanness>
	<alpine.LFD.1.10.0804281222190.3119@woody.linux-foundation.org>
	<20080429171519.GA21310@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:18:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7WY-0001Wy-ST
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbYD3IR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 04:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbYD3IR5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:17:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:30971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbYD3IRy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:17:54 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1371678ugc.16
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=GQaW8AoVWp/K72ZN399ViPYVGNVYgPOQW9Hdz3Sr2ZQ=;
        b=XjIlkUJIMMkfPZVpJyxtlarBLiwG1qnQYbR+/Hd4ywrr9tEabM1nxEccTxxaAGAGElQVa8TkXHyIUdlSEPNcrpkFL0unOAyctOdfdh3Kgp2JIPhjK3SyNlaZIwJs2EGPocaFM5CtSJkqjuEMt5g+ywLPXb2p5SI5c3H/VxWLFqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=BGnRP3v/dfDSeVtzD93Y2o2a2WDGgRAq9Mlpd/8VSLtPqtfOVgUON2yyoUtBsWZ38y+cT7SQamd1o5ZjN2bQ52UMS03htwhOoEd2oXQASa7obJoOPPz6zQZb1NAo2q0ZaIX6RIzLUPhKXxWHnycoMUJm/FYovWsujNeCE1sMg7s=
Received: by 10.67.102.6 with SMTP id e6mr3831615ugm.25.1209543472910;
        Wed, 30 Apr 2008 01:17:52 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.241.224])
        by mx.google.com with ESMTPS id r38sm3392622ugc.55.2008.04.30.01.17.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 01:17:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3U8HgQm000777;
	Wed, 30 Apr 2008 10:17:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3U8HcJF000773;
	Wed, 30 Apr 2008 10:17:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080429171519.GA21310@fieldses.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80806>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Mon, Apr 28, 2008 at 12:28:38PM -0700, Linus Torvalds wrote:
>> 
>> 
>> On Mon, 28 Apr 2008, Johannes Schindelin wrote:
>>> 
>>> On Mon, 28 Apr 2008, Andrew Morton wrote:
>>>> 
>>>> That's missing the "logical" bit :)
>>> 
>>> Heh, you're right.  I am too used to Git to think how other people would 
>>> feel about these things... :-)
>> 
>> No, you are both wrong.
>> 
>> You're wrong because apparently you never did abstract algebra and set 
>> theory in school.
[...]
>> If you know math, git actually does the rigth and very much the *logical* 
>> thing.
>> 
>> So ".." is a simple difference, while "..." is a more complex difference. 
>> 
>> They mean different things for different operation types, but that is 
>> again something a math person takes for granted (ie in algebra, a "+" or 
>> "-" is just a random operation that follows certain rules: "a-b" means one 
>> thing for the set of real numbers, and something *totally* different if 
>> you are talking about set algebra).
[...]
> I can sorta buy the argument that "A...B" means most generally "some
> kind of difference between the three sets A, A^B, and B", and that in
> the context of "git diff" it's most sensible to take ordering into
> account and produce some approximation of a diff between A^B and B.  I'd
> personally have found an entirely separate operator simpler to
> understand.  But perhaps there's only so many keys on the keyboard.

IMHO adding support for a..b and a...b to git-diff is a bit of trick,
as a..b and a...b were created to represent a set of revisions (a
revision range).

If we have linear history:

   *---*---*---a---*---*---b

then a..b notation for a revision range is very natural, and having
git-diff interprete "a..b" as "a b" (for git-diff only endpoints
matter) to allow copy'n'pasting between git-log and git-diff, and
between git-fetch messages and git-diff was a good extension.

Now if the history is not linear, as in example below:

   *---*---*---x---*---*---b
                \
                 \-*---a

then "a..b", which is shortcut for "b ^a" (b --not a), returns x..b
range (set) of revisions.  If you read "a..b" as "what's in 'b'
since 'a'" it makes perfect sense.  But "git diff a..b" is still
"git diff a b", not "git diff x b". 


It would be perhaps as good notation to have "git diff a..b" mean
"git diff x b", i.e. be diff between endpoints of "git log a..b",
and have "git diff a...b" be "git diff a b", i.e. to be diff between
endpoints^W points of "git log a...b"... but if there is no clean
winner, simplicity of implementation wins. 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
