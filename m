From: "Brown, Len" <len.brown@intel.com>
Subject: using-topic-branches.txt
Date: Sun, 18 Dec 2005 23:13:28 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 05:15:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoCPK-0004vY-4I
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 05:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVLSENm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 23:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVLSENm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 23:13:42 -0500
Received: from fmr16.intel.com ([192.55.52.70]:30620 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751322AbVLSENl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 23:13:41 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr006.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBJ4DWaO002447;
	Mon, 19 Dec 2005 04:13:33 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBJ4CmMa020653;
	Mon, 19 Dec 2005 04:13:32 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121820133219344
 ; Sun, 18 Dec 2005 20:13:32 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 18 Dec 2005 20:13:32 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 18 Dec 2005 20:13:32 -0800
Content-class: urn:content-classes:message
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: using-topic-branches.txt
Thread-Index: AcYDoeIN3bFY9I9EQGG6ZBRT3rsfjgAsA5uw
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 19 Dec 2005 04:13:32.0048 (UTC) FILETIME=[92A0D100:01C60452]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13810>

> file:4698abe46bff0b878dcfcd05771f5760483b4278 -> file:494429738f8f86bbe21f38b5f90cc94344ad0630
> --- a/Documentation/howto/using-topic-branches.txt
> +++ b/Documentation/howto/using-topic-branches.txt
> @@ -31,7 +31,7 @@ test tree and then pull to the release t
> patches blocked in the test tree waiting for complex changes to accumulate
> enough test time to graduate.
> -Back in the BitKeeper days I achieved this my creating small forests of
> +Back in the BitKeeper days I achieved this by creating small forests of
> temporary trees, one tree for each logical grouping of patches, and then
> pulling changes from these trees first to the test tree, and then to the
> release tree. At first I replicated this in GIT, but then I realised
> @@ -42,7 +42,8 @@ So here is the step-by-step guide how th
> First create your work tree by cloning Linus's public tree:
> - $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
> + $ git clone \
> + master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
> Change directory into the cloned tree you just created
> @@ -52,7 +53,7 @@ Set up a remotes file so that you can fe
> branch into a local branch named "linus":
> $ cat > .git/remotes/linus
> - URL: rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> + URL: master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Pull: master:linus
> ^D

This works for me, but now it requires a password to update
when before it did not.

-Len
