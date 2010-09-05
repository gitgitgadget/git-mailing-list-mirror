From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Sun, 5 Sep 2010 21:49:29 +0300
Message-ID: <20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100905174105.GB14020@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 20:47:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsKFW-0003Yr-25
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 20:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab0IESrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 14:47:24 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:58997 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0IESrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 14:47:24 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 8141213B324;
	Sun,  5 Sep 2010 21:47:22 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0780373272; Sun, 05 Sep 2010 21:47:22 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 3C75E27D85;
	Sun,  5 Sep 2010 21:47:18 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100905174105.GB14020@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155474>

On Sun, Sep 05, 2010 at 12:41:06PM -0500, Jonathan Nieder wrote:
> 
> For this specific error, why can't gitolite use an HTTP response code?
> Should http-backend be using ERR is some places, too, a la [1]?

I wanted this error to be sent in manner that causes old clients to print
the error, even if sightly mangled (the ERR of "true smart transports" does
also have this property).

AFAIK, HTTP errors don't have descriptions printed.
 
-Ilari
