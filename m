From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git over rsync+ssh
Date: Thu, 10 Jul 2008 12:14:43 +0200
Message-ID: <g54nek$mbe$1@ger.gmane.org>
References: <g52gbg$si9$1@ger.gmane.org> <9b3e2dc20807091333l38260b88na89939bdde09508e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 12:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGtBy-00060x-SH
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 12:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbYGJKPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 06:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYGJKPF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 06:15:05 -0400
Received: from main.gmane.org ([80.91.229.2]:50727 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbYGJKPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 06:15:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KGtB0-00061j-Al
	for git@vger.kernel.org; Thu, 10 Jul 2008 10:15:02 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 10:15:02 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 10:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <9b3e2dc20807091333l38260b88na89939bdde09508e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87967>

Stephen Sinclair venit, vidit, dixit 09.07.2008 22:33:
> On Wed, Jul 9, 2008 at 10:01 AM, Michael J Gruber
> <michaeljgruber+gmane@fastmail.fm> wrote:
>> I want to put a git repo on a server where I have ssh access but failed to
>> compile git (AIX 5.1, has libz.a but no .so nor headers; compiling
>> prerequisite zlib failed, probably due to a botched build environment).
>>
>> As far as I can see my only option for a private repo is using rsync over
>> ssh.
> 
> Have you tried sshfs?

Yes, in other cases, with mixed success. In the present situation, I'm 
just John Doh User on both the client and the server, no sshfs available.

> It allows you to mount an ssh-accessible file system onto your local
> file system.
> This might make it possible to use your local git to access the remote account.
> Not sure of the implications for data integrity...

Integrity would be okay (single developper). But git is fast with a fast 
filesystem, not so fast on NFS; on sshfs? I'm not even sure sshfs is 
"filesystem-like" enough for git. Have you tried it with git?

Michael

P.S.: Problem solved differently now: got git going(TM) on the server.
