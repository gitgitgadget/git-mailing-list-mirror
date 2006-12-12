X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Tue, 12 Dec 2006 22:19:28 +0100
Message-ID: <200612122219.30040.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <46a038f90612091955i5bdd6e85l749a2f511f27953@mail.gmail.com> <457BB1A3.2070408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 21:17:17 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XdjEcvn600yQl+a1be4Ib/bWvMOXIXyWvN10yg+We1iaE9QNFmQSLqvpONCPhSQBcfLC1RkcmRN5SI0ykepFG7KIygQ3eRWA5EI/z87oLm6Vt9AboICFrsKH+IkbNdIxEUya8oNOu+XMpvknLf8JucLDe/L7lMVT9qFV3HDxc7k=
User-Agent: KMail/1.9.3
In-Reply-To: <457BB1A3.2070408@zytor.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34144>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuEzx-0001ck-Ph for gcvg-git@gmane.org; Tue, 12 Dec
 2006 22:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932368AbWLLVRK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 16:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWLLVRK
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 16:17:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:45728 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932368AbWLLVRJ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 16:17:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1786068uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 13:17:08 -0800 (PST)
Received: by 10.66.221.6 with SMTP id t6mr21803ugg.1165958227734; Tue, 12 Dec
 2006 13:17:07 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 20sm7235041uga.2006.12.12.13.17.05; Tue, 12 Dec
 2006 13:17:06 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

By the way, setting Last-Modified: and ETag: and checking for 
If-Modified-Since: and If-None-Match: is easy only for log-like views: 
"shortlog", "log", "history", "rss"/"atom". With "shortlog" and 
"history" we have additional difficulity of using relative dates there.
And even for those views we need reverse proxy / caching engine
(e.g. Squid in "HTTP accelerator" mode) in front.

It would be easier to pre-generate most common accessed views: 
"projects_list", "summary" and "rss"/"atom" main for each project, and 
just serve static pages. I don't know if we need to modify gitweb for 
that.


BTW. for single client (rather stupid benchmark, I know) mod_perl is 
about twice faster in keepalive mode than CGI version of gitweb for 
git.git summary page.

-- 
Jakub Narebski
