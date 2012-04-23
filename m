From: Jose Ricardo <josericardo.jr@gmail.com>
Subject: Re: Custom Merge
Date: Mon, 23 Apr 2012 14:28:47 +0000 (UTC)
Message-ID: <loom.20120423T162755-821@post.gmane.org>
References: <loom.20120423T141242-348@post.gmane.org> <4F955243.2090103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 16:29:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMKGM-00037L-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 16:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778Ab2DWO3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 10:29:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:43127 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378Ab2DWO3E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 10:29:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SMKGF-00030j-AR
	for git@vger.kernel.org; Mon, 23 Apr 2012 16:29:03 +0200
Received: from 187126163164.user.veloxzone.com.br ([187126163164.user.veloxzone.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 16:29:03 +0200
Received: from josericardo.jr by 187126163164.user.veloxzone.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 16:29:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 187.126.163.164 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.163 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196126>

Johannes Sixt <j.sixt <at> viscovery.net> writes:

> 
> I have my image merge script configured it like this:
> 
> [merge "imgfile"]
> 	driver = imgmerge %O %A %B %A
> 
> but if you do that, you must be sure that the script does not need to
> access $2 after it has begun writing to $4.
> 
> (I know that it worked because at one time I had forgotten that I have a
> custom merge driver, and was expecting a merge conflict due to an image
> file, but there was no conflict, and the result was correct 
> 

Hi Johannes,

Thanks a lot for your help. 

I have checked it and I'm writing to the right file after reading the data from
 it. According to what I see, only the modifications made on the current 
branch are saved, even after applying the delta to the right image file.

One question is: does it matter if I save the whole file, replacing the old with 
this new one? Or do I need to open the old one and modify its content?

Thanks again!
