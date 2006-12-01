X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 01:11:07 +0100
Organization: At home
Message-ID: <eknrr8$n27$2@sea.gmane.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301530.51171.andyparkins@gmail.com> <20061130163304.GN12463MdfPADPa@greensroom.kotnet.org> <200612010001.57111.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 1 Dec 2006 00:10:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32836>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpvzB-0002IV-9q for gcvg-git@gmane.org; Fri, 01 Dec
 2006 01:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031623AbWLAAKU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 19:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031628AbWLAAKU
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 19:10:20 -0500
Received: from main.gmane.org ([80.91.229.2]:20616 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031623AbWLAAKS (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 19:10:18 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gpvyc-0002A0-IZ for git@vger.kernel.org; Fri, 01 Dec 2006 01:10:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 01:10:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01 Dec 2006
 01:10:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Thursday 2006, November 30 16:33, Sven Verdoolaege wrote:
>>>
>>> Well, I know what the commit is /that/ was all that was stored.  So I
>>
>> Then I have no idea what you are talking about.
>> A commit _contains_ all the history that lead up to that commit,
>> so if you have the commit, then you also have the history.
> 
> It's not so much an actual commit, as a reference to a commit in another 
> repository.

Hmmm... I thought the idea was that submodule commit is available in the
object repository, be it via alternates mechanism pointing to the submodule
repository for alternate storage, or submodule being in "unrelated"
branch/tracking branch.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

