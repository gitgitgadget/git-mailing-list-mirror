From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Mon, 24 Nov 2008 22:03:11 +0000
Message-ID: <20081124220311.GB5293@hashpling.org>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org> <20081115155603.GD22948@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	William Pursell <bill.pursell@gmail.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:04:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4jXt-0004MJ-Nf
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 23:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbYKXWD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 17:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbYKXWD0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 17:03:26 -0500
Received: from pih-relay04.plus.net ([212.159.14.17]:43636 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbYKXWDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 17:03:25 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1L4jWS-00008G-Sq; Mon, 24 Nov 2008 22:03:13 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mAOM3C6i005817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Nov 2008 22:03:12 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mAOM3Bat005816;
	Mon, 24 Nov 2008 22:03:11 GMT
Content-Disposition: inline
In-Reply-To: <20081115155603.GD22948@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 2f3d8a179a160b23d3d7efa3266f499d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101628>

On Sat, Nov 15, 2008 at 10:56:03AM -0500, Theodore Tso wrote:
> Instead of making this be a command-line and configuration option,
> maybe it would be better to prompt the user after an aborted merge,
> and give the user the opportunity to continue or abort?  i.e., instead
> of just saying "merge of foo.c failed" and then exiting, to ask the
> user instad something like, "Merge of foo.c failed; continue
> attempting to merge the rest of the files? <y>"
> 
> I suspect this might be more friendly than Yet Another command-line
> option and configuration parameter.  What do you think?
> 
>        	   		 	     	     	 - Ted

This sounds like a really good alternative interface option. The next
time I have a moment (could be a while!) I'll try and make a patch
based on this idea.

Charles.
