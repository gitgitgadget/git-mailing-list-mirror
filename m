From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Subject: HELP: GIT Cloning failed
Date: Tue, 22 Aug 2006 13:25:23 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E35B@NAMAIL3.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Patro, Sumant" <Sumant.Patro@engenio.com>,
	<linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 22 21:25:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFbsP-00024j-JG
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 21:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWHVTZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 15:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHVTZZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 15:25:25 -0400
Received: from mail0.lsil.com ([147.145.40.20]:41126 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751190AbWHVTZY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 15:25:24 -0400
Received: from milmhbs0.lsil.com (mhbs.lsil.com [147.145.1.30])
	by mail0.lsil.com (8.12.8/8.12.8) with ESMTP id k7MJP6Xu025467;
	Tue, 22 Aug 2006 12:25:06 -0700 (PDT)
Received: from namail.ad.lsil.com (namail.co.lsil.com [172.21.36.18])
	by milmhbs0.lsil.com (8.12.11/8.12.11) with ESMTP id k7MIRPkc026153;
	Tue, 22 Aug 2006 11:27:25 -0700
Received: from NAMAIL3.ad.lsil.com ([172.21.36.22]) by namail.ad.lsil.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Aug 2006 13:25:23 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HELP: GIT Cloning failed
Thread-Index: AcbGILZ87Cy8vC1iTYieANrPv7RILA==
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 22 Aug 2006 19:25:23.0965 (UTC) FILETIME=[B71752D0:01C6C620]
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25867>

Hi,

Recently, I found that cloning from GIT server has been failed.
I'm using following script for it.
---
...
rm -r /home/git/kernels/2.4/linux-2.4.git
cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/
/home/git/kernels/2.4/linux-2.4.git/
sync
rm -r /home/git/kernels/2.4/linux-2.6.git
cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
/home/git/kernels/2.4/linux-2.6.git/
sync
rm -r /home/git/kernels/2.4/scsi-misc-2.6.git
cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/scsi-misc-2.6.git
/home/git/kernels/2.4/scsi-misc-2.6.git
sync
...
---

In the script, I'm cloning 3 different sources. First two sources
getting successfully cloned, however, last one is getting failed with
following error messages,
---
Fetching head...
Fetching objects...
Getting alternates list for
http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
Also look at http://www.kernel.or
Error: The requested URL returned error: 502 (curl_result = 22,
http_code = 502, sha1 = 1039f0760e...)
Getting pack list for
http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git/
Getting pack list for http://www.kernel.or
Error: The requested URL returned error: 502
Error: Unable to find 27fd37621... Under
http://www.kernel.org/pub/scsm/linux/kernel/git/jejb/scsi-misc-2.6.git/
Cannot obtain needed blob 27fd37621...
While processing commit 4041b9cd87...
Progress: 8 objects, 13120 bytes
Cg-fetch: objects fetch failed
---

Above script worked without any problem when I started several months
ago and I'm not sure when did it stop working.
I'm using _cron_ utility on my Linux box for scheduled execution of the
script.

Any comment would be appreciated.

Thank you,

Seokmann
