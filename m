From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 4/5] atmel_serial: Split the interrupt handler
Date: Wed, 19 Dec 2007 15:37:45 -0500
Message-ID: <BAYC1-PASMTP13613FE244FF93DC2BF613AE5C0@CEZ.ICE>
References: <1197997575-13292-1-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-2-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-3-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-4-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-5-git-send-email-hskinnemoen@atmel.com>
	<20071218181019.2af46418@dhcp-252-066.norway.atmel.com>
	<alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
	<20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
	<20071219150734.50b1f847@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 21:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J55gC-0008Q2-FJ
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 21:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbXLSUht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 15:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbXLSUhs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 15:37:48 -0500
Received: from bay0-omc2-s11.bay0.hotmail.com ([65.54.246.147]:39927 "EHLO
	bay0-omc2-s11.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751896AbXLSUhr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 15:37:47 -0500
Received: from BAYC1-PASMTP13 ([65.54.191.186]) by bay0-omc2-s11.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 19 Dec 2007 12:37:47 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP13.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 19 Dec 2007 12:37:46 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1J55ff-0006lM-0r; Wed, 19 Dec 2007 15:37:39 -0500
In-Reply-To: <20071219150734.50b1f847@dhcp-252-066.norway.atmel.com>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 19 Dec 2007 20:37:46.0531 (UTC) FILETIME=[03654F30:01C8427F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68935>

On Wed, 19 Dec 2007 15:07:34 +0100
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> On Wed, 19 Dec 2007 12:40:08 +0100
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> 
> > Btw, the funny thing is that, looking at my shell history, I think I
> > actually did the right thing when committing your patches:
> > 
> > git commit -s --author 'Remy Bohmer <linux@bohmer.net>'
> > git commit -s --author 'Chip Coldwell <coldwell@frank.harvard.edu>'
> > 
> > But for some reason only your names stuck, not your e-mail addresses...
> 
> It just happened again. Seems like if git-rebase hits a conflict, and I
> just do "git-rebase --continue" after resolving it (and updating the
> index), the original author's name is used, but not his e-mail address.
> 
> Looks like a bug in git-rebase...?
> 

Hi Haavard,

Can't reproduce this here with the version of Git you're using (1.5.3.4).
Can you figure out a small test case that shows the problem?  Perhaps the
problem only shows up in your environment or with your particular config
file settings.

Regards,
Sean

P.S. Trimmed CC list.
