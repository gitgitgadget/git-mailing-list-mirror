From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH 4/5] atmel_serial: Split the interrupt handler
Date: Wed, 19 Dec 2007 12:40:08 +0100
Organization: Atmel Norway
Message-ID: <20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
References: <1197997575-13292-1-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-2-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-3-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-4-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-5-git-send-email-hskinnemoen@atmel.com>
	<20071218181019.2af46418@dhcp-252-066.norway.atmel.com>
	<alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux@arm.linux.org.uk, kernel@avr32linux.org,
	linux-kernel@vger.kernel.org, Andrew Victor <linux@maxim.org.za>,
	Remy Bohmer <linux@bohmer.net>,
	linux-arm-kernel@lists.arm.linux.org.uk, git@vger.kernel.org
To: Chip Coldwell <coldwell@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xIL-0002MA-0V
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbXLSLkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 06:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754399AbXLSLkN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:40:13 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:53240 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751748AbXLSLkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:40:11 -0500
Received: from dhcp-252-066.norway.atmel.com (dhcp-252-066.norway.atmel.com [10.191.252.66])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id lBJBe8jL008718;
	Wed, 19 Dec 2007 12:40:08 +0100 (CET)
	(envelope-from hskinnemoen@atmel.com)
In-Reply-To: <alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
X-Mailer: Claws Mail 3.1.0 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68889>

On Tue, 18 Dec 2007 13:19:39 -0500 (EST)
Chip Coldwell <coldwell@redhat.com> wrote:

> > On Tue, 18 Dec 2007 18:06:14 +0100
> > Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> >   
> > > From: Remy Bohmer <hskinnemoen@atmel.com>  
> > 
> > Heh. That's obviously wrong. Wonder what happened there?
> > 
> > Looks like Chip's address got mangled too.  
> 
> You can find me at <coldwell@gmail.com> or <coldwell@redhat.com> these
> days, although <coldwell@frank.harvard.edu> still works for the time
> being.

Thanks. I'll update the broken commits.

Btw, the funny thing is that, looking at my shell history, I think I
actually did the right thing when committing your patches:

git commit -s --author 'Remy Bohmer <linux@bohmer.net>'
git commit -s --author 'Chip Coldwell <coldwell@frank.harvard.edu>'

But for some reason only your names stuck, not your e-mail addresses...

Haavard
