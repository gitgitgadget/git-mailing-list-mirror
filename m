From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] format-patch --notes: show notes after three-dashes
Date: Thu, 18 Oct 2012 15:08:51 -0700
Message-ID: <7vlif3l9fw.fsf@alter.siamese.dyndns.org>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
 <1350539128-21577-7-git-send-email-gitster@pobox.com>
 <C2D3CE0879B345FFAC2A6487760B5378@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOyH3-0003di-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 00:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab2JRWIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 18:08:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061Ab2JRWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 18:08:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C1FB9138;
	Thu, 18 Oct 2012 18:08:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=No/KtgsqGcmuuDSZMk6ceFUH/Q0=; b=nUV8JC
	vhX2jh2mWWrS78PSq7Jh4KpFY+39SzQkoozAfsrT2aFKhCOIgbNZWiiAcijnW6HJ
	pXOzjpaYVdfuvbF6pDwQELVrjRYrjy4jQV7N77FN9I48hJgZqR+bEunFjsswEGwV
	m7v4bL2eWrLjYNlZn2zgcqClofCZqZ5ciAVdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IQry8hjjEfhrgSa7WzdVPxM1a75BH/lY
	bs1QJ+HUMZK+I0mlD/S0Be8avmtETno6EA/oWND0rTYYoACH2fGWTXXegj4cVj6R
	j7JM1Q8X5nEbSTVAxT0g++gES3BcPgK/Odt2I3z0D+J7N777X4D2yAJi4+PjK3df
	v0++8KSBPB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29C309137;
	Thu, 18 Oct 2012 18:08:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D7319136; Thu, 18 Oct 2012
 18:08:52 -0400 (EDT)
In-Reply-To: <C2D3CE0879B345FFAC2A6487760B5378@PhilipOakley> (Philip Oakley's
 message of "Thu, 18 Oct 2012 22:35:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66C6C8BA-1970-11E2-A480-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208024>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> When inserting the note after the commit log message to format-patch
>> output, add three dashes before the note.  Record the fact that we
>> did so in the rev_info and omit showing duplicated three dashes in
>> the usual codepath that is used when notes are not being shown.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Should this also include a documentation update to make this
> substantive benefit visible, whether that be in the format-patch man
> pages, the SubmittingPatches guide, in the git-notes description of 'A
> typical use...', or even in the user-manual?

Eric Blake (http://mid.gmane.org/507EB310.8020904@redhat.com) was
already working on a documentation updates already, I thought.

As long as what it does is explained in format-patch, that is fine.

I do not think this deserves to be in the SubmittingPatches.  We do
tell people to hide "here is the context of the change" additional
explanation after three dashes, but how the submitters prepare that
text is entirely up to them (and I personally do not think notes is
not necessarily the right tool to do so).
