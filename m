From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4 v2] Allow detached form (e.g. "-S foo" instead of "-Sfoo") for diff options
Date: Thu, 29 Jul 2010 09:19:16 +0200
Message-ID: <vpqeiemoivf.fsf@bauges.imag.fr>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
	<1280310062-16793-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100729020031.GI29156@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 09:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeNPD-0004qw-8Q
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 09:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab0G2HTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 03:19:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51538 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699Ab0G2HTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 03:19:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6T794wR012810
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Jul 2010 09:09:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OeNOe-0003c1-RY; Thu, 29 Jul 2010 09:19:16 +0200
In-Reply-To: <20100729020031.GI29156@dert.cs.uchicago.edu> (Jonathan Nieder's message of "Wed\, 28 Jul 2010 21\:00\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Jul 2010 09:09:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6T794wR012810
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280992146.34705@YTOvMZfe9em3Fu5SgltLEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152163>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	} &&
>> +	test "$actual" = "$actual_detached" || {
>> +		echo Oops. Detached form broken
>> +		echo "Actual_detached: $actual_detached"
>>  	}
>
> You left out the crucial "false"! :)

Oups, right.

> Below is an add-on patch to use a more readable style.

I was mimicking the style right above, but that makes sense to
clean-up while we're there, yes. I'll squash your change in the next
serie.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
