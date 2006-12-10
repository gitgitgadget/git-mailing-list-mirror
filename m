X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Mon, 11 Dec 2006 11:01:48 +1300
Message-ID: <46a038f90612101401m5f65aefbh78f7adf84725ade4@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <200612102011.52589.jnareb@gmail.com>
	 <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>
	 <200612102127.05894.jnareb@gmail.com>
	 <Pine.LNX.4.64.0612101228590.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:02:02 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Jeff Garzik" <jeff@garzik.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NCIFi1R0g1dY0fAWXc58xnG1LU/1IoTvOtgWjbcqw6LZb6akTjobxl9uzfnGII5eiLVYCDFgXzE/YnOiIAjrnvM3g2chXwiFqd6vSzMfQQQkV/NfZP+aOBEBHlPmZ4GPw+zPgLyUj9eFlenaAZZl8PdMrARDsJO8TvsKTpxbXkY=
In-Reply-To: <Pine.LNX.4.64.0612101228590.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33934>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWk7-0007i0-9K for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935057AbWLJWBv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935096AbWLJWBv
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:01:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:54528 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S935057AbWLJWBu (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 17:01:50 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1795023nfa for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 14:01:49 -0800 (PST)
Received: by 10.48.48.13 with SMTP id v13mr3588413nfv.1165788108459; Sun, 10
 Dec 2006 14:01:48 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Sun, 10 Dec 2006 14:01:48 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Sure, if the proxies actually do the rigth thing (which they may or may
> not do)

For a high-traffic setup like kernel.org, you can setup a local
reverse proxy -- it's a pretty standard practice. That allows you to
control a well-behaved and locally tuned caching engine just by
emitting good headers.

It beats writing and maintaining an internal caching mechanism for
each CGI script out there by a long mile. It means there'll be no
further tunables or complexity for administrators of other gitweb
installs.

cheers,



