From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 13:28:50 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <torvalds-3NddpPZAyC0@public.gmane.org>, <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <akpm-3NddpPZAyC0@public.gmane.org>,
	<git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Sun Jan 08 19:29:46 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvfIY-0004dK-0R
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Sun, 08 Jan 2006 19:29:46 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932746AbWAHS3o (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Sun, 8 Jan 2006 13:29:44 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S932741AbWAHS3o
	(ORCPT <rfc822;linux-acpi-outgoing>); Sun, 8 Jan 2006 13:29:44 -0500
Received: from fmr15.intel.com ([192.55.52.69]:3767 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S932444AbWAHS3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Sun, 8 Jan 2006 13:29:42 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr005.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k08ISqjF010398;
	Sun, 8 Jan 2006 18:28:52 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k08ISq3J026338;
	Sun, 8 Jan 2006 18:28:52 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006010810285219156
 ; Sun, 08 Jan 2006 10:28:52 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 10:28:52 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 10:28:52 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUK/UNNsAUD0mMS+Kj7v2U+S08rgAUVQ5w
To: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
X-OriginalArrivalTime: 08 Jan 2006 18:28:52.0097 (UTC) FILETIME=[6005D710:01C61481]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

 
>I know a lot of people react to this kind of usage with "what's the
>point of the source control system if you're just messing with patches
>in and out of the tree all the time" But as a subsystem maintainer,
>you deal with a lot of changes and it's important to get a pristine
>clean history when you push things to Linus.
>
>In fact, I do this so much that Linus's tree HEAD often equals my
>origin when he pulls.
>
>Merges really suck and I also hate it when the tree gets cluttered
>up with them, and Linus is right, ACPI is the worst offender here.
>
>Yes, we can grep the merges out of the shortlog or whatever, but that
>merging crap is still physically in the tree.
>
>Just don't do it.  Merge into a private branch for testing if you
>don't want to rebuild trees like I do, but push the clean tree to
>Linus.

Perhaps the tools should try to support what "a lot of people"
expect, rather than making "a lot of people" do extra work
because of the tools?

Call me old fashioned, but I believe that tools are supposed to
make work easier, not harder.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
