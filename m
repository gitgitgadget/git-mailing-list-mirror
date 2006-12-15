X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 15:39:53 +0100
Organization: At home
Message-ID: <elubv2$6ag$1@sea.gmane.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>	<200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> <45810B49.2000706@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 14:37:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34507>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEC0-0002LQ-5D for gcvg-git@gmane.org; Fri, 15 Dec
 2006 15:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752663AbWLOOhl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbWLOOhl
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 09:37:41 -0500
Received: from main.gmane.org ([80.91.229.2]:59763 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752663AbWLOOhk
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 09:37:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvEBp-0007iN-8s for git@vger.kernel.org; Fri, 15 Dec 2006 15:37:33 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 15:37:33 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 15:37:33 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:
> Junio C Hamano wrote:
>> Andy Parkins <andyparkins@gmail.com> writes:
>> 
>>>  * git-add has no output, whether it works or not
>> 
>> "git add no-such-file" complains, and I think that is adequate.
>> Now with Nico's 'add means adding contents, not path' change is
>> in, we _might_ want to differentiate adding a path that was
>> untracked before and updating the contents, but I think this
>> again falls into "doing exactly as told" category.
>> 
> 
> Well, it should really let the user know if it fails. I for one would 
> like to know that. I wasn't aware of the fact that it was silent even in 
> those situations (perhaps because I've never run across it).
> 
> The errors that need to be reported are, afaics:
> Content in 'path/to/file' is ignored according to path/to/.gitignore.

This is not an error, just a warning. Sometimes user want's to add a file
which is otherwise ignored (e.g. due to glob), sometimes user adds ignored
file by mistake.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

