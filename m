X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Mon, 11 Dec 2006 15:16:23 +1300
Message-ID: <46a038f90612101816j33870bb1j39182358440aaa40@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <200612102011.52589.jnareb@gmail.com> <457C84AC.7060105@garzik.org>
	 <200612102359.20083.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 02:16:37 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>,
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
        b=KefIE+CyZQGALuqdnArSBRY2vtA92LQFk3RIWCBUq/hjpVPeTU5tJ1CXLp0KumxPI5i6AG/cqkZATs/wGjvXFah1p+1KQD9F4V94C5F89OUIYot0FyxqnqqG6HJgcnBGstlSelcTkzlwYZCyFB6nCGCw+M2bcaXnKzRrgi9GUJw=
In-Reply-To: <200612102359.20083.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33971>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtaiS-0005nK-Tt for gcvg-git@gmane.org; Mon, 11 Dec
 2006 03:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762272AbWLKCQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 21:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762274AbWLKCQ0
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 21:16:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:8871 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762272AbWLKCQZ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 21:16:25 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1847260nfa for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 18:16:24 -0800 (PST)
Received: by 10.48.242.19 with SMTP id p19mr3854253nfh.1165803384060; Sun, 10
 Dec 2006 18:16:24 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Sun, 10 Dec 2006 18:16:23 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Even if Apache does execute CGI script to completion every time, it might
> not send the output of the script, but HTTP 304 Not Modified reply. Might.
> I don't know if it does.

It is up to the script (CGI or via mod_perl) to set the status to 304
and finish execution. Just setting the status to 304 does not
forcefully end execution as you may want to cleanup, log, etc.

cheers,


