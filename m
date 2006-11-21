X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 20:04:09 +0100
Message-ID: <20061121190409.GF7201@pasky.or.cz>
References: <200611211341.48862.andyparkins@gmail.com> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <200611211839.58709.andyparkins@gmail.com> <20061121184817.GE7201@pasky.or.cz> <20061121185259.GA22461@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 19:05:23 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121185259.GA22461@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32023>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmaus-0007ww-Ia for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031318AbWKUTEM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031320AbWKUTEM
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:04:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:54483 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031318AbWKUTEL (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:04:11 -0500
Received: (qmail 5810 invoked by uid 2001); 21 Nov 2006 20:04:10 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 07:52:59PM CET, Shawn Pearce wrote:
> Petr Baudis <pasky@suse.cz> wrote:
> > On Tue, Nov 21, 2006 at 07:39:56PM CET, Andy Parkins wrote:
> > > for file in $(git-ls-files); do git-update-index --force-remove $file; done
> > > 
> > > Before creating the new files and "git-commit"ing.
> > 
> > Ok, this approach looks actually reasonable (contrary to the frequently
> > suggested rm approach, which is rather dangerous).
> > 
> > Perhaps git checkout --empty could do this?
> 
> Or perhaps just delete .git/index?
> 
> Any git-update-index --add or git-add command will immediately create
> an empty index.  Indeed this is the initial state after git-init-db,
> since there is no HEAD to load into the index there is no index...

But your working tree has still the contents of the old branch.

Sure, you could possibly just remove the files and then the index at
once but that are just details.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
