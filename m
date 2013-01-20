From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sun, 20 Jan 2013 10:33:07 -0800
Message-ID: <7vehhfn1r0.fsf@alter.siamese.dyndns.org>
References: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
 <379071741.1327695.1358589560822.JavaMail.ngmail@webmail24.arcor-online.net>
 <CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwzkQ-0008Iz-Ij
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab3ATSdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:33:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab3ATSdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:33:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BCA1BB2E;
	Sun, 20 Jan 2013 13:33:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4BPLgFJu+sNN8Cwwzrt4s1wdCeM=; b=ppza4X
	6/57Vzdo60RNyO/ZrHkbf5/FPhGzAoJDaTMN23ClmSKu4C3tGF/0uxxI4fZgB3rV
	d7pohhVG6dlMhNDFN9IK+1qRHTixcvRR5eFLGo1oVbjrzZ9NS3AoAzkmyyCxiQ/c
	f6L+6MU7msx0NhDbatvTYn0lGxJ4untvdHzWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VYaHXexftfiFmL9+3c4Ciw+esWfDtM1r
	9/ZVtWI8YnBbgb3uREV/kf/WUKCQCLs7PfNd9b63zRkyGyVvHGVmd+yJKGCKgPCm
	0JoS47oPkvNSbCAzwtTjYWeEUjF0EAMNqKxcLYjOk80o5JirEP8xXQbkOnnBHVa3
	OMZbuVfXZWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8104DBB2D;
	Sun, 20 Jan 2013 13:33:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE106BB2B; Sun, 20 Jan 2013
 13:33:08 -0500 (EST)
In-Reply-To: <CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com> (David
 Aguilar's message of "Sat, 19 Jan 2013 02:39:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D693F8D0-632F-11E2-9DBA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214028>

David Aguilar <davvid@gmail.com> writes:

> On Sat, Jan 19, 2013 at 1:59 AM, Thomas Ackermann <th.acker@arcor.de> wrote:
>> @@ -55,7 +55,7 @@ History Viewers
>>
>>     - *gitweb* (shipped with git-core)
>>
>> -   GITweb provides full-fledged web interface for GIT repositories.
>> +   GITweb provides full-fledged web interface for Git repositories.
>
> What about GITweb?
>
>> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
>> index d377a35..0df13ff 100644
>> --- a/Documentation/git-update-ref.txt
>> +++ b/Documentation/git-update-ref.txt
>> @@ -73,7 +73,7 @@ in ref value.  Log lines are formatted as:
>>  Where "oldsha1" is the 40 character hexadecimal value previously
>>  stored in <ref>, "newsha1" is the 40 character hexadecimal value of
>>  <newvalue> and "committer" is the committer's name, email address
>> -and date in the standard GIT committer ident format.
>> +and date in the standard Git committer ident format.
>
> IMO some of these look nicer when everything is lowercase.
> e.g. "standard git committer ident format".

I do not think we ever intended to change the *name* of the
software.

In the early days, we wrote GIT in places where, if we were doing a
fancier typography, we would have used drop-caps for the latter two
(i.e. it is "Git" spelled in a font whose lower case alphabets have
the same shape as upper case ones but are smaller).  So there were
only "git" vs "Git".

If I were to decide today to change the spellings, with an explicit
purpose of making things more consistent across documentation, it
may make sense to use even a simpler rule that is less error-prone
for people who write new sentences that has to have the word.  How
about treating it just like any other ordinary word?  That is, we
say "git" (without double-quotes, of course), unless it comes at the
beginning of a sentence?
