From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Wed, 11 Oct 2006 20:46:14 +0200
Organization: At home
Message-ID: <egje5k$5rn$1@sea.gmane.org>
References: <20061010025627.19317.70511.stgit@rover> <egfndo$lg6$1@sea.gmane.org> <20061010104149.GP20017@pasky.or.cz> <200610111423.00656.jnareb@gmail.com> <20061011181729.GB2897@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 11 20:48:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXj6v-0000dt-Ru
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWJKSrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWJKSrS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:47:18 -0400
Received: from main.gmane.org ([80.91.229.2]:32135 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161021AbWJKSrR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 14:47:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXj6W-0000VN-CB
	for git@vger.kernel.org; Wed, 11 Oct 2006 20:46:56 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 20:46:56 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 20:46:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28737>

Jeff King wrote:

> On Wed, Oct 11, 2006 at 02:23:00PM +0200, Jakub Narebski wrote:
> 
>> Can any Perl expert tell us how Perl truly solve this? What is the best
>> way to dump whole [remaining] contents of file (from filehandle) to STDOUT?
> 
> The same you would in C: read fix-sized buffers and dump them.
[...]
> Or you can use the File::Copy module, which is part of the standard
> distribution (and I believe has been so for all perl5 versions, but I
> could be wrong):

And 

        {
                local $/;
                print <$fd>;
        }

doesn't do the right thing?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
