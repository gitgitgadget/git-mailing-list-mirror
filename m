From: greened@obbligato.org
Subject: Re: [PATCH 3/7] contrib/subtree: Add --unannotate
Date: Tue, 15 Jan 2013 21:20:04 -0600
Message-ID: <87vcaxq0ez.fsf@waller.obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
	<1357646997-28675-4-git-send-email-greened@obbligato.org>
	<7vehhvecoy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvJYo-0000f2-PI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 04:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929Ab3APDUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 22:20:46 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:34910 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756860Ab3APDUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 22:20:45 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TvJgX-0003GK-TW; Tue, 15 Jan 2013 21:29:06 -0600
In-Reply-To: <7vehhvecoy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 Jan 2013 10:45:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213722>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
>> index c5bce41..75aa690 100644
>> --- a/contrib/subtree/git-subtree.txt
>> +++ b/contrib/subtree/git-subtree.txt
>> @@ -198,6 +198,21 @@ OPTIONS FOR split
>>  	git subtree tries to make it work anyway, particularly
>>  	if you use --rejoin, but it may not always be effective.
>>  
>> +--unannotate=<annotation>::
>> +	This option is only valid for the split command.
>> +
>> +	When generating synthetic history, try to remove the prefix
>> +	<annotation> from each commit message (using bash's "strip
>> +	shortest match from beginning" command, which supports
>> +	globbing).  This makes sense if you format library commits
>> +	like "library: Change something or other" when you're working
>> +	in your project's repository, but you want to remove this
>> +	prefix when pushing back to the library's upstream repository.
>> +	(In this case --unannotate='*: ' would work well.)
>> +	
>> +	Like --annotate,  you need to use the same <annotation>
>> +	whenever you split, or you may run into problems.
>
> I think this paragraph inherits existing breakage from the beginning
> of time, but I do not think the above will format the second and
> subsequent paragraphs correctly.

Ok, I'll take a look.

> I've applied all seven patches in the series with minor fix-ups, and
> will merge it to 'pu'.

Thanks!

                          -David
