From: "Brown, Len" <len.brown@intel.com>
Subject: RE: The merge from hell...
Date: Fri, 3 Feb 2006 01:04:20 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE838@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Marco Costalba" <mcostalba@yahoo.it>,
	"Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 07:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4u41-0005aW-EC
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 07:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWBCGEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 01:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWBCGEh
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 01:04:37 -0500
Received: from fmr23.intel.com ([143.183.121.15]:28823 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932196AbWBCGEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 01:04:36 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k1364Oux006043;
	Fri, 3 Feb 2006 06:04:24 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k12NFkoq007011;
	Thu, 2 Feb 2006 23:15:46 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006020222042309547
 ; Thu, 02 Feb 2006 22:04:23 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 2 Feb 2006 22:04:23 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 2 Feb 2006 22:04:23 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The merge from hell...
Thread-Index: AcYohSgB7OzB5y0tQ5+6+2fduBieWwAACsmg
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 03 Feb 2006 06:04:23.0382 (UTC) FILETIME=[AE225760:01C62887]
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15528>

>The 12-way merge was a bit over the top, but it worked. I'd 
>suggest not being quite _that_ aggressive in the future,
>though, but it's not a big deal.

I favor "assertive" over "aggressive" --
I assert that the tools I use must work as advertised;-)

> #define MAXPARENT (16)

How about setting this #define to the number
that you're comfortable with?  Then folks like me --
who wouldn't dream of checking code into Linux with a hopped-up git --
will simply obey the limit that comes with the tool?

>One thing I'd ask for: would it be possible to have more descriptive 
>branch names than just numbers? Even if you want to track it 
>by bugzilla entry number, how about calling it "bugzilla-12345" instead? 

bugzilla-#### -- no problem -- will do.

thanks,
-Len

ps. 
In the back of my head I was worried about using plain
numbers when I saw somebody refer to "shorthand SHA1".
Hopefully this is an idle worry and it is not possible
for the tool to confuse a numeric branch name with a SHA1 id.
