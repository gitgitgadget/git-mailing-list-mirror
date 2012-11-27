From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 3/6] Fix grammar
Date: Tue, 27 Nov 2012 22:23:33 +0100
Message-ID: <5F2BC41E-6F77-44B8-B05E-8FB07E82EFA3@quendi.de>
References: <1354038279-76475-1-git-send-email-max@quendi.de> <1354038279-76475-4-git-send-email-max@quendi.de> <7v8v9mn5k6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSdG-0003Nq-0i
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347Ab2K0VXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:23:38 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:34545 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754652Ab2K0VXh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:23:37 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.27]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TdScv-0007oa-Su; Tue, 27 Nov 2012 22:23:33 +0100
In-Reply-To: <7v8v9mn5k6.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354051417;851de0c6;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210605>


On 27.11.2012, at 21:39, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>> Subject: Re: [PATCH 3/6] Fix grammar
> 
> Please run "git shortlog -200 --no-merges" from the tip of your
> topic branch before sending a series out, and see if you can
> immediately identify what area each of your patches affects.

First off: I apologize for the inconvenience my stumbling causes :-(, and I'll try to learn and do better next time I send this or another series.

In this particular case, I am not 100% sure if I understood you correctly, i.e. what exactly you are trying to tell me. Is it (in a nutshell) that the subject lines of my commits suck, as they don't identify which area of code they touch? At least that's the thing I notice when looking at that shortlog... Bad, of course...

If this is indeed it, would a commit message like

   git-remote-helper.txt: minor grammar fix

be OK? If this is indeed it, I'll be happy to reroll and resubmit the series accordingly. If I am mistaken and something else / more is wrong, please be so kind and let me know, too.


Sorry once more and thank you very much for your feedback,
Max

> 
>> Signed-off-by: Max Horn <max@quendi.de>
>> ---
>> Documentation/git-remote-helpers.txt | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
>> index db63541..7eb43d7 100644
>> --- a/Documentation/git-remote-helpers.txt
>> +++ b/Documentation/git-remote-helpers.txt
>> @@ -235,9 +235,9 @@ Commands are given by the caller on the helper's standard input, one per line.
>> 'capabilities'::
>> 	Lists the capabilities of the helper, one per line, ending
>> 	with a blank line. Each capability may be preceded with '*',
>> -	which marks them mandatory for git version using the remote
>> -	helper to understand (unknown mandatory capability is fatal
>> -	error).
>> +	which marks them mandatory for git versions using the remote
>> +	helper to understand. Any unknown mandatory capability is a
>> +	fatal error.
>> 
>> 'list'::
>> 	Lists the refs, one per line, in the format "<value> <name>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
