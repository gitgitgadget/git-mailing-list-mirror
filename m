From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Sat, 19 Apr 2014 00:20:34 -0700
Message-ID: <7vwqellr99.fsf@alter.siamese.dyndns.org>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<CALKQrgdv3xN78dvFNzR7K7dWMP-brG7r-OoHHMAus4pskmizmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 09:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbPYX-0007Dq-0r
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 09:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbaDSHS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 03:18:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbaDSHS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 03:18:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1B476E872;
	Sat, 19 Apr 2014 03:18:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y7Wa6OWYS+GjjuCygQVx9J2qncI=; b=xS5NbT
	LNoR8dNPFxTaNzTPGpjUXBSGi73sS8djvWYnxfFVY161RnE3771At5mEZ3a6I+Z9
	8evIOexQnZ1DCpNz3hiY9LDBNl+H5YxqtL84xHagEdbINJj0i6SIL0/nlt30Akt2
	jX6ysyqoG2Yws9aVZ7rAGTdehb9jbunHRD12E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=diqUPD25yEjGp4DRXEiEldZu7zcE9hcB
	f14G85cxSyV/Q82cxqT0YB1/qQLOVuEIBPqGAp4s67gu2kzhuB4lBzuCRqllIfx+
	4vE8cpgkQvk4pJUeBqp673bUeK7vnTi6PnUBR3rEeOMioj0bxp1I3zqcgW+5DBT6
	oifnrwTZ1s4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85EF56E870;
	Sat, 19 Apr 2014 03:18:56 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8E756E86F;
	Sat, 19 Apr 2014 03:18:54 -0400 (EDT)
In-Reply-To: <CALKQrgdv3xN78dvFNzR7K7dWMP-brG7r-OoHHMAus4pskmizmw@mail.gmail.com>
	(Johan Herland's message of "Sat, 19 Apr 2014 03:13:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: DD9D63E6-C792-11E3-918D-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246507>

Johan Herland <johan@herland.net> writes:

> On Fri, Apr 18, 2014 at 9:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> An early preview release Git v2.0.0-rc0 is now available for
>> testing at the usual places.
>
> This is supposed to have _all_ the v2.0 topics, correct?
>
> I'm unable to find the commit that actually _changes_ the default
> prefix for "git svn" (as announced in Documentation/git-svn.txt and
> the release notes for v1.8.5 and v1.9.0).

Yes, I noticed that the topic has been in the release notes for a
few cycles but the changes never came to my tree (perhaps review of
the patch series never concluded?) at the beginning of this cycle,
so dropped it from the release notes.

> For reference, it was posted as patch 3/3 back in October:
> http://thread.gmane.org/gmane.comp.version-control.git/232761/focus=235900
>
> Very sorry for not discovering this earlier.

Well, things happen X-<.

I see the other two contained in the merge from Eric at 1668b7d78f81
(Merge git://git.bogomips.org/git-svn, 2013-10-16).  Is the last one
still viable?  From my point of view, it would be best if Eric can
take another look on it and throw me a pull request (and I have to
remember to resurrect the entry in the release notes).

Alternatively I could revert the "Warn about changing the default"
for now and defer the topic to v2.1.

Eric, what do you think?  My preference is not to revert but at the
same time I am hesitant to take a patch that was posted as RFC this
late in the cycle without input from the area expert, so...
