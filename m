From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: [PATCH] Fix git.c compilation target
Date: Tue, 22 Nov 2005 00:08:27 -0800
Message-ID: <7v1x19gl50.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511210010m66a3f898q6d108a799de023d9@mail.gmail.com>
	<81b0412b0511210124u5cc0d4efv2045123d92872c66@mail.gmail.com>
	<7vlkzhmwq4.fsf@assigned-by-dhcp.cox.net> <43825BCF.8040402@op5.se>
	<81b0412b0511212347n6f478824i7ad0ffdaa78285f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 09:10:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeTCd-0007Ra-Ay
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 09:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVKVII3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 03:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVKVII3
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 03:08:29 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12530 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964891AbVKVII2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 03:08:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122080716.OHWN17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 03:07:16 -0500
To: Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>
In-Reply-To: <81b0412b0511212347n6f478824i7ad0ffdaa78285f3@mail.gmail.com>
	(Alex Riesen's message of "Tue, 22 Nov 2005 08:47:50 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12535>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 11/22/05, Andreas Ericsson <ae@op5.se> wrote:
>> >  - make git$(X) part of PROGRAMS (probably it is a
>> >    SIMPLE_PROGRAM that does not link with many extra stuff, or a
>> >    class on its own);
>> >
>> >  - have "install" target depend on "all".
>> >
>>
>> Something like this?
>>
>> ##########
>> Introduce $(ALL_PROGRAMS) for 'all:' and 'install:' to operate on.
>
> Yes, that's what I _actually_ mean :)

Thanks, both.  Applied with minor clean-ups for the "clean"
target on top (forgot to remove SIMPLE_PROGRAM), and will push
out.
