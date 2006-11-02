X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git and "dumb protocols"
Date: Thu, 02 Nov 2006 13:04:16 +0100
Message-ID: <vpq4ptixdfj.fsf@ecrins.imag.fr>
References: <vpqu01i16g8.fsf@ecrins.imag.fr>
	<20061102104848.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 12:05:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20061102104848.GH20017@pasky.or.cz> (Petr Baudis's message of "Thu\, 2 Nov 2006 11\:48\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 02 Nov 2006 13:04:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30739>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfbK2-0005OA-CT for gcvg-git@gmane.org; Thu, 02 Nov
 2006 13:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752132AbWKBMFU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 07:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbWKBMFT
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 07:05:19 -0500
Received: from imag.imag.fr ([129.88.30.1]:63420 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1752132AbWKBMFN (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 07:05:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA2C4LUP003389
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Thu, 2 Nov 2006 13:04:24 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfbIu-0000Vl-JL for
 git@vger.kernel.org; Thu, 02 Nov 2006 13:04:16 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GfbIu-0004pJ-G6 for git@vger.kernel.org; Thu, 02 Nov 2006 13:04:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>   yes, you can push using HTTP DAV - just push to an HTTP URL; make sure
> you have git-http-push compiled, it is sometimes not compiled because it
> unfortunately adds dependencies on couple of more libraries.

That's great. I don't need this right now, but having worked behind a
firewall + proxy, I know how appreciable it is to push with DAV ;-).

>   I think a patch that would add support for pushing over sftp or some
> other dumb protocol would be welcome. One problem is with proper locking
> of ref updates (not sure how well would sftp cope with that), another is
> that you will need to do git-update-server-info's job on the server
> side.

It should be possible (but not implemented AAUI) also to generate the
additional info of git-update-server-info on the client, isn't it?

>   If you already have SSH access to the server, why not compile Git
> there and install it to your $HOME, though?

I'll probably do, but my concern is broader than that. I like the
ability to use almost any webhosting service for my revision control.
GNU Arch was quite good at that, bzr is also (doesn't support webdav
very well yet, but read-only-HTTP, sftp and ftp are there), so I'd
like git to do the same.

And yes, there are tons of reasons not to install git on the server.
In particular, the fact that I'm not root there, and too lazy to do
more than "aptitude install git" with pleasure ;-).

-- 
