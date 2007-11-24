From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC/PATCH] git-help: add new options -w (for web) and -i (for info)
Date: Sat, 24 Nov 2007 19:23:10 +0100
Message-ID: <vpqlk8nv6y9.fsf@bauges.imag.fr>
References: <20071124051650.07fd275f.chriscool@tuxfamily.org>
	<20071124113421.GB2948@steel.home> <47482116.70600@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 24 19:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvzfZ-0004RM-Jz
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 19:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbXKXSXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 13:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbXKXSXj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 13:23:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:38620 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbXKXSXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 13:23:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAOINAQa020511
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 24 Nov 2007 19:23:10 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ivzeo-0005lj-Ek; Sat, 24 Nov 2007 19:23:10 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ivzeo-0005Bc-CF; Sat, 24 Nov 2007 19:23:10 +0100
In-Reply-To: <47482116.70600@op5.se> (Andreas Ericsson's message of "Sat\, 24 Nov 2007 14\:03\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 24 Nov 2007 19:23:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65956>

Andreas Ericsson <ae@op5.se> writes:

> Alex Riesen wrote:
>> Christian Couder, Sat, Nov 24, 2007 05:16:50 +0100:
>>> +valid_tool() {
>>> +	case "$1" in
>>> +		firefox | iceweasel | konqueror | w3m)
>>> +			;; # happy
>>
>> lynx, links and dillo?
>>
>
> Why bother validating it at all? I might be using a script to
> add some formatting and then pass it through the browser of my
> choice. A friend of mine who's visually impaired does just that
> to strip some CSS tags which can make docs quite unreadable for
> him.

In any case, make sure it's consistant with git instaweb, which also
runs a web browser (firefox by default, overridable with --browser or
instaweb.browser).

-- 
Matthieu
