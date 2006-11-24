X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "stgit clean" has problems with removed generated files
Date: Fri, 24 Nov 2006 09:20:35 +0100
Organization: At home
Message-ID: <ek69tf$bp9$1@sea.gmane.org>
References: <20061123161135.GK5443@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0611230833y5ffc14d3q922a821744ad05d@mail.gmail.com> <20061123192831.GL5443@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 24 Nov 2006 08:19:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32193>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWH8-0002Y7-JK for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757639AbWKXITH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 03:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757648AbWKXITG
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:19:06 -0500
Received: from main.gmane.org ([80.91.229.2]:12944 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757639AbWKXITF (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:19:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnWGz-0002VX-0a for git@vger.kernel.org; Fri, 24 Nov 2006 09:19:01 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 09:19:01 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 09:19:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Yann Dirson wrote:

> On Thu, Nov 23, 2006 at 04:33:42PM +0000, Catalin Marinas wrote:
>> >fatal: Untracked working tree file 'include/asm-arm/constants.h' would be  
>> >overwritten by merge.
>> 
>> That's a git error and I think it is the correct behaviour. It is
>> safer to notify that a local file is overridden by a merge/switch
>> operation rather than just losing its content.
> 
> Right, I do not discuss the behaviour of git here.  But when I first
> encountered this issue, I was really wondering about what was
> happenning.  It would be really helpful in such a case, if stgit was
> able to pinpoint the precise patch which could not be popped.  It could
> also be helpful to tell when popping patches - currently it's done
> "behind my back", and I could only understand what was happenning by
> reading the code.

I think it was corrected in git, or is being corrected (meaning it is
in 'next' or in 'pu'); it being relaxing "would be overwritten by merge"
check for files which were, but are not, under version control.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

