From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Simplify crud() in ident.c
Date: Mon, 3 Dec 2007 22:32:47 +0100
Message-ID: <20071203213247.GC17671@steel.home>
References: <20071203191143.GB17671@steel.home> <m3lk8bv8du.fsf@roke.D-201>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:33:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzIug-0006Qi-JQ
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 22:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbXLCVcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 16:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXLCVcw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 16:32:52 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:15250 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbXLCVcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 16:32:51 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsEfFs=
Received: from tigra.home (Fcbaf.f.strato-dslnet.de [195.4.203.175])
	by post.webmailer.de (fruni mo54) (RZmta 14.5)
	with ESMTP id N02171jB3JC3SL ; Mon, 3 Dec 2007 22:32:49 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 863A8277AE;
	Mon,  3 Dec 2007 22:32:49 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 445AE56D22; Mon,  3 Dec 2007 22:32:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3lk8bv8du.fsf@roke.D-201>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66960>

Jakub Narebski, Mon, Dec 03, 2007 21:19:29 +0100:
> Perhaps simplier, but isn't it slower?

doubt it
