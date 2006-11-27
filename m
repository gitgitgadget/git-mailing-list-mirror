X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-PS1 bash prompt setting
Date: Mon, 27 Nov 2006 11:50:47 +0100
Message-ID: <20061127105047.GB5428@fry.bender.fht>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE> <Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de> <20061126094212.fde8cce7.seanlkml@sympatico.ca> <20061126150523.GB18828@hermes.lan.home.vilz.de> <7vy7pxjmw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 10:51:08 +0000 (UTC)
Cc: Nicolas Vilz <niv@iaglans.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7pxjmw7.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at hs-esslingen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32409>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goe4o-0002WG-VG for gcvg-git@gmane.org; Mon, 27 Nov
 2006 11:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757041AbWK0Kuw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 05:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757059AbWK0Kuw
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 05:50:52 -0500
Received: from mail.hs-esslingen.de ([134.108.32.78]:28821 "EHLO
 mail.hs-esslingen.de") by vger.kernel.org with ESMTP id S1757041AbWK0Kuv
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 05:50:51 -0500
Received: from localhost (mail.hs-esslingen.de [134.108.32.78]) by
 mail.hs-esslingen.de (Postfix) with ESMTP id EBD1313F10; Mon, 27 Nov 2006
 11:50:50 +0100 (CET)
Received: from mail.hs-esslingen.de ([134.108.32.78]) by localhost (rslx211
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 20327-08; Mon, 27 Nov
 2006 11:50:47 +0100 (CET)
Received: from localhost (ovpngp2198.hs-esslingen.de [134.108.122.198])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by mail.hs-esslingen.de (Postfix) with ESMTP id
 B7AAE13E2B; Mon, 27 Nov 2006 11:50:47 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Nov 27, 2006 at 12:48:24AM -0800, Junio C Hamano wrote:
> Nicolas Vilz <niv@iaglans.de> writes:
> 
> > I glued that in my system bashrc with the extension, that it shows to me
> > user.email out of repo-config, which is also very handy. So I am always
> > reminded to set my user.credentials in .git/config and i always know which 
> > role i play in the repository i am working at.
> 
> I think there is something wrong if the user needs to be
> _constantly_ reminded who he is.  Care to explain?

Yes, you are right. It sounds a bit strange. I try to setup a pool of 
configuration data for several linux-boxes which are kind of equal in a 
git repository.

Normally I just pull the config-branch from the repository to the
particular box, but sometimes i have to test the config and alter it...
and other people do as well. And therefore i like to be reminded
constantly who I am.

I glued that in the system bashrc, so I have it for services which
run as users and which configuration data has to be edited by the
services user... also here, several people are working on that machine
and make changes.

Sincerly
