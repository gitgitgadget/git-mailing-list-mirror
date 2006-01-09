From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 01:13:17 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A136E9@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	<linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<akpm-3NddpPZAyC0@public.gmane.org>, <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mon Jan 09 07:14:52 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvqIp-0007DG-AF
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Jan 2006 07:14:47 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1751145AbWAIGOA (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Mon, 9 Jan 2006 01:14:00 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S932553AbWAIGOA
	(ORCPT <rfc822;linux-acpi-outgoing>); Mon, 9 Jan 2006 01:14:00 -0500
Received: from fmr14.intel.com ([192.55.52.68]:2690 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751118AbWAIGN5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Mon, 9 Jan 2006 01:13:57 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k096DKpE017938;
	Mon, 9 Jan 2006 06:13:20 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k096DJtp027052;
	Mon, 9 Jan 2006 06:13:19 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006010822131905060
 ; Sun, 08 Jan 2006 22:13:19 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 22:13:19 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 22:13:19 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUjkUHuM6k/ZrRQoKsmcAVWT9fQQAU6dzQ
To: "Linus Torvalds" <torvalds-3NddpPZAyC0@public.gmane.org>,
	"Martin Langhoff" <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-OriginalArrivalTime: 09 Jan 2006 06:13:19.0297 (UTC) FILETIME=[C93CBB10:01C614E3]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

 
>Which just means that a commit that was tested and found to be working 
>might suddenly not work any more, which can be very surprising ("But I 
>didn't change anything!").

This is why I try to follow the top of tree as closely as possible.
While parts of ACPI are well contained, other parts get stomped on constantly.
My two updates in 10 hours were not becaudse of what I did,
it was in response to seeing the flood gates in 2.6.16 open.

Also, it isn't accurate that nothing changed at my end.
I put some trivial patches into my release branch,
udpated the release branch with upstream,
and then pulled the release branch into my test branch
where there are other patches you haven't seen yet.

I pushed the release branch just to 'clear the deck' of
the trivial patches there since there was no reason to delay
them behind all the stuff still on the test branch.

>So trying out git-rebase and git-cherry-pick just in case you 
>decide to want to use them might be worthwhile. Making it part of your 
>daily routine like David has done? Somewhat questionable, but hey,
>it seems to be working for David, and it does make some things much easier, so..

In the past I have use git-cherry-pick to recover from when a "good" patch
was checked in on top of a "bad" patch, and I wanted to push
the good without the bad.

But the linearization model will not work for me in general.
Branches enable parallel lines of development in git.  If that
is thrown out, then we're basically back at quilt.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
