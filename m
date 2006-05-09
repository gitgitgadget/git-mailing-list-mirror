From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 09 May 2006 00:15:29 -0700
Message-ID: <7vlktb8y9a.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	<1147131877.2694.37.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	<4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
	<Pine.LNX.4.64.0605081805290.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 09 09:15:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdMRT-00081Q-QP
	for gcvg-git@gmane.org; Tue, 09 May 2006 09:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWEIHPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 03:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWEIHPc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 03:15:32 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42149 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751441AbWEIHPb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 03:15:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509071530.WWVS27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 03:15:30 -0400
To: Bertrand Jacquin <beber.mailing@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0605081805290.3718@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 8 May 2006 18:18:17 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19825>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 9 May 2006, Bertrand Jacquin wrote:
>
>> On 5/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> > 
>> > Ie you could probably more easily parse the data from something like
>> > 
>> >         git show -B --patch-with-stat --pretty=fuller $commit
>> 
>> Is there a way to track merge like that ? Documentation is not very
>> clear and near from empty.
>
> Sure.
>
> If you want to track merges and get their patches, add the "--cc" flag, 
> which tells git to use the "conflict combination patch" that shows any 
> visible conflicts.

Actually, show defaults to --cc so what's shown is good as is.

> That said, the diffstat for merges is usually just a lot of noise. It's 
> sometimes nice (you've merged from a topic branch), but if you have merged 
> from the mainline _into_ a topic branch, it's just annoying.

True.  We made --cc --patch-with-stat to do the combined patch
text with diffstat for first-parent-diff to make it most natural
for merging into upstream, not merging from upstream.
