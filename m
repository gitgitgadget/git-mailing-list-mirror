From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible --remove-empty bug
Date: Fri, 17 Mar 2006 22:40:12 -0800
Message-ID: <7vbqw4z25v.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
	<7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603121450210.3618@g5.osdl.org>
	<7vlkvfw3px.fsf@assigned-by-dhcp.cox.net>
	<7v4q22ucio.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603131058270.3618@g5.osdl.org>
	<e5bfff550603170257u21ee6583jabe5a6409cc40766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Mar 18 07:40:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKV6r-0006NF-PV
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 07:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWCRGkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 01:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWCRGkR
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 01:40:17 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:65190 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751290AbWCRGkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 01:40:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318063714.REAE17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 01:37:14 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603170257u21ee6583jabe5a6409cc40766@mail.gmail.com>
	(Marco Costalba's message of "Fri, 17 Mar 2006 11:57:38 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17686>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 3/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
>>
>> However, to be honest, the only reason to ever use --remove-empty is for
>> rename detection, and Frederik's approach of doing that through the
>> library interface directly is actually a much superior option. So we might
>> as well drop the compilcation of --remove-empty entirely, unless somebody
>> has already started using it.
>
> In case of a rather recent file --remove-empty option gives a good
> speed up in history loading with git-rev-list. So qgit uses that
> option.

So you _do_ use it, and I think I still have that remove-empty
stuff held back in "next" branch.  Should I unleash it?
