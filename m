X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git and "dumb protocols"
Date: Thu, 2 Nov 2006 13:21:25 +0100
Message-ID: <20061102122125.GM20017@pasky.or.cz>
References: <vpqu01i16g8.fsf@ecrins.imag.fr> <20061102104848.GH20017@pasky.or.cz> <vpq4ptixdfj.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 12:22:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <vpq4ptixdfj.fsf@ecrins.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30741>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfbZb-0007ra-7o for gcvg-git@gmane.org; Thu, 02 Nov
 2006 13:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752169AbWKBMV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 07:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbWKBMV1
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 07:21:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50073 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752169AbWKBMV1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 07:21:27 -0500
Received: (qmail 18569 invoked by uid 2001); 2 Nov 2006 13:21:25 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Dear diary, on Thu, Nov 02, 2006 at 01:04:16PM CET, I got a letter
where Matthieu Moy <Matthieu.Moy@imag.fr> said that...
> Petr Baudis <pasky@suse.cz> writes:
> >   I think a patch that would add support for pushing over sftp or some
> > other dumb protocol would be welcome. One problem is with proper locking
> > of ref updates (not sure how well would sftp cope with that), another is
> > that you will need to do git-update-server-info's job on the server
> > side.
> 
> It should be possible (but not implemented AAUI) also to generate the
> additional info of git-update-server-info on the client, isn't it?

Yes, that's what git-http-push does.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
