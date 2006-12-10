X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 16:55:28 +1300
Message-ID: <46a038f90612091955i5bdd6e85l749a2f511f27953@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
	 <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com>
	 <200612091251.16460.jnareb@gmail.com> <457AAF31.2050002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 03:55:41 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gSG+nhrISAXswY1TWibLVd2Ed9gvR2y3JyjrJsvEkSc2RSDrxSuHKBryOhAj61WCU3JMstaldPF0SDd8OIKHtowfLA2K/b+pSq67Tlj6Lhcw04nTgQI4CiUgQLfvewVZd/nayEDxAG/4OJoR9/bY9BRr1AzxxJ3EybxJlWvYLrw=
In-Reply-To: <457AAF31.2050002@garzik.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33866>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtFmt-000270-Lv for gcvg-git@gmane.org; Sun, 10 Dec
 2006 04:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760150AbWLJDza (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 22:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760158AbWLJDza
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 22:55:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:55698 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760150AbWLJDz3 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 22:55:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1589263nfa for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 19:55:28 -0800 (PST)
Received: by 10.49.92.18 with SMTP id u18mr1404188nfl.1165722928439; Sat, 09
 Dec 2006 19:55:28 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Sat, 9 Dec 2006 19:55:28 -0800 (PST)
To: "Jeff Garzik" <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

On 12/10/06, Jeff Garzik <jeff@garzik.org> wrote:
> > P.S. Can anyone post some benchmark comparing gitweb deployed under
> > mod_perl as compared to deployed as CGI script? Does kernel.org use
> > mod_perl, or CGI version of gitweb?
>
> CGI version of gitweb.
>
> But again, mod_perl vs. CGI isn't the issue.

IO is the issue, and the CGI startup of Perl is quite IO & CPU
intensive. Even if the caching headers, thundering herds and planet
collisions are resolved, I don't think you'll ever be happy with IO
and CPU load on kernel.org running gitweb as CGI.

cheers,



