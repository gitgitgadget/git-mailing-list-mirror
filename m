From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix `git rev-list --show-notes HEAD` when there are no
 notes
Date: Mon, 24 Aug 2015 16:48:34 +0200
Organization: gmx
Message-ID: <4855e31e35814e066cee2cd7fe7e82be@www.dscho.org>
References: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
 <20150823174309.GA24735@sigill.intra.peff.net>
 <98f2f674e384ac3af38e305165135a60@www.dscho.org>
 <20150824144328.GA2151@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:48:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTt3N-0000wU-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 16:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbbHXOso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 10:48:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:60903 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbbHXOsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 10:48:42 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MLelb-1ZT3pu1Rhr-000udR; Mon, 24 Aug 2015 16:48:37
 +0200
In-Reply-To: <20150824144328.GA2151@sigill.intra.peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:yNTqVvE0Gs1z/jAypTMY+hcwluIGonzKk3FtXsOFDzVMoHTIUra
 zA8yrUCZzXv/oz4fwl5139tVc9WzoXsc6iK85A68Ua6J1Ky08JvdxdglawVIN0sSsLy3k5Y
 J8bdJpn6TV08M6X/dw2HmBdT9Ztt8A2VzxsvehVRFiFrxrA4Jr6+2JHd8/+/+De1mEzyuS0
 gWKtSnX8IBfUDLUE8Z2zQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6Y/BJL5t4J4=:Bs9gyseIeHaQgHlF4R1OVN
 DsRCVO7ck/9zvlodACrg89EAXM1DyX9xHNBsZ3UZWpQ3oikyxHe7vegEQw7gvuSwanOxIwMzN
 b6MieEIZlgnX2d5S3SuOelWT1ULa8bi7Zo2RL8lxBwhORJg02HnCuOSTjtjQa3nQ5IyXqJb2l
 nDR3EqNODGU9c33xOKiSW2Osn5Ov3WgeXciYqFwrojys9kErY/Rp/xIUXOiayPrZG0L0h3mE2
 FAysd2EK7SsRoS6//cWAIdscdDkxr9FSkNSpVPC6bNan+6zfqpj1ifcurACyCK8+LPEgGyPgP
 qLqPe+2yU3ZAJm7axpgz61vo+PEpNGG6bx+fnbzNvvPAuHbaEHhBrLikVtB4/YqZ+RuNMwEki
 mxaxKVg7FxaP7h34+VsmDKHE0XtQJJk2KEhgirDqvc2NDpgN2Q4MOu8LDXDA+HUoYwoTfhC2M
 u7CHjwyvnTJJ8etUyOqbhE6CvTbkUVoXMgIGy0iLL5+kKaRtFs7yIzzlyPWHIJo/78JtvRKu3
 MzM262LSgguBkxQZmQXAdynrlW2HsiH+TrOy1yq0W604oOYpg3rzaZ1lE2HvIyFrSkt4C8hJU
 Q0IJkxa422igDBjWMyozGj3whesDn0Erzy9MY7anENZY84uztw4ByCIpM+k1bqY+90OAkvqWJ
 nrCZjUbo4feBI9oboZmm+w4KCAzGbMcPm/YmkdQyy69SZkB43kXXYs8fhpYMGwGUiCrVLt0+g
 uTuNDBmnhVyE9efUxlD3B8RO/rg9KbpJJLoeng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276449>

Hi Peff,

On 2015-08-24 16:43, Jeff King wrote:
> On Mon, Aug 24, 2015 at 12:23:52PM +0200, Johannes Schindelin wrote:
> 
>> You're right. I think the best approach for now is to error out when
>> `--show-notes` is passed to rev-list. Do you agree?
> 
> Yes (I imagine you didn't yet read my follow-up patch when you wrote
> this). :)

Yep, and I forgot to reply when I saw it. Thanks for continuing on that front!

Ciao,
Dscho
