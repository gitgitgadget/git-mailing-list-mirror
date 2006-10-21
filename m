From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 10:32:28 +0200
Organization: At home
Message-ID: <ehcluh$v3e$2@sea.gmane.org>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <vpqirigqzpd.fsf@ecrins.imag.fr> <20061019123349.GE20017@pasky.or.cz> <200610201350.12273.jnareb@gmail.com> <7vlknalgne.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201702580.3962@g5.osdl.org> <7vy7rajwyn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201818210.3962@g5.osdl.org> <7vfydijw5x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201854350.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 21 10:35:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbCK0-0002hT-5l
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 10:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992789AbWJUIfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 04:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbWJUIfH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 04:35:07 -0400
Received: from main.gmane.org ([80.91.229.2]:7660 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161193AbWJUIfE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 04:35:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GbCJq-0002gc-0J
	for git@vger.kernel.org; Sat, 21 Oct 2006 10:35:02 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 10:35:01 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 10:35:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29591>

Linus Torvalds wrote:

> On Fri, 20 Oct 2006, Junio C Hamano wrote:
>> 
>> I was not talking about "git pull".  I was talking about "git
>> show".
> 
> Duh. I don't know why I misread that.
> 
> Yeah, that makes no sense at all. I _think_ "git show" should be the same 
> thing as a single-entry "git log -p".

Huh?

$ git show ff49fae6a547e5c70117970e01c53b64d983cd10
commit ff49fae6a547e5c70117970e01c53b64d983cd10
Merge: 7ad4ee7... 75f9007... 14eab2b... 0b35995... eee4609...
[...]
diff --cc Makefile
index 36b9e06,68ae43b,66c8b4b,66c8b4b,09f60bb..a2f2f7c
[...]

"git show" doesn't prefer first parent: it uses compact combined
(that is the meaning of --cc, isn't it?) format for merges.

git version 1.4.2.1
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
