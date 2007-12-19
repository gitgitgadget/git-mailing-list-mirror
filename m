From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH 4/5] atmel_serial: Split the interrupt handler
Date: Wed, 19 Dec 2007 15:07:34 +0100
Organization: Atmel Norway
Message-ID: <20071219150734.50b1f847@dhcp-252-066.norway.atmel.com>
References: <1197997575-13292-1-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-2-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-3-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-4-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-5-git-send-email-hskinnemoen@atmel.com>
	<20071218181019.2af46418@dhcp-252-066.norway.atmel.com>
	<alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
	<20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Chip Coldwell <coldwell@redhat.com>, linux@arm.linux.org.uk,
	kernel@avr32linux.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, Bohmer <linux@bohmer.net>,
	Andrew Victor <linux@maxim.org.za>
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757434AbXLSOHs@vger.kernel.org Wed Dec 19 15:08:39 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757434AbXLSOHs@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4zar-0005hX-Ow
	for glk-linux-kernel-3@gmane.org; Wed, 19 Dec 2007 15:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434AbXLSOHs (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 19 Dec 2007 09:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbXLSOHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Dec 2007 09:07:39 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:61318 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753884AbXLSOHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Dec 2007 09:07:39 -0500
Received: from dhcp-252-066.norway.atmel.com (dhcp-252-066.norway.atmel.com [10.191.252.66])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id lBJE7Y7q013366;
	Wed, 19 Dec 2007 15:07:34 +0100 (CET)
	(envelope-from hskinnemoen@atmel.com)
In-Reply-To: <20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
X-Mailer: Claws Mail 3.1.0 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68906>

On Wed, 19 Dec 2007 12:40:08 +0100
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Btw, the funny thing is that, looking at my shell history, I think I
> actually did the right thing when committing your patches:
> 
> git commit -s --author 'Remy Bohmer <linux@bohmer.net>'
> git commit -s --author 'Chip Coldwell <coldwell@frank.harvard.edu>'
> 
> But for some reason only your names stuck, not your e-mail addresses...

It just happened again. Seems like if git-rebase hits a conflict, and I
just do "git-rebase --continue" after resolving it (and updating the
index), the original author's name is used, but not his e-mail address.

Looks like a bug in git-rebase...?

Haavard
