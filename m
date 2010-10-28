From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: git merge-tree segfault
Date: Fri, 29 Oct 2010 06:25:31 +1000
Message-ID: <SNT124-w295B9D20AA43A06DEFD13BC4440@phx.gbl>
References: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <klas.lindberg@gmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 28 22:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBZ8W-0004Vr-6f
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 22:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933741Ab0J1Ubm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 16:31:42 -0400
Received: from snt0-omc1-s33.snt0.hotmail.com ([65.55.90.44]:56124 "EHLO
	snt0-omc1-s33.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933685Ab0J1Ubm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 16:31:42 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2010 16:31:42 EDT
Received: from SNT124-W29 ([65.55.90.8]) by snt0-omc1-s33.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 28 Oct 2010 13:25:32 -0700
X-Originating-IP: [60.241.190.75]
Importance: Normal
In-Reply-To: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
X-OriginalArrivalTime: 28 Oct 2010 20:25:32.0068 (UTC) FILETIME=[44E22640:01CB76DE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160221>


> Date: Thu, 28 Oct 2010 22:16:03 +0200
> Subject: git merge-tree segfault
> From: klas.lindberg@gmail.com
> To: git@vger.kernel.org
>
> I haven't tried this on newer versions of git, but the release notes
> for later releases don't mention merge-tree anywhere, so...
>
> git version: 1.7.0
> uname -a: Linux tor 2.6.32-trunk-amd64 #1 SMP Sun Jan 10 22:40:40 UTC
> 2010 x86_64 GNU/Linux
> distro: Debian GNU/Linux squeeze/sid
>
> Unpack the attached tree, cd into it and run:
> git merge-tree common master other
>
> I get the following result:
> added in local
> our 100644 d68dd4031d2ad5b7a3829ad7df6635e27a7daa22 t1.txt
> Segmentation fault
>
> The exit code:
> 139
>
> BR / Klas


Confirm this bug with arbitrary repository and arbitrary revs.

git version: 1.7.1
uname -a: Linux Imperial-SSD-Overlord 2.6.35-trunk-amd64 #1 SMP
Tue Aug 17 08:22:25 UTC 2010 x86_64 GNU/Linux
distro: Debian GNU/Linux unstable/experimental

Same exit code; 139.

Regards,
Tim.

 		 	   		  