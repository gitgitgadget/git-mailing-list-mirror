From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 01/18] advice: Introduce error_resolve_conflict
Date: Mon, 25 Jul 2011 17:17:40 -0400
Message-ID: <4E2DDD74.1090909@cisco.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com> <1311095876-3098-2-git-send-email-artagnon@gmail.com> <4E284750.4040104@cisco.com> <20110722223555.GB19620@sigill.intra.peff.net> <7vaac3wnnu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 23:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlSX8-0006aT-LV
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 23:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab1GYVRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 17:17:46 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:2922 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab1GYVRo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 17:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=920; q=dns/txt;
  s=iport; t=1311628664; x=1312838264;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=m0XI24K5kYfb1qyK/yRknGhHygNEUOLialJsP9JU2LA=;
  b=MkXS2hl0oqbo1Pss5IXKSJ/Gw7IobPVWhswzw+i+tkX6n+hR3whD16qd
   2Hai8bVWtZA0MUfJlyNO4eNt7z5CHorllpcHjptAg4hXP0heTn14FzY+D
   yGZzNQx90muaa1kF6K31gUK8J6OoFxtJHzl75kpU0MtMr55cGW9Oddepg
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAH3cLU6tJV2d/2dsb2JhbAA0AQEBAQMUAW8BEQwYCSIPCQMCAQIBAlEHDgEIBgEBH6c0d6sjnjWGPwSScIUHgyqISw
X-IronPort-AV: E=Sophos;i="4.67,264,1309737600"; 
   d="scan'208";a="6264837"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP; 25 Jul 2011 21:17:42 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-6.cisco.com (8.14.3/8.14.3) with ESMTP id p6PLHgq2032134;
	Mon, 25 Jul 2011 21:17:42 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <7vaac3wnnu.fsf@alter.siamese.dyndns.org>
X-TagToolbar-Keys: D20110725171740539
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177818>

On 07/24/2011 02:15 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> Still, I think I find it more readable without the comma, and better
>> still if every spot were converted to "hint: ". This question has come
>> up once or twice before, too, so I don't know that a patch removing the
>> commas would be out of line.
> Good to see that native speakers seem to think the comma there is funny.
I do, but I spent a fair amount of time finding out why before
complaining.  Wanted to make sure it wasn't a matter of taste.

"Please" is an adverb.  It modifies a verb or another adverb.  A comma
is used when the adverb is not adjacent to the target verb or adverb,
and in a few other odd conditions, none of which are met here.

"Please fix them up in the work tree."
"Fix them up in the work tree, please."
"Please, before committing these files, fix them up in the work tree."

Phil
