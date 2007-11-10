From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] for-each-ref: fix setup of option-parsing for --sort
Date: Sat, 10 Nov 2007 16:25:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711101625050.4362@racer.site>
References: <9e4733910711100610y478c62cend1d9af84e0ecc08b@mail.gmail.com>
 <1194710863-22868-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 17:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqt9d-0003do-4Y
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 17:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbXKJQZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 11:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbXKJQZh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 11:25:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:57838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751785AbXKJQZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 11:25:37 -0500
Received: (qmail invoked by alias); 10 Nov 2007 16:25:35 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp005) with SMTP; 10 Nov 2007 17:25:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Mbp1gqpxMOvO3d0jItFmfLFXvmatwx4PCbE8cq/
	Jb4Zj1j81hyfUB
X-X-Sender: gene099@racer.site
In-Reply-To: <1194710863-22868-1-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64358>

Hi,

On Sat, 10 Nov 2007, Lars Hjemli wrote:

> The option value for --sort is already a pointer to a pointer to struct
> ref_sort, so just use it.

Could you add a test for that too, please?

Thanks,
Dscho
