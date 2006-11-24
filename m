X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method   HTTP/1.x  proxying
Date: Fri, 24 Nov 2006 03:48:35 -0800
Message-ID: <7vhcwpawvg.fsf@assigned-by-dhcp.cox.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu> <7v64
	d5keke.fsf@assigned-by-dhcp.cox.net>
	<67mz6h6xmb.fsf@poseidon.eteo.mond ragon.edu>
	<7vfyc9cjci.fsf@assigned-by-dhcp.cox.net>
	<67hcwp6wpp.fsf@poseidon.eteo.mondragon.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 11:48:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32212>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnZXt-00046e-Hd for gcvg-git@gmane.org; Fri, 24 Nov
 2006 12:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934190AbWKXLsi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 06:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934266AbWKXLsi
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 06:48:38 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8641 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S934190AbWKXLsh
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 06:48:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124114837.JHCZ5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 06:48:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qbok1V00X1kojtg0000000; Fri, 24 Nov 2006
 06:48:45 -0500
To: Ignacio Arenaza <iarenuno@eteo.mondragon.edu>
Sender: git-owner@vger.kernel.org

Ignacio Arenaza <iarenuno@eteo.mondragon.edu> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Let's save a bit of trouble from you.  Here is what I've queued
>> for 'master', with fixes from the discussion so far.
>
> Looks good to me, but it seems you missed the 'if(...) {' and
> 'if(...){' formating issues you raised before.

I deliberately left out the style changes to avoid cluttering
the patch; as I said in my first response, that should come as a
separate patch that does not change anything else.
