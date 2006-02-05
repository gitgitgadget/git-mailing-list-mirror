From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 5 Feb 2006 14:36:51 +0100
Message-ID: <e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 14:37:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5k4h-0007ld-75
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 14:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWBENgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 08:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWBENgx
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 08:36:53 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:1468 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750804AbWBENgw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 08:36:52 -0500
Received: by wproxy.gmail.com with SMTP id i23so912068wra
        for <git@vger.kernel.org>; Sun, 05 Feb 2006 05:36:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NLPIcobRWp/9JzpXl04G5k39mRKvx4C63XCAiiUfNG+DWgnvmV7WQWWkds7a/1qhZreeCYFYmrM6V9qZm98oiqg3POMBJERzEy9ueBFXRImk4sYWIuc+PnGwJKVGQNfW4rz7kzbJj8wc41KBcgdY9sZe4s/hb23deKtbxLKmlzE=
Received: by 10.64.153.4 with SMTP id a4mr92809qbe;
        Sun, 05 Feb 2006 05:36:51 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sun, 5 Feb 2006 05:36:51 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15631>

On 2/5/06, Junio C Hamano <junkio@cox.net> wrote:
> I am addressing people who participated with their valuable
> inputs to the earlier "git commit" discussion.
>
> Here is my first cut.  I'd appreciate to hear from both
> git-experienced people and git newcomers how comfortable this
> new implementation is.  Improvement patches on top of this are
> certainly appreciated.
>

I think the new semantics is clear and better then old one, especially
for people coming from different scm systems.

Unfortunately it breaks qgit commit functionality. So I would like to
ask _how_  do you plan to update main line.

I would like to update qgit also today, but it is impossible because
"git-commit -i"  _currently_ raises an error. So I am just wondering
if adding a temporary -i "no op" option to _current_ git-commit, until
semantics change is released could be done.

Adding a -i "place holder" option to _current_ git-commit has the
following advantages:

1) No functionality change and 100%  compatibility with current git-commit use.
2) Give people time to update tools/script in the mean time
3) When the real patch will be released all the (modified) tools will
be automatically compatible.

What do you think?

Marco
