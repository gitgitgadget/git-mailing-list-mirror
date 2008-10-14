From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: retrieving a diff from git
Date: Tue, 14 Oct 2008 19:56:36 +0200
Message-ID: <vpqfxmz5acr.fsf@bauges.imag.fr>
References: <20081014145112.GR22427@vanheusden.com>
	<81b0412b0810141001w46227afam70123237025a2d4d@mail.gmail.com>
	<20081014172048.GW22427@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Folkert van Heusden <folkert@vanheusden.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 20:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpoQV-0004Iy-Fq
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 20:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbYJNSOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 14:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYJNSOE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 14:14:04 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:44121 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbYJNSOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 14:14:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m9EIBl6b012349;
	Tue, 14 Oct 2008 20:11:52 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kpo8K-0005Il-Rq; Tue, 14 Oct 2008 19:56:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kpo8K-0001O5-PX; Tue, 14 Oct 2008 19:56:36 +0200
In-Reply-To: <20081014172048.GW22427@vanheusden.com> (Folkert van Heusden's message of "Tue\, 14 Oct 2008 19\:20\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 14 Oct 2008 20:11:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98206>

Folkert van Heusden <folkert@vanheusden.com> writes:

>> but ... Have you considered using Git for that?
>
> and check out the whole tree using Git? I did consider but then I would
> not have all bells and whistles to generate a Debian kernel package.

You can probably clone the Kernel repository, generate a huge diff
with git diff, and apply it to your Debian tree with patch or
git apply, but if the patch serie is not based on your tree, this
won't help with conflicts.

-- 
Matthieu
