From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: HELP: GIT Cloning failed
Date: Tue, 22 Aug 2006 17:08:09 -0400
Message-ID: <44EB7239.50105@cfl.rr.com>
References: <890BF3111FB9484E9526987D912B261932E35B@NAMAIL3.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Patro, Sumant" <Sumant.Patro@engenio.com>,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 23:08:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFdU5-0004SG-Gg
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 23:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWHVVI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 17:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWHVVI0
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 17:08:26 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:35107 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750726AbWHVVIZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 17:08:25 -0400
Received: from [10.1.1.235] ([10.1.1.235]) by iradimed.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Aug 2006 17:08:28 -0400
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261932E35B@NAMAIL3.ad.lsil.com>
X-OriginalArrivalTime: 22 Aug 2006 21:08:28.0027 (UTC) FILETIME=[1D144CB0:01C6C62F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14646.000
X-TM-AS-Result: No--34.471200-5.000000-2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25873>

Is there a reason that you regularly delete and re-download the entire 
repository, rather than simply doing a git pull to update your existing 
clone?

Ju, Seokmann wrote:
> Hi,
> 
> Recently, I found that cloning from GIT server has been failed.
> I'm using following script for it.
> ---
> ...
> rm -r /home/git/kernels/2.4/linux-2.4.git
> cg-clone
> http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/
> /home/git/kernels/2.4/linux-2.4.git/
> sync
> rm -r /home/git/kernels/2.4/linux-2.6.git
> cg-clone
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> /home/git/kernels/2.4/linux-2.6.git/
> sync
> rm -r /home/git/kernels/2.4/scsi-misc-2.6.git
> cg-clone
> http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/scsi-misc-2.6.git
> /home/git/kernels/2.4/scsi-misc-2.6.git
> sync
> ...
> ---
> 
> In the script, I'm cloning 3 different sources. First two sources
> getting successfully cloned, however, last one is getting failed with
> following error messages,
> ---
> Fetching head...
> Fetching objects...
> Getting alternates list for
> http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
> Also look at http://www.kernel.or
> Error: The requested URL returned error: 502 (curl_result = 22,
> http_code = 502, sha1 = 1039f0760e...)
> Getting pack list for
> http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git/
> Getting pack list for http://www.kernel.or
> Error: The requested URL returned error: 502
> Error: Unable to find 27fd37621... Under
> http://www.kernel.org/pub/scsm/linux/kernel/git/jejb/scsi-misc-2.6.git/
> Cannot obtain needed blob 27fd37621...
> While processing commit 4041b9cd87...
> Progress: 8 objects, 13120 bytes
> Cg-fetch: objects fetch failed
> ---
> 
> Above script worked without any problem when I started several months
> ago and I'm not sure when did it stop working.
> I'm using _cron_ utility on my Linux box for scheduled execution of the
> script.
> 
> Any comment would be appreciated.
> 
> Thank you,
> 
> Seokmann
