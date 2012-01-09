From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Work around sed portability issue in t8006-blame-textconv
Date: Sun, 08 Jan 2012 22:40:44 -0500
Message-ID: <1326080292-sup-3735@pinkfloyd.chass.utoronto.ca>
References: <1325339068-6063-1-git-send-email-bwalton@artsci.utoronto.ca> <7vd3b0vc6h.fsf@alter.siamese.dyndns.org> <7vehvcigsy.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 04:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk66g-0003g0-6r
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 04:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2AIDkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 22:40:46 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:58494 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab2AIDkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 22:40:46 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:59022 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rk66G-0006ch-J3; Sun, 08 Jan 2012 22:40:44 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rk66G-00077d-I8; Sun, 08 Jan 2012 22:40:44 -0500
In-reply-to: <7vehvcigsy.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188154>

Excerpts from Junio C Hamano's message of Fri Jan 06 17:53:33 -0500 2012:

> Ping?

Sorry, I was out of email contact since last Sunday.  I'll look at
this tomorrow.  I think I tested the exit status from
/usr/xpg4/bin/sed on this file by hand and found that it was exiting
cleanly, but I'll verify and let you know.  If you're correct, I'll
adjust the commit message accordingly.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
