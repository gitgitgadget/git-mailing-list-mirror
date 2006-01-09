From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 01:27:19 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A136F6@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <akpm-3NddpPZAyC0@public.gmane.org>,
	<git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mon Jan 09 07:28:12 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvqVj-0000b4-ML
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Jan 2006 07:28:08 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932586AbWAIG2G (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Mon, 9 Jan 2006 01:28:06 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S932829AbWAIG2F
	(ORCPT <rfc822;linux-acpi-outgoing>); Mon, 9 Jan 2006 01:28:05 -0500
Received: from fmr14.intel.com ([192.55.52.68]:52610 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932822AbWAIG2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Mon, 9 Jan 2006 01:28:01 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k096ROpE019045;
	Mon, 9 Jan 2006 06:27:24 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k096RNtp030520;
	Mon, 9 Jan 2006 06:27:23 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006010822272305834
 ; Sun, 08 Jan 2006 22:27:23 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 22:27:23 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 22:27:22 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUk6Mh9JdutZnVRsiBZXyxSTyMBwAUHl0A
To: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, <torvalds-3NddpPZAyC0@public.gmane.org>
X-OriginalArrivalTime: 09 Jan 2006 06:27:22.0938 (UTC) FILETIME=[C01621A0:01C614E5]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


>From: David S. Miller

>I think merges with conflicts that need to get resolved by hand create
>a lot of noise and useless information and therefore to me they are
>pointless.  But this is just my opinion.  It simply works easier to me
>to shuffle the patches in by hand and deal with the rejects one by
>one.  It's very much akin to how Andrew's -mm tree works.

I guess in this model you can do all your development with quilt,
and the value of git is a high-bandwidth bransport medium to
replace e-mail.

>I think a clean history is worth an extra few minutes of someone's
>time.  And note that subsystem development is largely linear anyways.

Maybe true in your neck of the woods, but not true here.

I have more than a dozen topic branches in my tree, and they mature
at different rates.

When a topic branch is in the test tree and and a follow-up patch
is needed, I check out that topic branch and put the patch
exactly in non-linear 3D history where it is meant to live.
When the topic seems fully baked, I can pull the top of the
branch into the release tree.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
