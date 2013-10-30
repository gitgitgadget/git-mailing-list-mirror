From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] warn about http server document being too old
Date: Wed, 30 Oct 2013 14:27:15 -0700
Message-ID: <xmqqzjpqa1qk.fsf@gitster.dls.corp.google.com>
References: <523D030A.6080309@gmail.com>
	<xmqqli1s51z1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 22:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbdIW-00087E-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 22:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab3J3V1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 17:27:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614Ab3J3V1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 17:27:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD9224C671;
	Wed, 30 Oct 2013 17:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=diRn5mynKTC1qKiX3em0RPfOzhs=; b=RhJrKc
	FFeDSd4iFb2iUtQqNG1A2vmjHO0H+gw//Mu9jECCRun47AxI+FimBfETD2KuxNOC
	umOdD25NlbbomDX2cO0CdJPwacRRWD5hnDJQXnJjglJmcgRXAMrBousDMwFtufEp
	ZISncmlBLom68hsWetWoeoyJ7cZryHcKeyJEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPIITkaHl9IMlKj5OJtglZVm7T97rxwh
	aWJNU2UPd70riQaerOhrLAAcihVZIZsKZGkuikQya7pDGiCS+BDodeEsjaBicaeX
	votQ+S72O7xJhtl+y2OdQthpDJ/jo6p4PoQVu2e87IKJvPZZMl/ZOyEQkGKmuwQZ
	2BUHcGaTeaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9DF04C670;
	Wed, 30 Oct 2013 17:27:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 055974C66B;
	Wed, 30 Oct 2013 17:27:19 -0400 (EDT)
In-Reply-To: <xmqqli1s51z1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Oct 2013 14:40:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0ED49444-41AA-11E3-835D-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237072>

Junio C Hamano <gitster@pobox.com> writes:

> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>>   - describe when it is still applicable
>>   - tell people where to go for most normal cases
>>
>> Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
>> ---
>>
>> ref: http://thread.gmane.org/gmane.comp.version-control.git/159633.  Yes
>> it's very old but better late than never.
>>
>>  Documentation/howto/setup-git-server-over-http.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
>> index 7f4943e..90b19a0 100644
>> --- a/Documentation/howto/setup-git-server-over-http.txt
>> +++ b/Documentation/howto/setup-git-server-over-http.txt
>> @@ -3,6 +3,11 @@ Subject: Setting up a Git repository which can be pushed into and pulled from ov
>>  Date: Thu, 10 Aug 2006 22:00:26 +0200
>>  Content-type: text/asciidoc
>>
>> +NOTE: This document is from 2006.  A lot has happened since then, and this
>> +document is now relevant mainly if your web host is not CGI capable.
>> +
>> +Almost everyone else should instead look at linkgit:git-http-backend[1].
>> +
>>  How to setup Git server over http
>>  =================================
>
> I tend to agree that it is a good idea to have this kind of phrase
> somewhere in the document, but you cannot place the material above
> the top-level title.  AsciiDoc does not seem to like it.

I've amended this trivially, as follows.  Will advance it to 'next'.

Thanks.

-- >8 --
From: Sitaram Chamarty <sitaramc@gmail.com>
Date: Sat, 21 Sep 2013 07:53:06 +0530
Subject: [PATCH] doc/howto: warn about (dumb)http server document being too old

Describe when it is still applicable, and tell people where to go
for most normal cases.

Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/howto/setup-git-server-over-http.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 7f4943e..c803649 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -6,6 +6,10 @@ Content-type: text/asciidoc
 How to setup Git server over http
 =================================
 
+NOTE: This document is from 2006.  A lot has happened since then, and this
+document is now relevant mainly if your web host is not CGI capable.
+Almost everyone else should instead look at linkgit:git-http-backend[1].
+
 Since Apache is one of those packages people like to compile
 themselves while others prefer the bureaucrat's dream Debian, it is
 impossible to give guidelines which will work for everyone. Just send
-- 
1.8.5-rc0-175-g776cf91
