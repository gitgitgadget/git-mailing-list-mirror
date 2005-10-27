From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 19:11:01 +1000
Message-ID: <17248.39333.181379.615274@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 12:27:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV4xm-0005hf-GW
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 12:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVJ0K0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 06:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJ0K0K
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 06:26:10 -0400
Received: from ozlabs.org ([203.10.76.45]:34741 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932197AbVJ0K0J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 06:26:09 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id AE6CD685A0; Thu, 27 Oct 2005 20:26:08 +1000 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10711>

Johannes Schindelin writes:

> after thinking about my earlier approach, I think there's a better, less 
> intrusive, and all in all just simpler approach:

How many round-trips does it take?  When you're on the other side of
the Pacific from the server you care about round-trips. :)  One of the
nice things about rsync is that it does everything with only 1.5
round-trips.

Paul.
