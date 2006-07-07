From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2, proof of concept] autoconf: Use %configure in git.spec, autoconf dependency only in rpm target
Date: Fri, 07 Jul 2006 22:06:55 +0200
Organization: At home
Message-ID: <e8mesd$8ur$4@sea.gmane.org>
References: <200607030156.50455.jnareb@gmail.com> <200607041609.36329.jnareb@gmail.com> <1152159397.10415.29.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jul 07 22:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fywel-0000kS-Vk
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 22:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWGGUK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGGUK3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 16:10:29 -0400
Received: from main.gmane.org ([80.91.229.2]:27369 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750785AbWGGUK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 16:10:28 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FyweH-0000fw-Vy
	for git@vger.kernel.org; Fri, 07 Jul 2006 22:10:02 +0200
Received: from host-81-190-22-25.torun.mm.pl ([81.190.22.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 22:10:01 +0200
Received: from jnareb by host-81-190-22-25.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 22:10:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-25.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23467>

Pavel Roskin wrote:

> On Tue, 2006-07-04 at 16:09 +0200, Jakub Narebski wrote:
>
>> +Patch0:     git-add-autoconf-configure.patch.gz
> 
> I don't think we need patches in git.spec.in.  Let's leave it to the
> actual distributions.  If you have a problem with rpm, please submit the
> autoconf support for now and the rest will be cleaned up eventually.
> Besides, the "next" branch has different and potentially conflicting
> changes to git.spec.in for Git.pm support.

First, it is proof of concept patch, the concept being having autoconf
dependency _only_ in rpm target.

Second, it should be "Source1: autoconf-configure.tar.gz" or something like
that. Using "Patch0:" was an ugly hack.

That to say RPM builders use "PatchN:" for patches which didn't made
upstream; perhaps they make sources more compatibile with distribution RPM
is prepared for.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
