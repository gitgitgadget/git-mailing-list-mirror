From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] doc: clearer rule about formatting literals
Date: Mon, 06 Jun 2016 15:42:37 +0200
Message-ID: <vpq8tyio2lu.fsf@anie.imag.fr>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-2-tom.russello@grenoble-inp.org>
	<vpqmvmyo2w9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:42:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9uno-0007Eb-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 15:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcFFNmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 09:42:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40354 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbcFFNmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 09:42:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u56DgaJR027230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 15:42:36 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56DgbCW031895;
	Mon, 6 Jun 2016 15:42:37 +0200
In-Reply-To: <vpqmvmyo2w9.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	06 Jun 2016 15:36:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 06 Jun 2016 15:42:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56DgaJR027230
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465825358.90112@0uExoWpT7Z1neEDAbWy93Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296509>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tom Russello <tom.russello@grenoble-inp.org> writes:
>
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -526,12 +526,13 @@ Writing Documentation:
>>   modifying paragraphs or option/command explanations that contain options
>>   or commands:
>>  
>> - Literal examples (e.g. use of command-line options, command names, and
>> - configuration variables) are typeset in monospace, and if you can use
>> - `backticks around word phrases`, do so.
>> + Literal examples (e.g. use of command-line options, command names,
>> + configuration and environment variables) must be typeset in monospace (i.e.
>> + wrapped with backticks):
>>     `--pretty=oneline`
>>     `git rev-list`
>>     `remote.pushDefault`
>> +   `GIT_DIR`
>
> Don't you want `$GIT_DIR` here?

Actually, not really. The use (which seems rather consistant) is to say
"The `GIT_...` environment variable" when referring to the variable, and
to use $GIT_... when referring to its value, like in "`$GIT_DIR/hooks`
directory".

It makes sense since not all systems use $ (AFAIK, Windows uses
%variable% where POSIX uses $variable), so it's best to use a neutral
syntax when possible. OTOH, writting `GIT_DIR/hooks` without the $ would
be really confusing as one could read it as the literal string
`GIT_DIR`.

I think this rule (when to use $ and when not to use it) deserves to be
clarified here too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
