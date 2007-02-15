From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Thu, 15 Feb 2007 01:41:40 +0100
Organization: At home
Message-ID: <er0a4k$n59$1@sea.gmane.org>
References: <17875.13564.622087.63653@lisa.zopyra.com> <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com> <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com> <17875.30687.661794.512124@lisa.zopyra.com> <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org> <17875.33204.413186.355557@lisa.zopyra.com> <7vzm7gl8cf.fsf@assigned-by-dhcp.cox.net> <7vvei4l84q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142303250.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vire4l76a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 01:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHUfb-00086W-DH
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 01:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXBOAkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 19:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbXBOAkH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 19:40:07 -0500
Received: from main.gmane.org ([80.91.229.2]:43075 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbXBOAkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 19:40:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHUfH-0003aM-Kk
	for git@vger.kernel.org; Thu, 15 Feb 2007 01:39:59 +0100
Received: from host-81-190-26-5.torun.mm.pl ([81.190.26.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 01:39:59 +0100
Received: from jnareb by host-81-190-26-5.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 01:39:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-5.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39779>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Wed, 14 Feb 2007, Junio C Hamano wrote:
>>
>>> By the way, I sometimes think it might be worth doing this:
>>> 
>>>     $ chmod a-r .git/
>>> 
>>> We always access files by explicit paths and never ask "ls .git/foo*" to 
>>> find what are under .git/ directory.
>>
>> If so, please make it unconfigurable. I use tab-completion in the git 
>> directory quite often.
> 
> Do you mean "configurable"?
> 
> I wonder what you are doing inside .git directory in the first
> place.  I never chdir() into it myself, but that may be because
> I practicaly live inside Emacs.

I look what interesting is in here (like COMMIT_EDITMSG, MERGE_HEAD,
ORIG_HEAD, some StGIT templates,....).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
