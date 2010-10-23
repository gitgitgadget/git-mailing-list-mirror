From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 03/10] Change remote tracking to remote-tracking in non-trivial places
Date: Sat, 23 Oct 2010 21:04:14 +0200
Message-ID: <vpqpqv0loi9.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-4-git-send-email-Matthieu.Moy@imag.fr>
	<20101023184429.GG21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:07:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jRb-00075c-DN
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646Ab0JWTHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:07:48 -0400
Received: from imag.imag.fr ([129.88.30.1]:63180 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932634Ab0JWTHq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:07:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9NJ4F33014358
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 21:04:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P9jO3-0007oI-0q; Sat, 23 Oct 2010 21:04:15 +0200
In-Reply-To: <20101023184429.GG21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 13\:44\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 23 Oct 2010 21:04:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159817>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --- a/Documentation/everyday.txt
>> +++ b/Documentation/everyday.txt
>> @@ -180,12 +180,12 @@ directory; clone from it to start a repository on the satellite
>>  machine.
>>  <2> clone sets these configuration variables by default.
>>  It arranges `git pull` to fetch and store the branches of mothership
>> -machine to local `remotes/origin/*` tracking branches.
>> +machine to local `remotes/origin/*` remote-tracking branches.
>
> I find this scans better as "tracking branches", but consistent use of
> jargon might trump that.  Maybe it could be reworded somehow?
>
> 	<2> clone sets these configuration variables by default.
> 	They arrange for `git pull` to fetch and store the branches
> 	of the mothership machine to local `remotes/origin/*` tracking
> 	refs.
>
> Not sure.  remotes/origin/* are not branches for local development, so
> calling them "branches" without a "remote-tracking" caveat can be
> confusing.

That's not terribly important, since we already have "tracking" in the
sentence, and `remotes/origin/*` to make it unambiguous, but I tend to
prefer using the exact same wording everywhere.

What do other think?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
