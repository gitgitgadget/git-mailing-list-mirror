From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [RFC-PATCH 0/2] send-email: new --quote-mail option
Date: Mon, 23 May 2016 21:56:30 +0200
Message-ID: <211e812b-e61b-09c5-2030-38cd4f73136c@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <vpqlh30d0p1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon May 23 22:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4w4x-00086z-1S
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 22:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbcEWUDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 16:03:51 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:49555 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbcEWUDu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 16:03:50 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 May 2016 16:03:50 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A1F98210B;
	Mon, 23 May 2016 21:56:31 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mReBp2P5BKn7; Mon, 23 May 2016 21:56:31 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 90AE4210A;
	Mon, 23 May 2016 21:56:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8A8AE2077;
	Mon, 23 May 2016 21:56:31 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4OMlqV9SZyt; Mon, 23 May 2016 21:56:31 +0200 (CEST)
Received: from linux.home (LFbn-1-8166-195.w90-112.abo.wanadoo.fr [90.112.75.195])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 2C10F2066;
	Mon, 23 May 2016 21:56:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpqlh30d0p1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295386>



On 05/23/2016 09:38 PM, Matthieu Moy wrote:
> Tom Russello <tom.russello@grenoble-inp.org> writes:
>
>> Hello,
>>
>> With the current send-email command, you can send a series of patches "in reply
>> to" an email.
>> This patch adds a new option to `git send-email`, `--quote-mail=<file>`, to
>
> I think the option name should be --quote-email. Even though "mail"
> usually means "email" for French people, there's still non-electronic
> mail for english-speaking ones.

That makes sense, all occurrences of "mail" will be changed into "email" 
for v2.

Thanks for your feedback !
