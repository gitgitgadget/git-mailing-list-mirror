From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: DOCBOOK_SUPPRESS_SP with docbook-sxl 1.71.0
Date: Tue, 27 Oct 2009 19:35:32 +0000
Message-ID: <4AE74B84.8090500@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, chris_johnsen@pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rri-00047V-9B
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbZJ0Thn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbZJ0Thm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:37:42 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:44257 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932075AbZJ0Thm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 15:37:42 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1N2rrS-0004vP-cS; Tue, 27 Oct 2009 19:37:43 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131378>

Hi Junio,

Whenever I install a new git, I always re-build the documentation
(on Linux) rather than use the pre-built html and manpages.
(BTW, I actually don't know why; it's just a habit now:)

>From the Documentation/Makefile, it seems there may be some
speculation if DOCBOOK_SUPPRESS_SP should be set when using the
docbook-xsl version 1.71.0.

I am using asciidoc version 7.1.2 along with docbook-xsl version
1.71.0, and I can confirm that setting DOCBOOK_SUPPRESS_SP is
required. (The manpages are *unusable* otherwise)

[I'm sorry, but I don't know the xmlto version number and I can't
get to my linux box ATM]

ATB,
Ramsay Jones
