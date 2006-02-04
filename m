From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Fri, 3 Feb 2006 18:47:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602031841320.3969@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005F34393@hdsmsx401.amr.corp.intel.com>
 <7vy80r97h6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Dave Jones <davej@redhat.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 03:47:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5DSj-0001hh-6e
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 03:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946267AbWBDCrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 21:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946269AbWBDCrd
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 21:47:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946267AbWBDCrd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 21:47:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k142l9DZ026801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Feb 2006 18:47:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k142l8dQ010295;
	Fri, 3 Feb 2006 18:47:08 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy80r97h6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15565>



On Fri, 3 Feb 2006, Junio C Hamano wrote:
> 
> It might make sense if we have a tool support to pre-format the
> merge messages like this, given set of branch names:
> 
>     [ACPI] Merge 3549, 4320, 4485, 4588, 4980, 5483, 5651, acpica, asus, fops and pnpacpi branches into release
> 
>     3549: [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops
>     4320: [ACPI] fix reboot upon suspend-to-disk
>     4485: [ACPI] handle BIOS with implicit C1 in _CST
..

Well, this is actually not all that different from what gitk will show you 
(since I added the commit "explanation" names with my increadible 
copy-paste skills to it).

Just look in the details window in gitk on that merge, and that's pretty 
much exactly what you'll see, except you'll also have the nice clickable 
hyperlink features ;)

Yeah, it doesn't show the branch names _and_ it shows the commit that you 
merged into too, so it looks like

  Parent: 3ee68.. ([SPARC64]: Use compat_sys_futimesat in 32-bit syscall table.)
  Parent: 876c1.. ([ACPI] Disable C2/C3 for _all_ IBM R40e Laptops)
  Parent: 729b4.. ([ACPI] fix reboot upon suspend-to-disk)
  Parent: cf824.. ([ACPI] handle BIOS with implicit C1 in _CST)

but it's actually pretty readable there.

		Linus
