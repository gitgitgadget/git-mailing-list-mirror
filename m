From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Git exhausts memory.
Date: Tue, 05 Apr 2011 18:48:18 +0200
Message-ID: <4D9B47D2.6050909@ira.uka.de>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com> <alpine.LFD.2.00.1104021103130.28032@xanadu.home> <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com> <alpine.LFD.2.00.1104031110150.28032@xanadu.home> <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com> <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q79eu-00033r-QH
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab1DERDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 13:03:12 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39798 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755364Ab1DERDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 13:03:09 -0400
X-Greylist: delayed 967 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 13:03:09 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Q79P4-0007DY-Pk; Tue, 05 Apr 2011 18:46:59 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Q79P3-0000ui-KO; Tue, 05 Apr 2011 18:46:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1302022020.041153000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1302022988.260337000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170889>

On 04.04.2011 16:57, Nguyen Thai Ngoc Duy wrote:
> On Mon, Apr 4, 2011 at 7:52 PM, Alif Wahid<alif.wahid@gmail.com>  wrote:
>> Hi Nicolas,
>>
>> On 4 April 2011 01:18, Nicolas Pitre<nico@fluxnic.net>  wrote:
>>>
>>> Something you can try is to simply tell Git not to attempt any delta
>>> compression on those tar files using gitattributes (see the man page of
>>> the same name).
>
> Should we change the default to not delta if a blob exceeds predefined
> limit (say 128M)? People who deliberately wants to delta them can
> still set delta attr. 1.8.0 material maybe?


Isn't this already done with the config variable core.bigFileThreshold ?

documentation says: "Files larger than this size are stored deflated, 
without attempting delta compression. ... Default is 512 MiB on all 
platforms."
