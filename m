From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Thu, 28 Dec 2006 12:50:37 +0100
Organization: At home
Message-ID: <en0asv$bjm$1@sea.gmane.org>
References: <junkio@cox.net> <200612271206.kBRC6ke2004207@laptop13.inf.utfsm.cl> <7v64bw3ewk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 28 12:48:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gztjs-0002tk-BW
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 12:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbWL1Lr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 06:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbWL1Lr4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 06:47:56 -0500
Received: from main.gmane.org ([80.91.229.2]:45216 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbWL1Lr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 06:47:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gztjh-0005nM-79
	for git@vger.kernel.org; Thu, 28 Dec 2006 12:47:49 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 12:47:49 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 12:47:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35554>

[Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
 "Horst H. von Brand" <vonbrand@inf.utfsm.cl>]

Junio C Hamano wrote:

> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
> 
>> Junio C Hamano <junkio@cox.net> wrote:
>>> This is still rough, but I think we have a pretty good idea what
>>> will and what won't be in v1.5.0 by now, and end-of-year is a
>>> good slow time to summarize what we have done.
>>
>> Could somebody please summarize how to "upgrade" a repository to the new
>> layout?  This has got my head spinning... and I'm /not/ cloning the
>> various repos I've got here just to take advantage of the changes.
> 
> The old layout was to map remote branch $B to local tracking
> branch .git/refs/heads/$B, unless $B == 'master' in which case
> it was mapped to .git/refs/heads/origin (and I think we
> discarded 'origin' at remote).

How to discard 'origin' in the new wildcard / globbing remote config?
IIRC there was proposal to use '-' or '!' to exclude branch from
fetching, but no code...

[...]
>  - create the config section like the above in .git/config, and

You can use contrib/remotes2config.sh script...

>  - remove .git/remotes/origin when you are done.
 
...which saves remotes/ under remotes.old/
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
