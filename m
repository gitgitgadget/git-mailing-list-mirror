From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 2/2] Document rev^! and rev^@ as revision specifiers
Date: Fri, 6 Jul 2012 11:00:54 +0200
Message-ID: <D8DF0AED-91D3-45C0-B49E-97E07D21350C@quendi.de>
References: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org> <1341532890-13829-1-git-send-email-max@quendi.de> <1341532890-13829-2-git-send-email-max@quendi.de> <7vtxxlnyn1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 11:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn4nj-00074R-U0
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 11:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713Ab2GFJZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 05:25:47 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48281 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932558Ab2GFJZi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 Jul 2012 05:25:38 -0400
Received: from [89.204.139.49] (helo=[10.160.12.49]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Sn4PM-000423-HF; Fri, 06 Jul 2012 11:01:04 +0200
In-Reply-To: <7vtxxlnyn1.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (9B206)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341566738;83f85e63;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201093>



Am 06.07.2012 um 09:21 schrieb Junio C Hamano <gitster@pobox.com>:

> Max Horn <max@quendi.de> writes:
> 
>> +'<rev>{caret}@', e.g. 'HEAD{caret}@'::
>> +  A suffix '{caret}' followed by an at sign
>> +  means all parents of '<rev>'.
>> +  This is somewhat different from the other specifiers in this
>> +  section in that it may refer to multiple commits at once.
>> +  See also the next section on SPECIFYING RANGES.
> 
> Looks good.
> 
> 
>> +'<rev>{caret}!', e.g. 'HEAD{caret}!'::
>> +  A suffix '{caret}' followed by an exclamation mark
>> +  means commit '<rev>' but forces all of its parents to be excluded. For
>> +  commands that deal with a single revision, this is the same as '<rev>".
> 
> Is this sentence correct?  "git commit -C 'HEAD^!'" might be a
> command that expects a single revision, but I do not think it is the
> same as "git commit -C HEAD".

Ignoring the exact words I used for the moment, what I meant is that these two commands should be functionally equivalent. Aren't they? If not, I obviously misunderstand something, and would like to learn more, and add a better explanation.

If they are equivalent in the sense that the end results are indistinguishable,, and you just dislike the (indeed inaccurate) choice of words, how about replacing "is the same as" by "is [functionally] equivalent".


Thank you very much for your reviews,
Max


> 
>> +  Hence it is primarily used with commands expecting commit ranges.
> 
> That is correct.
> 
