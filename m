From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add a note in the on-line Git book about installing the man
 pages?
Date: Tue, 02 Apr 2013 10:27:23 -0700
Message-ID: <7vsj38etc4.fsf@alter.siamese.dyndns.org>
References: <515B0D00.6020506@m-plify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Tonhofer <d.tonhofer@m-plify.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4zz-0007Hj-LM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860Ab3DBR10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:27:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761374Ab3DBR1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:27:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BD3E12A6A;
	Tue,  2 Apr 2013 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QPOEgSIGG+ERF0BF0ct7lfRRq+c=; b=WaRXM0
	EOOHClrNzQ06LapOmB7nC0QVlFaX/i4UX1kwmFlWNbl5TjTfk0oaZvFRfM/+cJK4
	/gTMmD14msuAYppRrL9X7JMKjaLeezXN7tFxsCYWeVKjAF4QqMcaKbSYBO7udJUH
	iIanJbhzeEafo5OFN91kZ2H+QJfBcSW28doUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s0/l2g8015tVzQ3gJZIfDiGf1mVfEESu
	VMRajHoNY66B3y0ba3AFqhtXNcWcEADtI6w+zpoFZlBYm7+OlnhJGLkP+2JRr8qt
	hGbH5CiykF6CMjWDrW9Omq6hIFTleI3LBmoJKzLTTLOouVd9IY4acpt0fY0haK/m
	7arazPjJswo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7324012A69;
	Tue,  2 Apr 2013 17:27:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EC2D12A64; Tue,  2 Apr
 2013 17:27:24 +0000 (UTC)
In-Reply-To: <515B0D00.6020506@m-plify.com> (David Tonhofer's message of
 "Tue, 02 Apr 2013 18:53:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 955BEEFE-9BBA-11E2-A963-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219811>

David Tonhofer <d.tonhofer@m-plify.com> writes:

> It seems the git man pages (or HTML pages) are not installed by
> default when you install git as described in the
> http://git-scm.com/book
>
> I propose to add a note to
> http://git-scm.com/book/en/Getting-Started-Installing-Git along those
> lines:
>
> Getting the git manpages from
> "https://code.google.com/p/git-core/downloads/list" and unpack them
> (supposing you installed your git into "/opt/git"):

I suspect that most end-users would install not from the source but
install Git from distro as binary packages.  I do not know what the
page of that website you refer to talks about offhand, but if it is
about installing from the source (so that they can help us improve
the software and its documentation), it may be a better idea to let
the users build the documentation pages from the source, not from
the above URL, which serves pre-formatted documentation we cannot
take a patch for.
