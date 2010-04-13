From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [PATCHv2] pretty: Initialize notes if %N is used
Date: Tue, 13 Apr 2010 12:36:11 +0200
Message-ID: <20100413103611.GA4181@dualtron.lan>
References: <20100412085647.GA26840@coredump.intra.peff.net>
 <1271149186-30156-1-git-send-email-heipei@hackvalue.de>
 <20100413100304.GA29101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Git ML <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Gilger <heipei@hackvalue.de>,
	Jeff King <peff@peff.net>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 12:35:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1dTI-0003uj-Va
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 12:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab0DMKfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 06:35:50 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:43285 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0DMKfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 06:35:50 -0400
Received: from u-7-037.vpn.rwth-aachen.de ([137.226.103.37]:60482 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O1dT1-0003Ko-Mq; Tue, 13 Apr 2010 12:35:39 +0200
Content-Disposition: inline
In-Reply-To: <20100413100304.GA29101@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.103.37
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144808>

On 13/04/10 06:03, Jeff King wrote:
> This version looks good to me.
Hm, I still found one mistake: Using %+N or %-N without --show-notes
doesn't work. I'll have a look at how to fix this. If Junio want's to go
ahead this can also be done in a second patch.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0xD47A7FFC
GPG-Fingerprint: 5441 D425 6D4A BD33 B580  618C 3CDC C4D0 D47A 7FFC
