From: David Kastrup <dak@gnu.org>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 13:58:50 +0200
Message-ID: <85myypef7p.fsf@lola.goethe.zz>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
	<7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com>
	<20070624065008.GA6979@efreet.light.src>
	<200706241314.46238.robin.rosenberg.lists@dewire.com>
	<7vzm2ptw04.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 13:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Qkp-0000WF-NA
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 13:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbXFXL7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 07:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbXFXL7A
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 07:59:00 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:35292 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754260AbXFXL67 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 07:58:59 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 7744331F9AB;
	Sun, 24 Jun 2007 13:58:57 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 338B92793F9;
	Sun, 24 Jun 2007 13:58:57 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-092-238.pools.arcor-ip.net [84.61.92.238])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 17A91225127;
	Sun, 24 Jun 2007 13:58:53 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 020551C3EE46; Sun, 24 Jun 2007 13:58:50 +0200 (CEST)
In-Reply-To: <7vzm2ptw04.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun\, 24 Jun 2007 04\:47\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.90.3/3516/Sun Jun 24 11:39:42 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50795>

Junio C Hamano <gitster@pobox.com> writes:

> If I were to create a patch between two versions of such a file, the
> diff header would show the pathname encoded in one, and the changed
> contents would ben shown in another.  As long as you treat "git
> diff" output as binary blob, that would work just fine, but when you
> have to transmit such a diff in e-mail as an in-line patch, you
> would have troubles.

ASCII-armoring of what amounts to binary files is the task of the mail
software.  Also working with encodings.  Escaping characters in the
diff headers but not in the file contents is not going to achieve
anything useful, anyway.

With the proper mailing software, you can get your diff across the
line in a manner where the other side can make use of it.  This is not
the case for unarmored mail with ^ escapes in them, since the
receiving side can't distinguish them from "real" ^ characters.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
