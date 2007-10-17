From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 21:47:05 +0200
Message-ID: <200710172147.06025.wielemak@science.uva.nl>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <1192645509.6640.21.camel@athena> <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiErl-0001Ee-6t
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbXJQTrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbXJQTrT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:47:19 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:3800 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbXJQTrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:47:18 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9HJl7eV086928;
	Wed, 17 Oct 2007 21:47:11 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61418>

On Wednesday 17 October 2007 20:54, Linus Torvalds wrote:
> On Wed, 17 Oct 2007, Tom Tobin wrote:
> > Or is "unix developers" code for "my sample size of one"?
>
> Well, let's put it this way: that "sample" is the one that started the
> project.
>
> I got to pick the license. Are you going to argue about that too? I got to
> pick the way I wrote the code. Are you going to continue arguing about
> that?
>
> The fact is, I don't see the people arguing for spaces having actually
> *done* anything for git. So why are you arguing?

Possibly because they do not want to cooperate :-) Anyway, it is mostly
a Unix <-> the rest issue. In the Unix world all tools by default use
8-spaces per tab and although most of them can be told otherwise, nobody
bothers. That way at least all code looks the same, regardless of spaces
or tabs. Many editors are smart enough to create sequences
N<TAB>+M<SPACE> for initial indentation to get consistent usage, but even
if it isn't consistent patch and diff can be told to handle it.

Outside the Unix world there appears to be little standard, so you receive
files with any combination of tab distance, using tabs vs. spaces, etc.
Most often I have to re-indent them before reading :-(

I guess the most ideal situation is to use only tabs for initial indentation
and spaces elsewhere, so changing the tab distance gets consistent layout.
The drawback is that there is no room for `half indentation', so style
conventions have to take care of that.

Still, the main developers take the decision.  If you don't like it, don't
cooperate or fork.

	--- Jan
