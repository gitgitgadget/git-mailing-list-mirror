From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Thu, 22 Aug 2013 12:46:29 +0200
Message-ID: <5215EC05.4020605@kdbg.org>
References: <5213EF74.7020408@googlemail.com> <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com> <vpqhaeje8e0.fsf@anie.imag.fr> <5214B852.7090504@googlemail.com> <vpqvc2z8a68.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com, pclouds@gmail.com,
	iveqy@iveqy.com, gitster@pobox.com, mackyle@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 22 12:54:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCSX1-0000ke-5z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 12:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab3HVKyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 06:54:16 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:31501 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752503Ab3HVKyP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 06:54:15 -0400
Received: from [10.75.26.165] (178.115.250.165.wireless.dyn.drei.com [178.115.250.165])
	by bsmtp.bon.at (Postfix) with ESMTP id 376E3130052;
	Thu, 22 Aug 2013 12:54:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <vpqvc2z8a68.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232764>

Am 21.08.2013 15:07, schrieb Matthieu Moy:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> But as these follow up changes heavily rely on the very first patch
>> I will first try to get that right, meaning accepted into pu.
>> Then I can send patches with these proposals such as making more
>> functions.
>
> I think it's better to get the style right before, to avoid doubling the
> review effort (review a hard-to-review patch first, and then re-review a
> style-fix one).

If by "style fix" you mean "coding style fix", I agree.

But, IMO, refactoring the long function can wait because the long function 
is easier to compare to the shell script, and I think that is more 
important later when you need to dig the history.

It is already too late to save review effort.

-- Hannes
