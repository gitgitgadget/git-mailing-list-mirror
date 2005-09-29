From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Thu, 29 Sep 2005 10:25:14 -0700
Message-ID: <433C237A.20401@zytor.com>
References: <433B3B10.5050407@zytor.com> <Pine.LNX.4.63.0509291043580.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 19:28:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL29z-0000ME-1h
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 19:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVI2RZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVI2RZW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 13:25:22 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:53990 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932274AbVI2RZV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 13:25:21 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8THPEJv021165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Sep 2005 10:25:15 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509291043580.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9493>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Sep 2005, H. Peter Anvin wrote:
> 
>>Another funny which I haven't been able to figure out yet is that 'gitk'
>>scrunches all its output up into a few pixels at the top of the window.
> 
> See my mail about rootless X11. I went about working around that 
> particular Tk bug by specifying the dimensions of the panes explicitely. 
> However, I was not especially happy with my workaround, since it did not 
> reproduce the layout exactly after a restart. Maybe you can figure it out 
> how to do that.
> 

It looks like this isn't a rootless *X* thing; it looks like the wish 
that is included with Cygwin actually opens native Win32 windows; even 
when run from inside a rooted X session it still opens an external 
window.  I also tried using the wish from the latest ActiveState 
distribution; it exhibits the same problem although with slightly 
different geometries.

	-hpa
