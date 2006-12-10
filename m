X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 14:02:50 +0100
Message-ID: <200612101402.51363.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612101109.34267.jnareb@gmail.com> <457C0060.3050605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 13:00:43 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tZMAGdCaBfw2l+G9ql7AoD+m5TQA/rpthEKDDrccbZR9H7h4wvfeojCN7xPxUJk0PBlukBWWEmJV6PDIC/CJAzbiAkSFv7qZLXdcazeI6F9o6mYswQ6daKxSLW2aL36+q3ORv0ralsc3tk1H2x0Qy0Y1z6teCCF4r8FFatf9fYs=
User-Agent: KMail/1.9.3
In-Reply-To: <457C0060.3050605@garzik.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33886>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtOIJ-0005Jp-SB for gcvg-git@gmane.org; Sun, 10 Dec
 2006 14:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760022AbWLJNAf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 08:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760223AbWLJNAf
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 08:00:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47045 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760022AbWLJNAf (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 08:00:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1092318uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 05:00:33 -0800 (PST)
Received: by 10.67.106.3 with SMTP id i3mr8243579ugm.1165755633348; Sun, 10
 Dec 2006 05:00:33 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 13sm4407841ugb.2006.12.10.05.00.32; Sun, 10 Dec
 2006 05:00:32 -0800 (PST)
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Jeff Garzik wrote:
> Jakub Narebski wrote:
>>
>> P.S. Any hints to how to do this with CGI Perl module?
> 
> It's impossible, Apache doesn't supply e-tag info to CGI programs.  (it 
> does supply HTTP_CACHE_CONTROL though apparently)

By ETag info you mean access to HTTP headers sent by browser
If-Modified-Since:, If-Match:, If-None-Match: do you?
 
It's a pity that CGI interface doesn't cover that...

> You could probably do it via mod_perl.

So the cache verification should be wrapped in if ($ENV{MOD_PERL}) ?
-- 
Jakub Narebski
