From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 04/14] appp.sh: use the $( ... ) construct for command substitution
Date: Mon, 28 Apr 2014 20:07:30 +0200
Message-ID: <vpqmwf572fx.fsf@anie.imag.fr>
References: <1398260646-2660-1-git-send-email-gitter.spiros@gmail.com>
	<1398260646-2660-4-git-send-email-gitter.spiros@gmail.com>
	<20140425225843.GA238861@vauxhall.crustytoothpaste.net>
	<xmqq61lts5m9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer1C-0003SK-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbaD1TMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:12:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34681 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085AbaD1TMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:12:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3SI7Snd007380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2014 20:07:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3SI7U21011457;
	Mon, 28 Apr 2014 20:07:30 +0200
In-Reply-To: <xmqq61lts5m9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Apr 2014 10:53:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Apr 2014 20:07:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3SI7Snd007380
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399313253.67@piZWyZfgH1WQvJgL6z5Q0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247393>

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>>>  CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>>>  	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
>>
>> It looks like you may have missed a usage here due to the line break.
>
> Good eyes ;-)
>
> The following may be an obvious replacement patch, but alternatively
> we could just drop the whole thing (contrib/ material is not
> something we would need to police strictly for the style---nobody
> should be mimicking their styles as they are not part of _our_
> codebase in the first place).

My vote goes for keeping the patch as it is, so that future people
grepping for `...` construct do not find any after the series is
finished.

(and because it's simple to do)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
