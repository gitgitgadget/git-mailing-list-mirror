From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Mon, 22 Sep 2008 10:29:06 +0200
Message-ID: <48D75752.2050409@isy.liu.se>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jonathan del Strother <maillist@steelskies.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Sep 22 10:30:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhgoH-0006FN-6z
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 10:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbYIVI3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 04:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbYIVI3M
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 04:29:12 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:54423 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYIVI3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 04:29:11 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 34AB125A5A;
	Mon, 22 Sep 2008 10:29:08 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 18339-08; Fri,  4 Jul 2008 02:08:55 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 728AC25A52;
	Mon, 22 Sep 2008 10:29:07 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96458>

On 09/19/2008 12:47 AM, Brandon Casey wrote:
> The 'non-GNU' part of this basic RE to extended RE conversion means '\\s' was
> converted to ' '.

I've tested the converted BibTeX pattern and it seems to work as expected.

/Gustaf
