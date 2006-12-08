X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Fri, 08 Dec 2006 20:32:47 +0100
Organization: At home
Message-ID: <elcegl$qfh$1@sea.gmane.org>
References: <loom.20061208T131919-178@post.gmane.org> <7vpsaui4cn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 8 Dec 2006 19:31:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33726>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslRU-0000hD-Qn for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426151AbWLHTao (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426153AbWLHTao
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:30:44 -0500
Received: from main.gmane.org ([80.91.229.2]:37123 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1426151AbWLHTan
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 14:30:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GslQc-0001Qo-4a for git@vger.kernel.org; Fri, 08 Dec 2006 20:30:38 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 20:30:38 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 20:30:38 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Pazu <pazu@pazu.com.br> writes:
> 
>> # Please enter the commit message for your changes.
>> # (Comment lines starting with '#' will not be included)
>> # On branch refs/heads/next
>> # Updated but not checked in:
>> #   (will commit)
>> #
>> #    modified:   perl/Makefile
>> #    modified:   var.c
>>
>> Here's where the magic would happen. Removing the line "modified: var.c" would
>> remove var.c from this commit. Of course, the template message should be
>> modified to tell the user he can do that.
>>
>> So, what do you think about this?
> 
> Personally, I would refuse to use such a modified git, because
> often the first thing I would do in the commit log buffer is
> check the listed files and remove the '# ...' lines while
> typing.  I do not want that to affect the set of changes I
> staged in any way.
> 
> But maybe that is just me.

I was to raise the same objection. 

But this can be solved by using magic _only_ if the template with exception
of "modified:" lines matches, and if there is at least one file
in "modified:" section.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

