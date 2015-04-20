From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] test-lib-functions.sh: fix the second argument to some helper functions
Date: Mon, 20 Apr 2015 13:03:30 +0200
Message-ID: <vpqa8y3giyl.fsf@anie.imag.fr>
References: <1429193527-1528-1-git-send-email-gitter.spiros@gmail.com>
	<vpqoamop28y.fsf@anie.imag.fr>
	<xmqq8udrizmk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 13:03:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk9UX-0008AP-DL
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 13:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbbDTLDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 07:03:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45230 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854AbbDTLDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 07:03:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3KB3Tmo031718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Apr 2015 13:03:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3KB3V9B005781;
	Mon, 20 Apr 2015 13:03:31 +0200
In-Reply-To: <xmqq8udrizmk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 16 Apr 2015 13:31:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 20 Apr 2015 13:03:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3KB3Tmo031718
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1430132614.94139@Dha2A06Ju8ORgaO7vyO9cg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267463>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>>
>>> --- a/t/test-lib-functions.sh
>>> +++ b/t/test-lib-functions.sh
>>> @@ -478,7 +478,7 @@ test_external_without_stderr () {
>>>  test_path_is_file () {
>>>  	if ! test -f "$1"
>>>  	then
>>> -		echo "File $1 doesn't exist. $*"
>>> +		echo "File $1 doesn't exist. $2"
>>>  		false
>>>  	fi
>>>  }
>>> @@ -486,7 +486,7 @@ test_path_is_file () {
>>>  test_path_is_dir () {
>>>  	if ! test -d "$1"
>>>  	then
>>> -		echo "Directory $1 doesn't exist. $*"
>>> +		echo "Directory $1 doesn't exist. $2"
>>>  		false
>>>  	fi
>>>  }
>>
>> Sounds straightforwardly correct to me.
>
> Thanks.  This however makes me wonder why you were nominated for
> reviewing this patch, though...

It seems I'm the one who introduced the bug indeed, in 2caf20c52b7f6.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
