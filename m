From: Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 11:33:49 -0800
Message-ID: <7vace61plu.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	<46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Sun Jan 08 20:33:59 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvgIf-0007J7-Ev
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Sun, 08 Jan 2006 20:33:58 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1161122AbWAHTdy (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Sun, 8 Jan 2006 14:33:54 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1161112AbWAHTdy
	(ORCPT <rfc822;linux-acpi-outgoing>); Sun, 8 Jan 2006 14:33:54 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4034 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161086AbWAHTdw (ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Sun, 8 Jan 2006 14:33:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060108193245.OWMF6244.fed1rmmtao11.cox.net-u5dp/1a/izZijMVVUgEtmwqrb7wDvxM8@public.gmane.org>;
          Sun, 8 Jan 2006 14:32:45 -0500
To: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <46a038f90601081119r39014fbi995cc8b6e95774da-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Martin Langhoff's message of "Mon, 9 Jan 2006 08:19:50 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On 1/9/06, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> Perhaps the tools should try to support what "a lot of people"
>> expect, rather than making "a lot of people" do extra work
>> because of the tools?
>
> I think it does. All the tricky stuff that David and Junio have been
> discussing is actually done very transparently by
>
>     git-rebase <upstream>
>
> Now, git-rebase uses git-format-patch <options> | git-am <options> so
> it sometimes has problems merging.

Careful.  I do not think rebase works across merges at all.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
