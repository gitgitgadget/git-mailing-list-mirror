X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Thu, 14 Dec 2006 02:50:44 -0800
Message-ID: <7v3b7i92ez.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 10:50:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 14 Dec 2006 11:31:05 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34309>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoAr-0000Yz-9F for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932425AbWLNKuq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWLNKuq
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:50:46 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49465 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932447AbWLNKup (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 05:50:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214105045.VHJM15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 05:50:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yaq51V00F1kojtg0000000; Thu, 14 Dec 2006
 05:50:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +			ret = show_object(o->sha1, 1);
> +			objects[i].item = (struct object *)t->tagged;
> +			i--;
> +			break;

Good hack ;-).
