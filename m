From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [msysGit] Difficulties senting patches to Git list using msmpt
 (send-email)
Date: Mon, 3 Aug 2015 15:09:28 +0200
Message-ID: <55BF6808.1000500@web.de>
References: <25E3342F2D4A420D8A25A1B22B5266FE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Philip Oakley <philipoakley@iee.org>,
	Git MsysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 15:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMFUx-0006a8-5H
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 15:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbbHCNJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 09:09:42 -0400
Received: from mout.web.de ([212.227.17.12]:58977 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbbHCNJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 09:09:39 -0400
Received: from birne.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Lu4uA-1YuF5s0VIE-011QYE; Mon, 03 Aug 2015 15:09:34
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <25E3342F2D4A420D8A25A1B22B5266FE@PhilipOakley>
X-Provags-ID: V03:K0:Y2yZuQJk7VlefjL1UDB4SFt/1H5hGOBBoK28FjrI1EoxJ3Xc1cn
 x7nUEq03YYhSGbWw1RUAV6ZW9OtW+hQ6TXqBB9Ze38yY8ufK2XK9kFWov5xNhQE0MlhgJVK
 /Etj8g2+Qqu5VjSKmPmpU2JfRy2FZhi+tMk1Z8vD7WN7MyzrZC7eqjCG30mtafa5S11ZXZS
 3o1xAH/NQkNczOfmbnpoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rNU3D/evJXo=:YVEEet1WNmLcYo4JM1E5Aw
 gskLSHemKY9Nzs/QBgorQ1wlP69MKRZpJp2/c4jCAadyIn/1az83jKttDYZF+2hJ2nLLwujGw
 uLACOhbCouo7Wj9q+e/o3Q8OU/FEZr1UwHhw3f+ikRxE8ZyLfDRdT0phZ8VPSx5nWvLWYPDyW
 yHADQiZNwqRhsyJh6qQd5ZV+Kl+Hq4sMmI5HjqbMvhbeoTXq72k3J1my54UqCBHcAs2f2F3Qt
 oXIbGZvQubZ3mOBhWdFIdYzwZAJGnioEHn1BHFTetM3v7n/7UmNFIjcafDdpwc2SDR7+5zPny
 o/gHzPyObC5MOmsR2mpOOdWE+kj3FWlCZkoIahj0zE+8yK0EM4DG2d4QtR0hwEczfZ7wO+PQW
 MPGes6WC4XIqsTWfwU4EUgSf5BmMhHluEgb/C1Ozg4dazLRs4zewn/Aaa0W8RfJTByK6uNpav
 53leX7nb39WSmCNx3F0kxoMq00CUSFEvM/aZ1wiB2Jo2GsW8SOfG3Do//UWpwbR4zw/TTyt7V
 VLPJoa/mNdW7+0jYu7MHDDvh5jobhSpfxRhriyoTv13ZnkJq7PNJ4wpp2zxHK/oZKGsz+ow9X
 CvWwYI3usYAfCBtf6oRaDI1u7uM7y4D7rc9AiXZM4VzllU1c9RvzxVBdsM5mDYHsIpo8rZCv3
 m5pYNiYbX/Xo2LqB0zjsy51ORVH6ebWMIUAtc6o9nyE4L4CSlvThHZtR3Tx7xL8M4kNg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275164>

Seems like a greylist problem ?
(I take the freedom to forward your mail to upstream git,
in the hope that somebody has has an idea)

 
On 03.08.15 13:13, Philip Oakley wrote:
> I'm scratching my head as to why patches I try to send upstream (git@vger.kernel.org) via my MSysGit install's send-email appear to be being dropped at gver/gmane.
> 
> It's only the patches I originate via send-email, using the windows MSysGit msmtp mailer that aren't getting through. Other emails I send in reply to threads on gmane (via OE6) get through OK.
> 
> I have confirmed I'm subscribed (as per FAQs), and I've also tested the auto-answer facility.
> 
> The one peculiarity of the auto-answers is that the OE6 email reply had a delay:
> 
> X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Aug 2015 16:11:58 EDT
> [...]
> X-Mailer: Microsoft Outlook Express 6.00.2900.5931
> 
> while msmpt did not:
> [ no X-Greylist: ]
> X-Mailer: git-send-email 2.3.1
> 
> The delay may be a red-herring as it occurred on the non-problematic route, but may be an indication of some extra processing within gmane that affects the patches.
> 
> I have had a reply to one of the patch emails's direct addressees ($gmane/275141), and I'd also received a copy of the patch as I'd cc'd myself, so at least the outbound routing is getting beyond my ISP.
> 
> Does anyone have suggestions as to how I determine where/why my patche emails dropped into >dev/null ?
> 
> -- 
> 
> Philip
> 
> PS I'm using the old msysgit infrastructure as msmpt wasn't available in the new SDK at this moment.
> 
> I don't believe it's anything to do with the recompile at v2.3.1 (rather than the plain vanilla msysgit.1.9.5), but then again...
