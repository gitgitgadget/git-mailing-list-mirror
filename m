From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-po master branch
Date: Wed, 02 May 2012 23:47:01 -0700
Message-ID: <7vaa1phica.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
 <87d36n2f2r.fsf@thomas.inf.ethz.ch> <7vtxzyilid.fsf@alter.siamese.dyndns.org>
 <CANYiYbH+N3k_=FWyeS_HfBWSBeBdOUqW5qrHFe=qV4ECtYABpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Git List <git@vger.kernel.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 08:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPpom-0001F5-6b
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 08:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab2ECGrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 02:47:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab2ECGrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 02:47:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F7DD636E;
	Thu,  3 May 2012 02:47:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VdUqKty+HKDc+//k2VPEdoEUBUc=; b=iGH0wJ
	r/3c6mn9jeCia18rHfRK2YXbEyOpMad+B9O7F8RN2iscVO9yMyo2wGeTQwAlMOoG
	lxjT4Qk+h6QiHiia8xpoRkNVUkT8hHSBYiAIi326IDHzulzdwEr+xbBBOXn6UWrd
	RO2WbnW2jE5YjTLZk5jvYVjcogXDZCJYV6314=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=skV12ShyZn+Slb6ZPSqfPc0THSrFASgw
	BCBKNTxFexmLcpQJWJhc6xJxjet5Juz4qod9kwSumDBvcKU+tamu7nUP91WXYlEj
	NXs1wJbDxVdGWmelYc1Gce/SInWlqED8wC2WHip2tKRYFtLjRzjuDxioACK61emY
	jq5JX8VVqRc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E35636D;
	Thu,  3 May 2012 02:47:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2971636C; Thu,  3 May 2012
 02:47:02 -0400 (EDT)
In-Reply-To: <CANYiYbH+N3k_=FWyeS_HfBWSBeBdOUqW5qrHFe=qV4ECtYABpA@mail.gmail.com> (Jiang
 Xin's message of "Thu, 3 May 2012 12:31:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA504E10-94EB-11E1-B6BE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196887>

Jiang Xin <worldhello.net@gmail.com> writes:

> What I have learned from this:
>
>  * Only pull reqests with updates of already exists language are accepted
>    for the 'maint' branch of git-po. If a new l10n language support wants to
>    be added to 'maint' branch or to the RC version, it must be fully
>    discussed int this list.
>
>  * Pull requests with a initial XX.po (untranslated) and updated TEAMS file
>    will not merge to the master branch, but merge to a work in progress
>    branch, such as WIP/XX.
>
>    In order to coordinate works of potential contributors for a new l10n
>    language, l10n team leader (the 1st contributor send me a pull request)
>    will send a pull requst with a untranslated XX.po and update TEAMS
>    file with URL of the dedicated repository for the new language XX.
>    Nobody can guarantee how long XX.po will 100% translated. If merge
>    this initial commit too soon to the master branch, unfinished *.po will
>    be released, like da.po from Byrial Jensen, nl.po from
>    Vincent van Ravesteijn, and pt_PT.po from Marco Sousa.
>    So create a WIP/XX branch may resolved this problem.

I am not sure if writing down bureaucratic-sounding and rigid rules is the
best first response to this kind of incident. It's a learning process for
all of us involved, and in early rounds like this, mistakes are bound to
happen, and the first response should be to admit it, i.e. "Sorry, there
was a miscommunication and gap in understanding among us. I as the i18n
coordinator should have double checked before responding to pull requests
to see if there was a consensus within the l10n team for the particular
language. I'll try to be more careful until we nail the procedure down and
everybody gets more comfortable with the process."

Obviously I was also at fault that I didn't double check with you to make
sure that the l10n teams involved were happy with what you are about to
feed me, and I was wrong to instead blindly have assumed that it was the
case.  I should have done so until I get to know you better that you would
always operate in such a careful fashion [*1*].

Once a sound process of human communication is in place, I do not think a
rigid rule like "no new language to 'maint'" is particularly necessary.


[Footnote]

*1* Yes, I am saying that I shouldn't have blindly trusted you, and
similarly, I expect you to learn not to blindly trust l10n people you work
with, until you know they know you expect that they sufficiently
coordinate among themselves within the l10n team for a single language
before sending you an integration request.  Don't take this in a wrong
way.  Trust will come after repeated interactions and learning the other
parties you are working with.
