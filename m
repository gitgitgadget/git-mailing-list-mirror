From: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 19:38:07 +1300
Message-ID: <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
	 <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
	"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>,
	Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	LKML Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>,
	Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Tue Jan 10 07:38:14 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwD93-0007WK-JW
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Tue, 10 Jan 2006 07:38:13 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932078AbWAJGiM (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Tue, 10 Jan 2006 01:38:12 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S932083AbWAJGiM
	(ORCPT <rfc822;linux-acpi-outgoing>);
	Tue, 10 Jan 2006 01:38:12 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:54585 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932078AbWAJGiK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Tue, 10 Jan 2006 01:38:10 -0500
Received: by wproxy.gmail.com with SMTP id i22so3472162wra
        for <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Mon, 09 Jan 2006 22:38:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lnVgYZ52hxhgH2ZrKRq3Xtkw4GNh/mfc39/L/K1ViQ0gCa7+cATWFdVSXsLdbVrh15au2zMUN/ylfhfLAQJBUDJ5ldJnC+4nE2SyrXxnkok7NvUrztJz2ITYdGmUKUPIAv2SSUvF60MxBDLdOyrU3xIYGQWXnvpOvRNPUteyrr4=
Received: by 10.54.92.7 with SMTP id p7mr9153719wrb;
        Mon, 09 Jan 2006 22:38:07 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 9 Jan 2006 22:38:07 -0800 (PST)
To: Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org>
In-Reply-To: <99D82C29-4F19-4DD3-A961-698C3FC0631D-ee4meeAH724@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 1/10/06, Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org> wrote:
> If they all work, then we know precisely that it's the
> interactions between them, which also makes debugging a lot easier.

The more complex your tree structure is, the more the interactions are
likely to be part of the problem. Is git-bisect not useful in this
scenario?

cheers,


martin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
