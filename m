From: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sun, 02 Sep 2007 18:07:33 +0100
Message-ID: <87bqclngh6.fsf@hades.wkstn.nix>
References: <200709010925.27926.johannes.sixt@telecom.at>
	<7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
	<7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
	<85abs5v9q1.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 19:08:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsvt-0003hg-Oe
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 19:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbXIBRIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 13:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbXIBRIR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 13:08:17 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:54296 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbXIBRIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 13:08:16 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l82H7Y4v024303;
	Sun, 2 Sep 2007 18:07:35 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l82H7XJi031777;
	Sun, 2 Sep 2007 18:07:33 +0100
Emacs: ... it's not just a way of life, it's a text editor!
In-Reply-To: <85abs5v9q1.fsf@lola.goethe.zz> (David Kastrup's message of "Sun, 02 Sep 2007 08:53:58 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-dcc1-Metrics: hades 1182; Body=5 Fuz1=5 Fuz2=5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57368>

On 2 Sep 2007, David Kastrup uttered the following:
> As usual, <URL:info:autoconf#Limitations%20of%20Usual%20Tools> (aka as
> (info "(autoconf) Limitations of Usual Tools")
> ) provides a real horror show of sed variants.

A goodly number of things in that section of the Autoconf manual are
passing on hints and ancient legends that may or may not be accurate:
I've found a number of its descriptions of shell limitations to be
downright wrong (applying to one build of one shell back in 1981 that
was never shipped to anyone, that sort of thing).

(Of course it's valuable, even if it *is* a compendium of legends. But
confirming any of it is quite hard.)
