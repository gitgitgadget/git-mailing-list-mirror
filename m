From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: older git archive access broken in 1.2.0?
Date: Tue, 14 Feb 2006 08:00:48 +0100
Message-ID: <1139900449.2480.515.camel@localhost.localdomain>
References: <20060214050616.GA28528@kroah.com>
	 <7vek26wkwu.fsf@assigned-by-dhcp.cox.net>  <20060214061529.GA853@kroah.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	tglx@kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 08:00:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8uAj-000073-MR
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 08:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWBNHAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 02:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBNHAX
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 02:00:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30357
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030408AbWBNHAW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 02:00:22 -0500
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 3AA1A65C044;
	Tue, 14 Feb 2006 08:00:21 +0100 (CET)
Received: from tglx.tec.linutronix.de (unknown [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id D42F328278;
	Tue, 14 Feb 2006 08:00:20 +0100 (CET)
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060214061529.GA853@kroah.com>
X-Mailer: Evolution 2.5.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16125>

On Mon, 2006-02-13 at 22:15 -0800, Greg KH wrote:
> > I think 1.2.0 may be a coincidence.  history.git/ mistakenly has
> > an extra .git subdirectory underneath it.  Removing it should
> > make things to work again I suspect.
> 
> Ah, doh, that was simple.  Thanks for the quick response.

Fixed. No idea how it got there. 

	tglx
