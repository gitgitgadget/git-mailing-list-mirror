From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 00:44:30 +0000
Organization: linutronix
Message-ID: <1115858670.22180.259.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx>
	 <200505111941.04104.dtor_core@ameritech.net>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu May 12 02:36:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1gP-0008Sa-Lu
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVELAnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVELAnp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:43:45 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57475
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261249AbVELAno
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:43:44 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 3C89265C003;
	Thu, 12 May 2005 02:43:37 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 133502807D;
	Thu, 12 May 2005 02:43:39 +0200 (CEST)
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200505111941.04104.dtor_core@ameritech.net>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 19:41 -0500, Dmitry Torokhov wrote:
> > 
> > Which is complety error prone due to rsync. Some of the repositories on
> > kernel.org keep identical copies of .git/description already. Why should
> > they preserve an unique .git/repoid ?
> 
> I think that an unique repoid should be created automatically every time
> you clone. It is ok for it to go away when you discard a tree, it will just
> identify a line (set) of changes originating from some place.

Yes, as long as you make sure that rsync does _NOT_ pollute/populate it

tglx


