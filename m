From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 2/4] Submodules: Add the lib-submodule-update.sh test
 library
Date: Thu, 17 Apr 2014 23:30:04 +0200
Message-ID: <535047DC.2000809@web.de>
References: <5331B6F6.60501@web.de> <5331B741.6000606@web.de>	<20140417164138.GP21805@odin.tremily.us> <xmqq38hbep5v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	Ronald Weiss <weiss.ronald@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WattF-0000rS-P9
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 23:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbaDQVa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 17:30:27 -0400
Received: from mout.web.de ([212.227.15.3]:50905 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbaDQVaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 17:30:22 -0400
Received: from [192.168.178.41] ([79.193.68.183]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MD8VY-1WieiP43x6-00GW80; Thu, 17 Apr 2014 23:30:06
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq38hbep5v.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:AGnnd9fCUJKuypoZyBm6sT1txLGg5IIzXHlpT9b5A4KcnSZtJ64
 gBbJQRMK2rZdJwfGRuhOkI0XBaWDfTbeRgffIw8TeRlJ0z9o1bgXde89oB1NC+qm8Bp/OC/
 z+w3d3KJeB0OWRXkp1xf20EcvZRDNSof810ZAXZJqtCkePY7xZ8joWUFlcq8bLg/rJHdECS
 iRq5e9XCER2I8t0aUaXJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246453>

Am 17.04.2014 21:23, schrieb Junio C Hamano:
> "W. Trevor King" <wking@tremily.us> writes:
> 
>> There have been a number of submodule series in
>> flight recently, and I'm having trouble keeping track of them all ;).
> 
> Unfortunately I share that same feeling X-<.
> 
> Could you guys collectively summarize what issues each of these
> in-flight topics try to address and how, how close it is to achieve
> concensus, and how it interact with other proposed topics?

I'm aware of these topics:

- My 4 "Never ignore staged but ignored submodules" patches

  I recall that everyone agreed that this is a good change.

- Johan's "Test various 'git submodule update' scenarios"

  Intended to document current behavior of the submodule.<name>.branch
  setting (and others) as a starting point for a discussion of how
  that could (and should) evolve. Needs some cooking.

- My "submodule test harness" RFC series (currently 14 patches)

  Similar to Johan's patch I try to document the current behavior
  of Git, but with the focus on all work tree manipulating commands
  (not only 'submodule update' handling all submodule changes. Will
  send to the list again when I resolved the last outstanding issues,
  current state can be seen in the submodule-test-harness branch of
  my GitHub repo. My next to-be-finished topic.

- Ronald's two "Teach add and commit the --ignore-submodules option"
  options

  Will review v4 soonish, looking good from the first cursory look.

- My "recursive submodule checkout" series

  Needs to be rerolled, I intend to extend my "submodule test harness"
  to cover all relevant scenarios for this series.

- Heiko's "config cache for submodules" patch

  Needed for my recursive checkout series to populate new submodules.

And then a not yet surfaced "do not replace submodules with a file"
fix I intend to send between the "submodule test harness" and the
"recursive submodule checkout" series.

Hope that makes it clearer ;-)
