From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Tue, 22 Nov 2005 01:50:01 -0800
Message-ID: <7vfyppf1va.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	<cda58cb80511170236p4a7e2baay@mail.gmail.com>
	<Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
	<cda58cb80511171347yef4f090g@mail.gmail.com>
	<Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	<cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	<Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
	<7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80511211211l2ff6ff12j@mail.gmail.com>
	<7vhda5pw6l.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80511220122r76ca69a2y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 10:51:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeUmv-0002mG-Da
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 10:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVKVJuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 04:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVKVJuF
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 04:50:05 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9954 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964859AbVKVJuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 04:50:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122095004.VPYM25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 04:50:04 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511220122r76ca69a2y@mail.gmail.com>
	(vagabon.xyz@gmail.com's message of "Tue, 22 Nov 2005 10:22:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12541>

Franck <vagabon.xyz@gmail.com> writes:

> 2005/11/21, Junio C Hamano <junkio@cox.net>:
>> Franck <vagabon.xyz@gmail.com> writes:
>>
>> > ... But since I used grafting to "cut"
>> > my light repo and .git/info/grafts file is not copied during
>> > push/pull/clone operations it's not going to work. Is it a scheme that
>> > could work ?
>>
>> If you tell your downloaders that your repository is incomplete
>> and they need to have at least up to such and such commits from
>> another repository, they should be able to slurp from you.

I was not talking about _your_ case specifically.  If you happen
to have based your partial history on top of a single commit
then the set of "such and such commits" might be only one, but
you could for example clone from Linus tip, merge in a couple of
jgarzik branch heads, put your own commits on top of them and
then cauterize your history, stopping at those foreign commits.
In such a case you obviously need to tell others where you
chopped your history off.
