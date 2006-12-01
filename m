X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Fri, 1 Dec 2006 16:45:06 +0000 (UTC)
Message-ID: <ekpm6i$s35$1@sea.gmane.org>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
	<slrnen04os.a5.Peter.B.Baumann@xp.machine.xx>
	<7v3b7zalsq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Fri, 1 Dec 2006 16:47:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: backup.global.cn
User-Agent: pan 0.119 (Karma Hunters)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32943>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqBWn-0001Q0-Jy for gcvg-git@gmane.org; Fri, 01 Dec
 2006 17:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031592AbWLAQqR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 11:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031594AbWLAQqR
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 11:46:17 -0500
Received: from main.gmane.org ([80.91.229.2]:59847 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031592AbWLAQqR (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 11:46:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqBW9-0001CK-1r for git@vger.kernel.org; Fri, 01 Dec 2006 17:45:41 +0100
Received: from backup.global.cn ([195.224.169.69]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 01 Dec 2006 17:45:41 +0100
Received: from wildfire by backup.global.cn with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01 Dec 2006 17:45:41
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Fri, 01 Dec 2006 03:38:13 -0800, Junio C Hamano wrote:

> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
> writes:
> 
>> I don't think it belongs in the plumbing, the git-update-index but I
>> think something like this would be very usefull.
>>
>> AFAIR darcs has this functionality. It selectively ask for each hunk if
>> it should be commited. This would be awfull to have in git.
> 
> I concur, on both counts.  My own now-defunct Porcelain had the
> darcs style interactive hunk selection because it felt so
> useful (and sometimes it was).

Is there a good receipe on how to do this? Everytime I do it, I try a
different method; since I'm testing out my understanding of things.

It'd nice to have some of these "advanced receipes" that people often do
noted down somewhere.

Sometimes I feel git is kind of like the Emacs of VCS ... there is always
more to learn, even when you think you have a good handle on things.

Cheers,
Anand
