From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Thu, 12 Jan 2006 16:10:51 +0000
Message-ID: <tnxirspo29g.fsf@arm.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
	<20060108230611.GP3774@stusta.de>
	<Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
	<20060110201909.GB3911@stusta.de> <20060112013706.GA3339@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>,
	"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Thu Jan 12 17:16:43 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex57k-0001C3-0o
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Thu, 12 Jan 2006 17:16:28 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1030461AbWALQQW (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Thu, 12 Jan 2006 11:16:22 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1030459AbWALQQW
	(ORCPT <rfc822;linux-acpi-outgoing>);
	Thu, 12 Jan 2006 11:16:22 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:24765 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1030458AbWALQQT (ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Thu, 12 Jan 2006 11:16:19 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k0CGAw6s003968;
	Thu, 12 Jan 2006 16:10:59 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 12 Jan 2006 16:10:58 +0000
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20060112013706.GA3339-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> (Greg KH's message of "Wed,
 11 Jan 2006 17:37:06 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 12 Jan 2006 16:10:58.0494 (UTC) FILETIME=[C63935E0:01C61792]
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
>> 
>> I am using the workaround of carrying the patches in a mail folder, 
>> applying them in a batch, and not pulling from your tree between 
>> applying a batch of patches and you pulling from my tree.
>
> Ick, I'd strongly recommend using quilt for this.  It works great for
> just this kind of workflow.

Or StGIT :-). Similar workflow (and similar commands) but better
integrated with GIT and better at dealing with conflicts since it uses
a three-way merge when pushing patches rather than applying them with
"patch".

-- 
Catalin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
