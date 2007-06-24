From: David Kastrup <dak@gnu.org>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 21:47:48 +0200
Message-ID: <85ejk1cexn.fsf@lola.goethe.zz>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
	<200706241314.46238.robin.rosenberg.lists@dewire.com>
	<20070624162559.GC6979@efreet.light.src>
	<200706242139.44708.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 21:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Y48-00061L-Mc
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 21:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXFXTsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbXFXTsF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 15:48:05 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:48178 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbXFXTsC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 15:48:02 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 4D34417FB68;
	Sun, 24 Jun 2007 21:48:01 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 3C09E2DA969;
	Sun, 24 Jun 2007 21:48:01 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-092-238.pools.arcor-ip.net [84.61.92.238])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 5958D2351AC;
	Sun, 24 Jun 2007 21:47:59 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 94AB01C3EE46; Sun, 24 Jun 2007 21:47:48 +0200 (CEST)
In-Reply-To: <200706242139.44708.robin.rosenberg.lists@dewire.com> (Robin Rosenberg's message of "Sun\, 24 Jun 2007 21\:39\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.90.3/3517/Sun Jun 24 14:28:53 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50816>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> I was still in referernce to those "local conditions" at that
> point. It was not meant as a universal statement. Substitutute that
> for "A small bunch of swedish speaking people from Stockholm".

A wrong encoding is a wrong encoding.  Escaping the characters in
transition will not magically make the encodings adapt.  Escaping
characters buys us exactly zilch _unless_ the _channel_ is not 8-bit
clean.  In which case we should use a normal
mail-armoring/attachment/inline data wrapper.

In fact, when using editors with some heuristics regarding character
sets (like Emacs), leaving 8-bit characters intact gives the editor a
chance to guess the correct character set even if it is not the
default on the receiving end.

Escaping the characters, in contrast, just hides 8-bit usage away in
transition.  An escaped character in the wrong encoding will get
reconstituted into the wrong encoding.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
