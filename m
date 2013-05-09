From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 09 May 2013 16:09:38 -0700
Message-ID: <7v7gj77nt9.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri May 10 01:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZy7-0008GR-0a
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418Ab3EIXJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:09:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758037Ab3EIXJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:09:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECFFE1DFEA;
	Thu,  9 May 2013 23:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=RFP1WeeVAZ0rGdg3isYK9STEboU=; b=meTnhXcE7DuMg3Es3MNX
	B43cm4jkvhXdj6pwMSVvGNe60auSu7xU1pKz5lkehLCHr0UHh6g3BG5BgnAODxKD
	qusYVSIEd2JDDFd2YQjBpVIilHl87c8NwCt0YKxZLXImeqWO6836+ZWTMjzOTchS
	iji1S0lQf1+Upd2dTIWpyII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KXEqYVsiNT4LIDSPnrXQC8+A26+lU3HRRx3odwAWvhgz+p
	BL8YE+E7q3s9xbKaJNl2FlHkK8zHIy99TXSYc9YERyrtf7ZDnFXJx6CTXQDduCex
	UlSIJFv3U49cFzg9i1J91uTjFZ+891E4E6+MIUnu+JLhH8Z6jLO5MT1HEGx4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E37001DFE9;
	Thu,  9 May 2013 23:09:39 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5737A1DFE7;
	Thu,  9 May 2013 23:09:39 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 864830D4-B8FD-11E2-AD7A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223800>

John Szakmeister <john@szakmeister.net> writes:

> On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin/fast-export.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index d60d675..8091354 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -135,7 +135,7 @@ static void export_blob(const unsigned char *sha1)
> [snip]
>> @@ -289,13 +289,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>>         parse_commit(commit);
>>         author = strstr(commit->buffer, "\nauthor ");
>>         if (!author)
>> -               die ("Could not find author in commit %s",
>> +               die("Could not find author in commit %s",
>>                      sha1_to_hex(commit->object.sha1));
>
> It looks like your simple replace didn't account for calls with
> multiple lines.  Now the remaining lines don't line up.
> :-)  There's several more places like this in the patch.

Good eyes.

Matching the coding-style to have no SP between function name and
its argument list is just as important as matching the indentation
style used in the project; trading one breakage with another does
not make much sense.
