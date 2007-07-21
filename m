From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-tag.c: Fix two memory leaks and minor notation
 changes.
Date: Sat, 21 Jul 2007 14:08:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707211407450.14781@racer.site>
References: <46A1F858.7080405@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 15:08:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICEhV-0007W1-S2
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 15:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbXGUNIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 09:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbXGUNIi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 09:08:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:49352 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750903AbXGUNIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 09:08:38 -0400
Received: (qmail invoked by alias); 21 Jul 2007 13:08:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 21 Jul 2007 15:08:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BKdAcjt8BrQz8ASuvNCqImKzkAYiD/zpYGMSQKi
	AE7RFDTCbeKEt6
X-X-Sender: gene099@racer.site
In-Reply-To: <46A1F858.7080405@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53165>

Hi,

On Sat, 21 Jul 2007, Carlos Rica wrote:

> A repeated call to read_sha1_file was not freing memory
> when the buffer was allocated but returned size was zero.
> 
> Also, now the program does not allow many -F or -m options,
> which was a bug too because it was not freing the memory
> allocated for any previous -F or -m options.
> 
> Tests are provided for ensuring that only one option
> -F or -m is given. Also, another test is shipped here,
> to check that "git tag" fails when a non-existing file
> is passed to the -F option, something that git-tag.sh
> allowed creating the tag with an empty message.
> 
> Signed-off-by: Carlos Rica <jasampler@gmail.com>

Thank you very much!

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ciao,
Dscho
