From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016 Microproject
Date: Mon, 29 Feb 2016 16:51:22 +0100
Message-ID: <vpqfuwbbjlx.fsf@anie.imag.fr>
References: <56D19EF9.3070702@gmail.com> <vpq8u26qo3y.fsf@anie.imag.fr>
	<56D1BEC8.9010302@gmail.com> <vpq1t7yqgi4.fsf@anie.imag.fr>
	<56D2C828.6010901@gmail.com> <vpqpovfblru.fsf@anie.imag.fr>
	<56D46493.4040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 16:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaQ70-0005Lb-HH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 16:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbcB2Pvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 10:51:39 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52058 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060AbcB2Pvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 10:51:37 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1TFpKEx005106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 29 Feb 2016 16:51:20 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1TFpM5K025599;
	Mon, 29 Feb 2016 16:51:22 +0100
In-Reply-To: <56D46493.4040909@gmail.com> (Sidhant Sharma's message of "Mon,
	29 Feb 2016 21:02:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Feb 2016 16:51:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1TFpKEx005106
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457365882.34512@NBfn94z6iMYYhLHkLwRvkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287846>

Sidhant Sharma <tigerkid001@gmail.com> writes:

>>> First, I'm not quite sure what to put in the help message for the
>>> options (--quiet, --stateless-rpc, --advertise-refs and
>>> --reject-thin-pack-for-testing).
>> They are currently undocumented. We sometimes have explicitly
>> undocumented options (PARSE_OPT_HIDDEN) when they are used only
>> internally to avoid polluting the end-user's UI.
>>
>> In this case, the command is anyway not meant for end-users so I think
>> it would make sense to document them, but not necessarily within the the
>> microproject.
> So what may I put in the message parameter? I was thinking
> perhaps the option itself, without hyphens. Would that be
> correct?

If you use PARSE_OPT_HIDDEN, I think you don't need to specify a
message. Otherwise, the documentation only has value if it contains more
than just the option name, but that is the hard part if you're not
familiar with the code. The best place to find documentation is in the
history (git blame the file and see if the commit message introducing
the option enlightens you). But that's why I said this didn't have to be
part of the microproject: writting good doc requires a good
understanding of the whole thing ...

>>> Should I make a patch for this and submit it for discussion on the mailing list?
>>
>> On this list, it is indeed often more efficient to say "here's what I'm
>> done. Any comments?" than "here's what I'm about to do".
>>
> I'm really sorry, I'm not very familiar with mailing list etiquettes.
> I'll keep that in mind :)

No problem. It's OK to say what you do beforehand and to ask help. Just
don't be surprised when you don't get much feedback on message not
starting with [PATCH] ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
