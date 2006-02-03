From: "Brown, Len" <len.brown@intel.com>
Subject: RE: The merge from hell...
Date: Fri, 3 Feb 2006 13:34:35 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005F34393@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Marco Costalba" <mcostalba@yahoo.it>,
	"Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 19:35:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F55lt-0005AB-PP
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 19:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWBCSe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 13:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWBCSe5
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 13:34:57 -0500
Received: from fmr23.intel.com ([143.183.121.15]:16550 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030193AbWBCSe4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 13:34:56 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k13IYbux008452;
	Fri, 3 Feb 2006 18:34:37 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k13ITv1x004244;
	Fri, 3 Feb 2006 18:30:03 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006020310343708047
 ; Fri, 03 Feb 2006 10:34:37 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 3 Feb 2006 10:34:37 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 3 Feb 2006 10:34:36 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The merge from hell...
Thread-Index: AcYo3e8rWsxh9j/FSIq2l6u5u4KA9AAEehVA
To: "Dave Jones" <davej@redhat.com>, "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 03 Feb 2006 18:34:36.0685 (UTC) FILETIME=[7C274BD0:01C628F0]
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15540>

>On Thu, Feb 02, 2006 at 10:28:43PM -0800, Junio C Hamano wrote:
>
> > > One thing I'd ask for: would it be possible to have more 
>descriptive 
> > > branch names than just numbers? Even if you want to track 
>it by bugzilla 
> > > entry number, how about calling it "bugzilla-12345" instead? 
> > 
> > When kernel people (not just Len) talk about a "bugzilla ID",
> > does that ID always come from the same namespace, or do some
> > subsystems have their own bugzilla?
>
>Not only do some subsystems have their own bugtracker (ALSA for eg),
>but referring to 'bugzilla' alone is meaningless, as it could
>mean bugme.osdl.org, bugzilla.redhat.com, bugzilla.novell.com,
>bugzilla.ubuntu.com etc etc, all of which are a prime source of
>juicy kernel bugs.

Naming the branch is just eye-candy for the merge comment.
My topic branch labels in refs/my-branch never get to kernel.org, so you're
not going to see the pretty green tags on topic branches branches that I see.

I include the full-URL of the bug report in the original commit comments
for those who are interested.  I think this it the important place to put it,
and in practice I've found it to be extremely useful.

-Len
