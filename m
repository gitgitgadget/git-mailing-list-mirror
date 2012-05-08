From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please review this pull request for maint branch with update of
 de.po
Date: Mon, 07 May 2012 19:24:38 -0700
Message-ID: <7vtxzr1kbd.fsf@alter.siamese.dyndns.org>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
 <CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 04:24:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRa6Y-0004An-RA
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 04:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab2EHCYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 22:24:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757974Ab2EHCYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 22:24:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D8E27FE3;
	Mon,  7 May 2012 22:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s5bu4aD3E4+zQ3WCi7qHoZ9a6Yw=; b=EBR7mX
	ryOogcXw5ewxui2oFutEeoXpTcaCmTqzHDu650tWjI/CRhcQBH64TyRiD4zrc7if
	oMF1VsfCQ5X4YjGafDsEHDRWVGKI6Jov8oJ9ASDx3qzJ41VwRo5FXY2EF3z7FDPd
	VDPlHRIkJobXjmN/a06h7AP85zmFlGZTa+LpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gBN72BihcS5/66b+nHQvLOvZbpxucC6c
	VWOq4OInq8jcEb94nsnqo2XD7damljHGKcyC4nwcjFYAVJiV5fMgCFh2YvtAeTEk
	WfYVeRkLYLSeGtcBgNGL5TqX7w//t7hhK5A2kDYZ/SJ6/FHXt9ZHyS7iiPdRfOYh
	FL5CO0+UOG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64CD47FE2;
	Mon,  7 May 2012 22:24:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E311A7FD8; Mon,  7 May 2012
 22:24:39 -0400 (EDT)
In-Reply-To: <CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com> (Jiang
 Xin's message of "Tue, 8 May 2012 08:30:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6C7DA18-98B4-11E1-8C18-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197335>

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio and members of German l10n team,
>
> Ralf send me two pull requests with improvement of Git German translation.
> All look fine except that one commit (fbd994d) by Thomas hacks a file
> "git-gui/po/de.po", which is outside of "po/" directory.

Sorry, but I cannot take this tree for two reasons:

 - If the state of the tree needs to be confirmed by l10n team, and it is
   possible that you need to cancel this pull request based on their
   feedback, I cannot pull it from you right now; otherwise your corrected
   history won't fast-forward anymore.  So the message should either be
   "Please make sure I have what l10n teams wanted to send out" to them,
   or "I am confident that l10n teams are happy with this, please pull" to
   me, but cannot be both.

 - git-gui/ part of my tree is maintained without the rest of git.git/
   tree by Pat Thoyts, and an update needs to go through that tree. I
   cannot take a change directly to that part.  Doing so would make
   it impossible to update git-gui/ project independently.

Please redo your tree by having the originating author separate the
git-gui part out, make sure everybody on the l10n team is happy with the
result, and then throw me another pull request.  Also arrange the git-gui
patch to go through Pat.

By the way, a change to the 'master' track is exactly the same deal, but
I would suspect that typically you would want your pull request for 'master'
a superset of your 'maint', so please hold off throwing a pull request for
'master' while it still is possible that you might need to rewind and
rebuild your 'maint'.

Thanks.
