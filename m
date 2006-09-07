From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/7] gitweb: Make pickaxe search a feature
Date: Thu, 07 Sep 2006 11:07:38 +0200
Organization: At home
Message-ID: <edong1$sn1$1@sea.gmane.org>
References: <200609061504.40725.jnareb@gmail.com> <1157548091229-git-send-email-jnareb@gmail.com> <7vlkow5x77.fsf@assigned-by-dhcp.cox.net> <edoli0$oql$1@sea.gmane.org> <7vmz9c2goh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 07 11:08:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFrU-0007wc-Gi
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 11:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWIGJHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 05:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWIGJHt
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 05:07:49 -0400
Received: from main.gmane.org ([80.91.229.2]:55755 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751286AbWIGJHr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 05:07:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLFr6-0007rh-Ds
	for git@vger.kernel.org; Thu, 07 Sep 2006 11:07:30 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 11:07:28 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 11:07:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26622>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Junio C Hamano wrote:

>>> The patch suggests that it is turned off by default right now; I
>>> have not checked it myself, but is that the case?
>>
>> No, it is not. Currently it is turned on, _but_ undocumented.
> 
> Then it would be nice to make it documented and keep the default
> perhaps?
 
Keep the default is easy (although I thought that we can turn off expensive
pickaxe because it was undocumented and I suppose not many people used
that). Should I send corrected patch (i.e. making pickaxe search a feature,
but default on and perhaps overridable), or should I send correcting patch
(i.e. make pickaxe search turned on by default patch)?

Documenting gitweb search operators (author:, committer:, pickaxe:) is not:
where to put the documentation?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
