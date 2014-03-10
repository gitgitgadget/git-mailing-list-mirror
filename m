From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit/reword/delete a single commit
Date: Mon, 10 Mar 2014 09:41:04 +0100
Message-ID: <vpqd2huh2e7.fsf@anie.imag.fr>
References: <53159601.8020702@alum.mit.edu>
	<1394333354-16257-1-git-send-email-pclouds@gmail.com>
	<531D7820.1090403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, philipoakley@iee.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:41:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMvm2-0001W6-CR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 09:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbaCJIlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 04:41:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48492 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaCJIlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 04:41:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2A8f4uX012514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Mar 2014 09:41:04 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2A8f50i016721;
	Mon, 10 Mar 2014 09:41:05 +0100
In-Reply-To: <531D7820.1090403@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 10 Mar 2014 09:30:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Mar 2014 09:41:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2A8f4uX012514
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395045668.04905@4jif8mIP+3ftzdn1T/gv/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243715>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> @@ -290,6 +294,7 @@ do
>>  		;;
>>  	--autostash)
>>  		autostash=true
>> +		explicit_autosquash=t
>
> Should that be "explicit_autostash"?

My guess is: no, but it should be below the --autoquash case, not this
one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
