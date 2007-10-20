From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help option.
Date: Sun, 21 Oct 2007 01:28:46 +0300
Organization: Private
Message-ID: <odetifoh.fsf@blue.sea.net>
References: <bqaujirk.fsf@blue.sea.net>
	<Pine.LNX.4.64.0710202126430.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 03:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjPkx-0006wQ-Ea
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbXJUBhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbXJUBhU
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:37:20 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:60637 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXJUBhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:37:18 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2007 21:37:18 EDT
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 7AF6E13BE66;
	Sun, 21 Oct 2007 01:28:55 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A064D677A44; Sun, 21 Oct 2007 01:28:55 +0300
Received: from cante.net (a91-155-177-132.elisa-laajakaista.fi [91.155.177.132])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 485004BBC9;
	Sun, 21 Oct 2007 01:28:52 +0300 (EEST)
In-Reply-To: <Pine.LNX.4.64.0710202126430.25221@racer.site> (Johannes
	Schindelin's message of "Sat, 20 Oct 2007 21:28:50 +0100 (BST)")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61853>

* Sat 2007-10-20 Johannes Schindelin <Johannes.Schindelin@gmx.de> INBOX
> Hi,
>
> On Sat, 20 Oct 2007, Jari Aalto wrote:
>
>> - commented out call to list_common_cmds_help()
>
> If you're really sure that this is desired, do not comment it out.  Delete 
> it.

I'm sure.

There is no point of reminding *every* time you make a typo during
writing the commands. It fills half of the screen and obscures the
previous commands that were running. It's much more polite and elegant
in shorted form.

Jari

New patch follows.

-- 
Welcome to FOSS revolution: we fix and modify until it shines
