X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Lang <dlang@digitalinsight.com>
Subject: Re: [PATCH] Stop telling users we are 'defaulting to local 
 storagearea'.
Date: Tue, 19 Dec 2006 11:48:42 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0612191147300.18007@qynat.qvtvafvgr.pbz>
References: <20061214230902.GA26506@spearce.org> <Pine.LNX.4.64.0612142059301.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Tue, 19 Dec 2006 20:11:31 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 15:11:18 EST
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0612142059301.18171@xanadu.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34849>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwlJ4-0004Tx-47 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 21:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932937AbWLSULT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 15:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932940AbWLSULT
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 15:11:19 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:34263 "HELO
 warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
 id S932937AbWLSULS (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 15:11:18 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com via smtpd (for
 vger.kernel.org [209.132.176.167]) with SMTP; Tue, 19 Dec 2006 12:11:18 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by
 wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 19
 Dec 2006 12:05:59 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Nicolas Pitre wrote:

> On Thu, 14 Dec 2006, Shawn O. Pearce wrote:
>
> [...]
>> It also breaks from our normal behavior of not printing
>> anything if the command was successful.
>
> Before everybody starts believing  everybody agrees with this I'll have
> to throw a tile in the pond.
>
> I really don't think this is a good rule.
>
> NOte that I'm not against commands that are silent by default.  I really
> think that git-add should remain silent on success by default when
> successful.
>
> But the rule of thumb should be about the importance of the action
> performed by the command.  git-add is a less important command than
> git-init-db or git-commit _conceptually_.  You can do multiple git-add
> in whatever order, even repeatedly, and it won't change the outcome.
> It is "conceptually lightweight".  But git-init-db is really important.
> Without it you just can't do anything. It should give the user the
> impression that something did actually happen, especially since this is
> the git comand any new git user is most likely to use first.  Saying
> back "git repository initialized" tells the user "OK you can start now".
> Saying nothing might just leave the user wondering if everything is
> actually fine.

how about makeing it silent on sucess unless the output is a tty? that way you 
don't mess up scripts with the 'it worked' message and you still reassure the 
user that something actually happened.

David Lang
