From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-repack to optionally run git-prune-packed.
Date: Thu, 09 Mar 2006 10:50:43 -0800
Message-ID: <7vy7zj4flo.fsf@assigned-by-dhcp.cox.net>
References: <11417445722524-git-send-email-matlads@dsmagic.com>
	<20060307212918.GA9474@steel.home>
	<20060309102419.GA9961@igloo.ds.co.ug>
	<81b0412b0603090648w4a3e4e4bwceb0ad19a2a4d15f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 09 19:51:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHQDr-0002hR-7V
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 19:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWCISuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 13:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCISuq
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 13:50:46 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62147 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751323AbWCISup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 13:50:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309184752.MWOI17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 13:47:52 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17435>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 3/9/06, Martin Atukunda <matlads@dsmagic.com> wrote:
>> Your suggestion has merit, though it's different from the behaviour I
>> desired. I _sometimes_ need the pruning, and it felt appropriate to make
>> it an option as opposed to default behaviour.
>>
>> What do you think?
>
> I think that my patch didn't change the default. git-prune-packed is called
> only if -d is given, which is not the default.

I am inclined to say I prefer Alex' one.
