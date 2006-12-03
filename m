X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH v2] make 'git add' a first class user friendly interface to the index
Date: Sun, 3 Dec 2006 09:16:04 +0000
Message-ID: <200612030916.04791.alan@chandlerfamily.org.uk>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <Pine.LNX.4.64.0612030028290.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 09:16:46 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612030028290.2630@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33099>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqnSe-0007FC-S6 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 10:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935697AbWLCJQT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 04:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935701AbWLCJQT
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 04:16:19 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:26762 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S935697AbWLCJQT (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3
 Dec 2006 04:16:19 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GqnSL-0007On-7C; Sun, 03 Dec 2006 09:16:17 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 03 December 2006 05:33, Nicolas Pitre wrote:
...
> +But here's a twist. If you do 'git commit <file1> <file2> ...' then only
> +the  changes belonging to those explicitly specified files will be
> +committed, entirely bypassing the current "added" changes. Those "added"
> +changes will still remain available for a subsequent commit though.
> +
> +But for instance it is best to only remember 'git add' + 'git commit'
> +and/or 'git commit -a'.
> +

The "But for instance" seems a strange way of saying that.

How about

However, for normal usage you only have to remember 'git add' + 'git commit' 
and/or 'git commit -a'.


-- 
Alan Chandler
