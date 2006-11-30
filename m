X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 07:15:49 -0800
Message-ID: <m2odqpm0d6.fsf@ziti.fhcrc.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net> <ekmkoe$a52$1@sea.gmane.org>
	<ekmlf4$ask$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 15:16:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=GZMwklLyCoic5EJh4WACFynnN4hXZx7NPi1ACfm0crlG1+7zYwgFTiMP4pb7QOiClfzxgsKBoeoV55LOogMGtbZkKdPuDq5HTQoQyQhbLU7F069ui0BCaXRqIYAQqfeE08FSdAyLFSk+3tRJbJQJEC64SIC6zinmWYNU+vEhnUs=
In-Reply-To: <ekmlf4$ask$3@sea.gmane.org> (Jakub Narebski's message of "Thu, 30 Nov 2006 14:16:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32751>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpndX-0007ky-PS for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030391AbWK3PPk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWK3PPk
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:15:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:27192 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030375AbWK3PPj
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:15:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2140327uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 07:15:38 -0800 (PST)
Received: by 10.78.39.16 with SMTP id m16mr3618353hum.1164899737435; Thu, 30
 Nov 2006 07:15:37 -0800 (PST)
Received: from ziti.fhcrc.org ( [67.171.24.140]) by mx.google.com with ESMTP
 id 11sm26865681hug.2006.11.30.07.15.36; Thu, 30 Nov 2006 07:15:37 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Salikh Zakirov wrote:
>
>> Someone said, that default '-a' does not go well with 'git-commit --amend',
>> and I second that. It was somewhat suprising to see that 'git commit --amend'
>> is going to include all of the dirty state into the commit,
>> and since there is no easy way to abort a --amend commit (because the comment
>> buffer wasn't empty, and :q! does not work as it would on the regular commit),
>> I had to untwine the changes manually.
>
> By the way, I think that git-commit should also watch the return code
> from the editor, so you can ^C it to abort git-commit --amend.

For those using emacsclient, I don't think ^C will work.  Is there
another way to undu an ammend commit?  If not, is there any sense in
