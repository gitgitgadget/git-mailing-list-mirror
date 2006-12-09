X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 20:36:18 -0800
Message-ID: <f2b55d220612082036u1853eb6ei40ad45c2150e1999@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com>
	 <4579611F.5010303@dawes.za.net> <45798FE2.9040502@zytor.com>
	 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
	 <457998C8.3050601@garzik.org>
	 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
	 <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com>
	 <Pine.LNX.4.64.0612081648160.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 04:36:27 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TUvpUHK4/6AgiCQTkDv0/mSZ9Nrfl02ZIcN9c25EuJQm3JtVaZWBgsK7ca74j2BQ4ArHc+NedDmeildXB4FdrP4/+jQK9qaqnU0LIewjb6j6LP2lQV9AX/KKZEXCmrnZtCM/ARy4BSRhUH1ya9AmhIIVV7GJh9ZlUKqG7B82a/U=
In-Reply-To: <Pine.LNX.4.64.0612081648160.3516@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33799>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gstwl-0005OF-Ej for gcvg-git@gmane.org; Sat, 09 Dec
 2006 05:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758751AbWLIEgU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 23:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758771AbWLIEgU
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 23:36:20 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:14077 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758751AbWLIEgT (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 23:36:19 -0500
Received: by wx-out-0506.google.com with SMTP id h27so995386wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 20:36:18 -0800 (PST)
Received: by 10.90.29.2 with SMTP id c2mr5053920agc.1165638978546; Fri, 08
 Dec 2006 20:36:18 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Fri, 8 Dec 2006 20:36:18 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
> That said, I'm not personally convinced that there is much point to using
> netfilter for transparent proxying. Why not just use separate ports for
> squid and for apache?

Just a question of whether you want to be able to yank the squid box
out if it goes pear-shaped, without touching configs on the apache
box.  Some people like to stick the proxy in as a no-op at first, then
tell netfilter to divert 1% of sessions to squid and see how it holds
up, retune, ease it in, ease it out, figure out how much operational
flexibility you will have as demand continues to scale.  If the squid
and apache are on the same box it's probably less of an issue.

Cheers,
