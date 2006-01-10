From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 12:31:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101229390.4939@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de>
 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Tue Jan 10 21:36:45 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQEL-0002zV-QV
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Tue, 10 Jan 2006 21:36:34 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932618AbWAJUgc (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Tue, 10 Jan 2006 15:36:32 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S932617AbWAJUgc
	(ORCPT <rfc822;linux-acpi-outgoing>);
	Tue, 10 Jan 2006 15:36:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932597AbWAJUga (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Tue, 10 Jan 2006 15:36:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AKVNDZ031689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 12:31:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AKVIiA013314;
	Tue, 10 Jan 2006 12:31:20 -0800
To: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
In-Reply-To: <20060110201909.GB3911-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Tue, 10 Jan 2006, Adrian Bunk wrote:
> 
> > Now, in this model, you're not really using git as a distributed system. 
> > In this model, you're using git to track somebody elses tree, and track a 
> > few patches on top of it, and then "git rebase" is a way to move the base 
> > that you're tracking your patches against forwards..
> 
> I am using the workaround of carrying the patches in a mail folder, 
> applying them in a batch, and not pulling from your tree between 
> applying a batch of patches and you pulling from my tree.

Yes, that also works.

I think "quilt" is really the right thing here, although stg may be even 
easier due to the more direct git integration. But with a smallish number 
of patches, just doing patch management by hand is obviously simply not a 
huge problem either, so extra tools may just end up confusing the issue.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
