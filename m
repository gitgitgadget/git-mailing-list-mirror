From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 09:56:40 +0200
Message-ID: <AD60F584-7AAD-4083-9BA6-21F0D00D6D1D@zib.de>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>  <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>  <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <Pine.LNX.4.64.0710150223230.25221@racer.site> <E1IhJ4K-00086x-5U@fencepost.gnu.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, raa.lkml@gmail.com, ae@op5.se,
	tsuna@lrde.epita.fr, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 09:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhKnT-0004EQ-Rx
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 09:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbXJOHzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 03:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbXJOHzU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 03:55:20 -0400
Received: from mailer.zib.de ([130.73.108.11]:43033 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbXJOHzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 03:55:20 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9F7tAQE021775;
	Mon, 15 Oct 2007 09:55:10 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9F7t9GE021527
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 15 Oct 2007 09:55:09 +0200 (MEST)
In-Reply-To: <E1IhJ4K-00086x-5U@fencepost.gnu.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60958>


On Oct 15, 2007, at 8:04 AM, Eli Zaretskii wrote:

>> Date: Mon, 15 Oct 2007 02:24:53 +0100 (BST)
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> cc: Eli Zaretskii <eliz@gnu.org>, Alex Riesen  
>> <raa.lkml@gmail.com>, ae@op5.se,
>>     tsuna@lrde.epita.fr, make-w32@gnu.org
>>
>> To clarify: git works on Windows.  Most of the time, that is.  But  
>> all
>> those changes that were necessary to go there have not yet found  
>> their way
>> into the official git.git repository.
>
> I, for one, appreciate all the hard work invested in that.
>
> While we are at that: can you (or someone else) point me to
> instructions on how to build the MinGW port of GIT?  I found a tarball
> of the MinGW-ported GIT (v1.5.3, I think), but what I don't seem to be
> able to find is some kind of HOWTO: what tools I need to have
> installed, how to configure them (if there are any special issues
> there), what command(s) to type, etc.  Is there anything like that out
> there, or can someone post such instructions?

If you want to have a full working development environment, such that
you can start contributing to msysgit right away, and have no firewall
issues, go to

	http://code.google.com/p/msysgit/

and install GitMe, currently

	http://msysgit.googlecode.com/files/GitMe-0.4.2.exe

If you only care about an end-user setup, which contains only the git
binaries on your system, but no tools to compile them, stay tuned for
one or two days. We'll release an updated installer soon.

	Steffen
