From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] symbolic-ref: check format of given reference
Date: Mon, 18 Jun 2012 14:02:45 +0200
Message-ID: <4FDF18E5.7020908@elegosoft.com>
References: <4FDE3D7D.4090502@elegosoft.com> <7vaa017j51.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 14:04:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgahK-0004rt-LX
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 14:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab2FRMEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 08:04:42 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:42681 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab2FRMEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 08:04:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id E1DD8DE827;
	Mon, 18 Jun 2012 14:04:40 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snNSPFLKSEkV; Mon, 18 Jun 2012 14:04:40 +0200 (CEST)
Received: from [10.10.10.250] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id B7F51DE825;
	Mon, 18 Jun 2012 14:04:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120616 Thunderbird/13.0.1
In-Reply-To: <7vaa017j51.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200140>

On 06/17/2012 10:55 PM, Junio C Hamano wrote:
> Michael Schubert <mschub@elegosoft.com> writes:
> 
>> This was discussed earlier this year:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/189715
>>
>> What about pointing at non-existing references? Should this
>> still be allowed?
> 
> How else would you reimplement "checkout --orphan" in your own
> Porcelain using symbolic-ref?

Forgot about that.

>>
>> Additionally, I had to reindent two lines to make git-am happy
>> (indent with spaces).
> 
> I doubt that it is needed; the '-' lines show runs of HT followed by
> fewer than 8 SP, which should not trigger "indent with spaces".

I've only noticed because git-am was telling me when I tried to
apply the patch.? Am I missing something?
