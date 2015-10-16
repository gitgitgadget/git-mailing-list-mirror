From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [BUG] t7063-status-untracked-cache flaky?
Date: Fri, 16 Oct 2015 17:22:01 +0200
Message-ID: <56211619.3090907@web.de>
References: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, dturner@twopensource.com
To: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 17:42:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn79N-0004ie-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 17:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbbJPPmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 11:42:31 -0400
Received: from mout.web.de ([212.227.17.12]:62911 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455AbbJPPWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 11:22:10 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LwqJw-1abwGd3OFE-016QCm; Fri, 16 Oct 2015 17:22:07
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
X-Provags-ID: V03:K0:3tcMlYXnx9qti16IKUmu2pQFZuAPO6Vfe5l89schTam6AZ2uF2S
 3IgT0t+gtASP3ZZOMYSXJeozgShiVV1Dc6+SN+mKlx6TZBjv6J7h52cZ1AYOyjZssV3X/CM
 1N160axmVwn0k7z8MbVKBucmb+sYp4Nl6Q0cR/MvwAn+46G/GTu/+Qxs/fYyg9RCK2S+lQK
 2gMDr+XFMKDis2XWk5AoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TfJ4rOofoD0=:L6r+Sdr2Dt9jPSuGNXMzmW
 NwyVdYgUgw2l0xCavkZdE8euGWZ3O8KteCEbMZd5dodcr9wdRcS7V9zxglkLAcFs+skw0kmLe
 9bgKm+QEi0hGNeUvJepBdW5I0o8o3imcxWAxodMCc9BYFEH7sXFaD+5PCL5wwzhSs62q2qv/y
 71s3/0+WrFEOu5x7E4CgrVepsu6XRc2+AczAYoRpYKbbDGnb3Mi6tJDIMQYpuGshCgo0idcak
 dgSuHgSitjuq2GvG/AYZB6xnDpYhF5PeH1sNJOOIZG/0vtJEJRSVQy/fJNUKv+IVwp4wKDRG9
 H6xEi+4+4yy5yGT3BakNDlCd7f5cubX1ABw/vYcpbpWMBx6gh6LaEzh1cjXi2ex4tnnDje8QP
 FrhcwDbRMbet+ojgC2xiRQyot10l9I9dlsMmWtKB2fwytGoSza+Nc3YbZT2xvMWPFlJ4O8Jr1
 DfrHvbzLVN16ygnBHBZp/w8ofiF4+wruOu95qfCaZvmVHHv8jCJj1vY5pjSZLhrXRA6cbWiw0
 rOg586ePgqKxX6IkgwpeVzQ1UHmuOzAkadoVi8K2FwdBr03YjhbjoyCmAsMb8it0N6u8I2m14
 fICe9Lt+0dvNQEk7c/gicSKdSNVxrEaW25j9aOyFGzxCz0PAbebJ+PTv4NKmZq5P9+MBd+J/a
 vLB5TJysHlipjlWwRcceNmIsxaJarddn6yu+2Sy2lwRLduh4sy9tJjCup4iLG4/0TG6fIm302
 UOYoNjAvIufaf9lZBGEv3cMG6ZrLIGIVyN3AoWdR0Rv7P7RPY9U46DIQmYj6yy/McHok6pVe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279747>

I can't reproduce it here.
Do you want to give us some info about your setup ?
OS ?
Harddisk, SSD, Fusion ?
Does "debug=t verbose=t ./t7063-status-untracked-cache.sh >xx.txt 2>&1" 
give any more information ?


On 15.10.15 09:52, Lars Schneider wrote:
> Hi,
> 
> I noticed that "t7063-status-untracked-cache.sh" occasionally fails with "not ok 24 - test sparse status with untracked cache".
