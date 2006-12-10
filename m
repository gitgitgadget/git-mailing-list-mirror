X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sun, 10 Dec 2006 09:17:29 +0000
Message-ID: <200612100917.29967.alan@chandlerfamily.org.uk>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 09:17:55 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	"J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33871>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtKoc-0004RI-VC for gcvg-git@gmane.org; Sun, 10 Dec
 2006 10:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760576AbWLJJRn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 04:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760579AbWLJJRn
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 04:17:43 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:56825 "EHLO home.chandlerfamily.org.uk"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760576AbWLJJRn
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 04:17:43 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GtKoU-0006C4-9s; Sun, 10 Dec 2006 09:17:38 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 09 December 2006 05:48, Junio C Hamano wrote:

>  OPTIONS
>  -------
>  -a|--all::
> -	Update all paths in the index file.  This flag notices
> -	files that have been modified and deleted, but new files
> -	you have not told git about are not affected.
> +	Tell the command to automatically stage files that have
> +	been modified and deleted, but new files you have not
> +	told git about are not affected.

The "but" in this sentence doesn't seem right to me, I would either 
use "although", or slightly better (IMHO) make it two sentences

Tell the command to automatically stage files that have been modified 
and deleted.  Note that files that you have not told git about are not 
included with this option.

-- 
Alan Chandler
