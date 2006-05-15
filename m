From: "Brown, Len" <len.brown@intel.com>
Subject: RE: how to display file history?
Date: Mon, 15 May 2006 15:04:39 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670FD1B@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 15 21:16:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfiXb-0000Ed-RV
	for gcvg-git@gmane.org; Mon, 15 May 2006 21:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWEOTPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 15:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWEOTPd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 15:15:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:23118 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965195AbWEOTPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 15:15:31 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101-1.jf.intel.com with ESMTP; 15 May 2006 12:08:24 -0700
Received: from fmsmsx332.fm.intel.com (HELO fmsmsx332.amr.corp.intel.com) ([132.233.42.148])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2006 12:04:52 -0700
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="36566177:sNHT2685766216"
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 May 2006 12:04:43 -0700
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 May 2006 12:04:42 -0700
Received: from hdsmsx411.amr.corp.intel.com ([10.127.2.70]) by hdsmsx401.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 15 May 2006 15:04:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to display file history?
Thread-Index: AcZ4Sz23zQaIu+PRTkWTFAbyP2GCKQABAcEw
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 15 May 2006 19:04:41.0105 (UTC) FILETIME=[6B64B010:01C67852]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20079>

 
>> >	git log --stat -- A
>> 
>> very handy indeed.
>> 
>> I was surprised on initial use that --stat is
>> limited to the file specified in "A" and doesn't
>> expand to describe the entire commit that touches "A".
>> (ie. the stat output is a subset of what is associated
>> with the displayed commit comments).
>> 
>> This, of course, is clear now, it just isn't what
>> I expected on first use.
>
>Well,  you can obviously have your cake and eat it too (ie 
>"--full-diff").
>
>I don't often end up using the "--full-diff" thing. It's almost never 
>actually worth it until I find the diff that I actually start caring 
>about, and the full diff just makes it harder to see the part 
>I explicitly told git I was interested in.

sounds good.

>So the default "show only diffs for the files asked for" 
>behaviour is in my opinion much superior (and it used to be the only
one),
>because the "show the whole thing" part ends up being something you use
only once 
>you've already skimmed the default case and decide to go deeper.

I agree.

>Of course, "gitk" ends up using the full diff by default in its diff 
>window. I'm not convinced that's the right thing, but usually 
>when I use gitk I'm primarily looking at the history and the commit
>messages to decide if it's a relevant one, not the diff, so I don't
think 
>it matters.

Yeah, I agree that gitk is fine how it is.

The only part I don't agree with above is the word "obviously".
'--full-diff --stats' didn't jump out at me from the man page.

To be fair, yes, I should probably take the time to read the docs
through
and not rely on the man pages, they've changed a lot since I last
looked.

-Len
