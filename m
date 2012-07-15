From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Sun, 15 Jul 2012 00:11:23 -0700
Message-ID: <7v1ukd5wis.fsf@alter.siamese.dyndns.org>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sun Jul 15 09:11:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqIzS-0004zt-0t
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 09:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab2GOHL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 03:11:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab2GOHLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 03:11:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 628B07A8C;
	Sun, 15 Jul 2012 03:11:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xwGbIzOLXLIjoh2UsqVJuTPvrek=; b=DiT60b
	19n3bdOc4Oh2/+gRCHFPb0yzBfmKgkThAj3q3dVxW6i9cY7Cup/rRlVU/3bUd2vh
	IfkBAQHuxeSeVXRlBbGYc00ArM5+acfxeXdWXlGNQ7RdmH8hOxzVIQvek1I0HAWp
	KAvCbFhC4NSwP26WMvwxphwQFiPsZJ2TxxTgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0HLtlsr96sAl9rPymPoTZPOREl85Ksn
	IEa6522+qOa25AmwevEpzVJyMLvWN2qUkuL5laH+hyEIKrJ0BCnkgnq8p/dOLAFo
	pf/eaTjm38Go5k/tOTot1wTNdJwW0Plh1iAF/AEQgkBZ5gSHc8WebEVGSZujy5XX
	AZqUaiRuEJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1BB7A8B;
	Sun, 15 Jul 2012 03:11:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9FF97A8A; Sun, 15 Jul 2012
 03:11:24 -0400 (EDT)
In-Reply-To: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Sat, 14 Jul 2012 08:59:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49B1B650-CE4C-11E1-8E07-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201471>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
> can be used to send notification emails describing pushes into a git
> repository.  This script is derived from
> contrib/hooks/post-receive-mail, but has many differences, including:

The new script (I didn't read it at all) may be useful to some
people, but I'm fairly negative on adding 47 different "I know there
is something in contrib/, I looked at it, but I didn't bother
updating it to fill my needs and wrote a new one instead" at this
point to my tree.

It is a different matter if the patch was to replace the existing
one, saying "the users of the old script can use this one, which is
backward compatible with respect to the external interface such as
command line, or configuration variables used".  Instead of a total
backward compatibility, "here is a script to migrate the existing
set of configuration variables so that users of the old script can
run it once, and start using this new one" is also perfectly fine.

Such an enhancement, especially if the rewritten result is cleaner
and easier to enhance going forward than the original, would be very
much appreciated.

Thanks.
