From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 2 Jul 2006 11:56:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607021155100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060702094938.GA10944@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 11:56:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwygQ-0005so-TZ
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 11:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWGBJ4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 05:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932829AbWGBJ4E
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 05:56:04 -0400
Received: from mail.gmx.net ([213.165.64.21]:46495 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932828AbWGBJ4D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 05:56:03 -0400
Received: (qmail invoked by alias); 02 Jul 2006 09:56:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 02 Jul 2006 11:56:02 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060702094938.GA10944@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23101>

Hi,

On Sun, 2 Jul 2006, Rene Scharfe wrote:

> Due to popular request ;-), change get_merge_bases() to be able to
> clean up after itself if needed by adding a cleanup parameter.
> 
> We don't need to save the flags and restore them afterwards anymore;
> that was a leftover from before the flags were moved out of the
> range used in revision.c.  clear_commit_marks() sets them to zero,
> which is enough.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ciao,
Dscho
