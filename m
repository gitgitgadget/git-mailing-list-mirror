From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] for-each-ref: fix setup of option-parsing for --sort
Date: Sun, 11 Nov 2007 19:19:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111918470.4362@racer.site>
References: <1194713274-31200-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrILK-0002Oi-NX
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbXKKTTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 14:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbXKKTTS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:19:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:38700 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755387AbXKKTTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:19:18 -0500
Received: (qmail invoked by alias); 11 Nov 2007 19:19:16 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp018) with SMTP; 11 Nov 2007 20:19:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3EEw+I/D3fCK3BToQh1vK0pH8wB/+NLAcmJEpfG
	mZtMXP7s5aF4Lf
X-X-Sender: gene099@racer.site
In-Reply-To: <1194713274-31200-1-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64494>

Hi,

On Sat, 10 Nov 2007, Lars Hjemli wrote:

> The option value for --sort is already a pointer to a pointer to struct
> ref_sort, so just use it.
> 
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
> 
> On Nov 10, 2007 5:25 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Could you add a test for that too, please?
> 
> Is this ok?

That's exactly what I had in mind.

Thank you,
Dscho
