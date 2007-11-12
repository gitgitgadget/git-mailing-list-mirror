From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 17:41:57 +0100
Message-ID: <vpq3avbv2ju.fsf@bauges.imag.fr>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcNi-0007QS-EQ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbXKLQnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbXKLQnK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:43:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:44268 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314AbXKLQnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:43:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lACGg5Oc024004
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Nov 2007 17:42:06 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IrcMH-00017f-Mu; Mon, 12 Nov 2007 17:41:57 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IrcMH-0006HB-KO; Mon, 12 Nov 2007 17:41:57 +0100
In-Reply-To: <Pine.LNX.4.64.0711121624330.4362@racer.site> (Johannes Schindelin's message of "Mon\, 12 Nov 2007 16\:34\:46 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 12 Nov 2007 17:42:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64659>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 12 Nov 2007, Jan Wielemaker wrote:
>
>> I found out that cloning a empty bare repository produces nothing at 
>> all, [...]
>
> If they are empty, what exactly do you mean to clone?

I'd expect an empty repository, with the git remote configured
correctly.

I already mentionned this here (but didn't take time to write a
patch), a typical use-case is when I want to create a new project. I'd
like to initialize an empty bare repo on my backed up disk, and then
clone it to my local-fast-unreliable disk to get a working copy and do
the first commit there.

Currently, I have to create both independantly, and configure the
remote myself. Not terrible, but not conveinient either ;-).

-- 
Matthieu
