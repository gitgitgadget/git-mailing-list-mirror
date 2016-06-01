From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 07:48:12 +0200
Message-ID: <574E771C.7030009@kdbg.org>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 07:48:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7z0u-0001kK-TZ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 07:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305AbcFAFsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 01:48:16 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:60340 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757183AbcFAFsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 01:48:16 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rKKCK3XHTz5tlJ;
	Wed,  1 Jun 2016 07:48:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 7211F52A6;
	Wed,  1 Jun 2016 07:48:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160601033139.GB5411@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296053>

Am 01.06.2016 um 05:31 schrieb Jeff King:
> 	printf '%s' "$1" | sed "s/'/'\\\\''/g"
...
> 	export -p | grep "^declare -x $1="
...
> 					"$fake_env_var_=$(shellquote "$fake_env_orig_")"
...
> 			eval "$fake_env_var_=$(shellquote "$fake_env_val_")"

An intolerable number of new processes... Please stop this mental exercise.

-- Hannes
