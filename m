From: Piet Delaney <piet.delaney@gmail.com>
Subject: Re: [PATCH] git-cvsimport: Add -N option to force a new import
Date: Tue, 06 Nov 2007 13:35:22 -0800
Message-ID: <4730DE1A.9010106@gmail.com>
References: <1193268519.8008.11.camel@mattlaptop2>	 <7vfxzz51d7.fsf@gitster.siamese.dyndns.org> <1194320170.21645.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: piet delaney <piet.delaney@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 22:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpW9n-0005Yn-Cf
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbXKFVkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbXKFVkI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:40:08 -0500
Received: from main.gmane.org ([80.91.229.2]:32991 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbXKFVkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:40:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IpW9S-00064a-IR
	for git@vger.kernel.org; Tue, 06 Nov 2007 21:40:02 +0000
Received: from adsl-71-139-221-203.dsl.snfc21.pacbell.net ([71.139.221.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 21:40:02 +0000
Received: from piet.delaney by adsl-71-139-221-203.dsl.snfc21.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 21:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-71-139-221-203.dsl.snfc21.pacbell.net
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
In-Reply-To: <1194320170.21645.72.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63732>

Matt McCutchen wrote:
> On Wed, 2007-10-24 at 20:17 -0700, Junio C Hamano wrote:
>> Matt McCutchen <matt@mattmccutchen.net> writes:
>>
>>> I had a git repository for development of rsync and wanted to start
>>> importing the upstream CVS with git-cvsimport, but git-cvsimport saw
>>> that the git repository existed and insisted on updating a previous
>>> import.  This patch adds an -N option to git-cvsimport to force a new
>>> import and updates the documentation appropriately.
>> Sounds like a useful addition.  Tests?
> 
> Good call!  As I was dismayed to discover, the existing files in the
> working tree confused the import,\

What's the confusion? I thought updating of the git repo from cvs 
worked. Sigh.

-piet



>                                   so -N as I implemented it is useless.
> I ended up doing the import a different way; I'll notify the list if I
> get around to implementing -N properly.
> 
> Matt
> 
