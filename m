X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 19:48:17 +0100
Message-ID: <20061121184817.GE7201@pasky.or.cz>
References: <200611211341.48862.andyparkins@gmail.com> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <200611211839.58709.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:48:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611211839.58709.andyparkins@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32020>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmafP-0004Ss-Uh for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031305AbWKUSsU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031306AbWKUSsU
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:48:20 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34280 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031305AbWKUSsT (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:48:19 -0500
Received: (qmail 4488 invoked by uid 2001); 21 Nov 2006 19:48:17 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 07:39:56PM CET, Andy Parkins wrote:
> On Tuesday 2006, November 21 18:21, Petr Baudis wrote:
> 
> > (The answer is usually "create the branch in a separate repo and then
> > fetch it to the original one". But it feels a bit kludgy given the
> > otherwise seamless support for unrelated branches. (Not that I ever was
> > a big fan of unrelated long-lived branches in general.))
> 
> Just as kludgy, but I did this today by writing the name of the new branch 
> in .git/HEAD then doing
> 
> for file in $(git-ls-files); do git-update-index --force-remove $file; done
> 
> Before creating the new files and "git-commit"ing.

Ok, this approach looks actually reasonable (contrary to the frequently
suggested rm approach, which is rather dangerous).

Perhaps git checkout --empty could do this?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
