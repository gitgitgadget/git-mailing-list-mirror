From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v2 4/4] teach config parsing to read from strbuf
Date: Mon, 18 Mar 2013 15:18:28 +0100
Message-ID: <51472234.2060207@hvoigt.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box> <20130310170052.GE1136@sandbox-ub.fritz.box> <20130312111806.GF11340@sigill.intra.peff.net> <20130312164254.GB4752@sandbox-ub.fritz.box> <20130312192959.GG17099@sigill.intra.peff.net> <20130314063933.GB4062@sandbox-ub.fritz.box> <20130314071046.GB6103@sigill.intra.peff.net> <20130314073913.GA7024@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 15:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHatz-0001z7-ON
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 15:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab3CROSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 10:18:36 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:36619 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3CROSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 10:18:35 -0400
Received: from [93.166.190.40] (helo=[192.168.1.28])
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UHatS-0003fh-IE; Mon, 18 Mar 2013 15:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130314073913.GA7024@sigill.intra.peff.net>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218416>

Hi Peff,

On Thu, Mar 14, 2013 at 03:39:14AM -0400, Jeff King wrote:
> On Thu, Mar 14, 2013 at 03:10:46AM -0400, Jeff King wrote:
>
> > I looked into this a little. The first sticking point is that
> > git_config_with_options needs to support the alternate source. Here's a
> > sketch of what I think the solution should look like, on top of your
> > patches.
>
> Here it is again, with two changes:
>
>   1. Rather than handling the blob lookup inline in
>      git_config_with_options, it adds direct functions for reading
>      config from blob sha1s and blob references. I think this should
>      make it easier to reuse when you are trying to read .gitmodules
>      from C code.
>
>   2. It adds some basic tests.
>
> I'll leave it here for tonight. The next step would be to rebase it on
> your modified series (in particular, I think git_config_from_strbuf
> should become git_config_from_buf, which will impact this).
>
> Feel free to use, pick apart, rewrite, or discard as you see fit for
> your series.

Sorry for the late reply, I was not online during the last days. Thanks 
a lot for this. I will use it in the next iteration of the series.

Cheers Heiko
