From: walt <w41ter@gmail.com>
Subject: Re: git-bisect not working correctly in the kvm.git repository?
Date: Mon, 17 Nov 2008 12:19:03 -0800
Message-ID: <gfsjjp$o42$1@ger.gmane.org>
References: <gfs9hn$hq9$1@ger.gmane.org> <alpine.LFD.2.00.0811171131330.18283@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 21:20:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2AaM-00086W-5V
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 21:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYKQUTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 15:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYKQUTS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 15:19:18 -0500
Received: from main.gmane.org ([80.91.229.2]:37475 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbYKQUTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 15:19:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L2AYz-0004cC-Uh
	for git@vger.kernel.org; Mon, 17 Nov 2008 20:19:13 +0000
Received: from adsl-69-234-203-176.dsl.irvnca.pacbell.net ([69.234.203.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 20:19:13 +0000
Received: from w41ter by adsl-69-234-203-176.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 20:19:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-203-176.dsl.irvnca.pacbell.net
User-Agent: Thunderbird/3.0a2pre (X11; 2008111706)
In-Reply-To: <alpine.LFD.2.00.0811171131330.18283@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101239>

Linus Torvalds wrote:
>
> On Mon, 17 Nov 2008, walt wrote:
>> I'm trying to find a bug introduced somewhere between kvm-69
>> and kvm-70, so of course I want to git-bisect down to it.
>>
>> The weirdness is that when I give git-bisect the good and
>> bad tags, almost everything in my working directory just
>> disappears, leaving only the qemu subdirectory behind.

> ...
> If you merge stuff from another project that isn't a full repository, then
> you are merging commits that simply don't _have_ the full tree of your
> repo...

Okay, that's clearly what's happening to me.  The kvm.git repo
contains hundred of commits just like that.  How would you deal
with the same situation?  Is git-bisect skip the easiest way?
