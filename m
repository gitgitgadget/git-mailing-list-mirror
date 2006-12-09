X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sat, 09 Dec 2006 23:05:04 +0100
Organization: At home
Message-ID: <elfbq4$tka$1@sea.gmane.org>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612091517010.2630@xanadu.home> <7vpsas91e5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 9 Dec 2006 22:05:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33841>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtAKF-0008LT-Ji for gcvg-git@gmane.org; Sat, 09 Dec
 2006 23:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758738AbWLIWFl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 17:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758779AbWLIWFl
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 17:05:41 -0500
Received: from main.gmane.org ([80.91.229.2]:51904 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758738AbWLIWFk
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 17:05:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtAJU-0000V3-3d for git@vger.kernel.org; Sat, 09 Dec 2006 23:04:56 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 23:04:56 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 09 Dec 2006
 23:04:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:

>>>  -o|--only::
>>> -   Commit only the files specified on the command line.
>>> -   This format cannot be used during a merge, nor when the
>>> -   index and the latest commit does not match on the
>>> -   specified paths to avoid confusion.
>>> +   Commit only the files specified on the command line;
>>> +   this is the default when pathnames are given on the
>>> +   command line, so you usually do not have to give this
>>> +   option.  This format cannot be used during a merge.
>>
>> Is there some value in keeping this option documented?  What about 
>> removing it (the documentation not the option)?
> 
> True, although the description of <files>... need to be
> clarified if we do this.

I'm a bit uncomfortable about removing documentation to existing
(if no-op) option. I'd rather it stay.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

