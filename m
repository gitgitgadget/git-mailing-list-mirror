From: greened@obbligato.org
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Tue, 08 Jan 2013 04:40:23 -0600
Message-ID: <87d2xglzzc.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-2-git-send-email-greened@obbligato.org>
	<7va9ssa94l.fsf@alter.siamese.dyndns.org>
	<87wqvwfsfm.fsf@waller.obbligato.org>
	<7vehi477er.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 11:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsWcc-00005t-N9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 11:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab3AHKlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 05:41:09 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51720 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755707Ab3AHKlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 05:41:07 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TsWjl-0003l4-8n; Tue, 08 Jan 2013 04:48:54 -0600
In-Reply-To: <7vehi477er.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 16:30:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > The question
   was about the lossage of the blank line, which does not > seem to be related
    to what this patch wants to do. Ah, missed that. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212951>

Junio C Hamano <gitster@pobox.com> writes:

> The question was about the lossage of the blank line, which does not
> seem to be related to what this patch wants to do.

Ah, missed that.

>>>> -# 25
>>>> +#25
>>>
>>> Why the lossage of a SP?
>>
>> I think this got fixed later in the series.
>
> That is not a good excuse to introduce breakages in the first place, no?

Oh, I agree.  I wasn't making excuses.  :)

>>> It may make sense to lose these "# num" that will have to be touched
>>> every time somebody inserts new test pieces in the middle, as a
>>> preparatory step before any of these patches, by the way.  That will
>>> reduce noise in the patches for real changes.
>>
>> Yeah, I know, but it makes it really easy to find a test when something
>> goes wrong.
>
> That is what "tXXXX-*.sh -i" is for, isn't it?

Oh, I didn't know about that!

                        -David
