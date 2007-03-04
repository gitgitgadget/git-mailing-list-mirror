From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Sending a thread of patches
Date: Mon, 5 Mar 2007 00:44:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703050030210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45EB4F98.7030206@issaris.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Panagiotis Issaris <takis@issaris.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO0NS-0007b3-HO
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 00:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbXCDXoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 18:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbXCDXoW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 18:44:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:46195 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752536AbXCDXoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 18:44:22 -0500
Received: (qmail invoked by alias); 04 Mar 2007 23:44:20 -0000
X-Provags-ID: V01U2FsdGVkX1/mVMYIw1rmyNq7Qsx4O9VQPGGuAIcFQ6SrOIcS65
	5ct6xwr4pyPHMs
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EB4F98.7030206@issaris.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41390>

Hi,

On Mon, 5 Mar 2007, Panagiotis Issaris wrote:

> I am trying to send a thread of patches to a mailinglist but the e-mails do
> not show up as one thread in some mailclients.
> Gmane shows the patches nicely in one thread [1], but Thunderbird shows all of
> them _except one_ as a thread. E-mail [PATCH 02/31]
> does not show up in the thread but beside it.

This might be related to the fact that you have two (!) In-Reply-To: 
headers. See:

http://article.gmane.org/gmane.comp.video.ffmpeg.devel/45716/raw

to verify.

> These are the commands I used:
> git format-patch --thread --attach -n origin..or2
> git-send-email --no-chain-reply-to --to ffmpeg-devel@mplayerhq.hu  --from
> takis.issaris@uhasselt.be --subject "[PATCH 00/31] Various Doxygen related
> patches"  --suppress-from --compose 00*patch

I have the impression from reading git-send-email that a second 
In-Reply-To: header is set if --chain-reply-to _or_ no --in-reply-to is 
specified. Since you do not have an --in-reply-to in your command line, I 
guess it is that.

However, I do not claim that I understand _why_ this is the behaviour, nor 
that I ever used git-send-email.

Ciao,
Dscho
