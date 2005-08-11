From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 12:11:23 -0700
Message-ID: <7vfytgl25g.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	<7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	<7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
	<pan.2005.08.10.21.15.41.143251@smurf.noris.de>
	<pan.2005.08.10.22.11.25.242201@smurf.noris.de>
	<46a038f9050810155642bb5580@mail.gmail.com>
	<20050810233953.GV28270@kiste.smurf.noris.de>
	<E1E33Zb-0004dT-Bx@highlab.com>
	<46a038f90508102144358a4bcf@mail.gmail.com>
	<Pine.LNX.4.58.0508102200560.3295@g5.osdl.org>
	<E1E35vU-0004nP-JR@highlab.com>
	<Pine.LNX.4.58.0508110915210.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 21:12:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ISg-0002UX-GU
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 21:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVHKTL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 15:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVHKTL2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 15:11:28 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60639 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932382AbVHKTL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 15:11:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811191122.ZIND15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 15:11:22 -0400
To: Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 11 Aug 2005 09:30:03 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 10 Aug 2005, Sebastian Kuzminsky wrote:
>> 
>> People still use GNU Interactive Tools.  Not just crazy, stupid people,
>> and I bet not just Debian people.
>
> Why do you say that?
>
> Do you have anybody who actually does, or are you just claiming so?

Debian folks have a handy way to substantiate that claim or get
that claim proven wrong, and I am somewhat surprised that nobody
mentioned it so far.

Debian popularity contest (http://popcon.debian.org/).

Here is an excerpt I just made.

    <name> is the package name;
    <inst> is the number of people who installed this package;
    <vote> is the number of people who use this package regularly;
    <old>  is the number of people who installed, but don't use
          this package regularly;
    <recent> is the number of people who upgraded this package recently;

    rank  name            inst    vote     old recent
    1     base-files      7147    6777     158    212
    2     base-passwd     7147    6724     163    260
    3     debianutils     7147    6739     120    288
    4     sed             7147    6763     155    229
    ...                                                                    
    6591  git              114      24      83      7
    ...                                                                    
    25555 git-core           2       1       0      1 (Not in sid)
    29939 cogito-scm         1       0       1      0 (Not in sid)
    ...                                                                    
    46416 zope2.6            0       0       0      0
    -------------------------------------------------
    46416 Total        6768849 2118048 2306009 595621

So yes, among 46.5K packages in the known universe, the other
git ranks 6600th.  Does that mean it is popular?  I dunno.

Obviously, not everybody who installs Debian participates in
popcon.  The sample size of the above statistics is 7147
installations of base-files.

Among these 7147 sample installations, the other git was
installed by 114 people, and 24 people regularly use it.
