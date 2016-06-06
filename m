From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH v3 1/3] doc: clearer rule about formatting literals
Date: Mon, 6 Jun 2016 17:38:09 +0200
Message-ID: <c31c7d1c-fac9-45f6-b53c-842cab16eacb@grenoble-inp.org>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
 <20160606100905.23006-1-tom.russello@grenoble-inp.org>
 <20160606100905.23006-2-tom.russello@grenoble-inp.org>
 <vpqmvmyo2w9.fsf@anie.imag.fr> <vpq8tyio2lu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 17:38:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wba-0001Or-Qa
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbcFFPiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:38:14 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:55197 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcFFPiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 11:38:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D828820AE;
	Mon,  6 Jun 2016 17:38:10 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CL47A3DsKveC; Mon,  6 Jun 2016 17:38:10 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C7A6520A5;
	Mon,  6 Jun 2016 17:38:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id C1F9A2066;
	Mon,  6 Jun 2016 17:38:10 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UpwnvKTBw2gA; Mon,  6 Jun 2016 17:38:10 +0200 (CEST)
Received: from [130.190.33.212] (eduroam-033212.grenet.fr [130.190.33.212])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7A2FF2055;
	Mon,  6 Jun 2016 17:38:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <vpq8tyio2lu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296521>

On 06/06/16 15:42, Matthieu Moy wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Tom Russello <tom.russello@grenoble-inp.org> writes:
>>> + Literal examples (e.g. use of command-line options, command names,
>>> + configuration and environment variables) must be typeset in monospace (i.e.
>>> + wrapped with backticks):
>>>     `--pretty=oneline`
>>>     `git rev-list`
>>>     `remote.pushDefault`
>>> +   `GIT_DIR`
>>
>> Don't you want `$GIT_DIR` here?

No, I didn't as we can find both of them in the documentation and
because there is no guideline about this.

> Actually, not really. The use (which seems rather consistant) is to say
> "The `GIT_...` environment variable" when referring to the variable, and
> to use $GIT_... when referring to its value, like in "`$GIT_DIR/hooks`
> directory".

I think this is the more intuitive solution as well.

> It makes sense since not all systems use $ (AFAIK, Windows uses
> %variable% where POSIX uses $variable), so it's best to use a neutral
> syntax when possible. OTOH, writting `GIT_DIR/hooks` without the $ would
> be really confusing as one could read it as the literal string
> `GIT_DIR`.
> 
> I think this rule (when to use $ and when not to use it) deserves to be
> clarified here too.

Ok, I add this to the CodingGuidelines file.
