From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Default color for commit hash in git-log is unreadable on bright
  background, and can't be changed.
Date: Tue, 24 Mar 2009 14:48:54 -0700
Message-ID: <7vmybavbg9.fsf@gitster.siamese.dyndns.org>
References: <1a04eebf0903241416g67e7abfdh6b3aa746f12b0e83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fyn Fynn <fynfynn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmEW1-0002ar-Rl
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 22:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbZCXVtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 17:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbZCXVtE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 17:49:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZCXVtC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 17:49:02 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37470A40C2;
	Tue, 24 Mar 2009 17:48:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 322F7A40C1; Tue,
 24 Mar 2009 17:48:55 -0400 (EDT)
In-Reply-To: <1a04eebf0903241416g67e7abfdh6b3aa746f12b0e83@mail.gmail.com>
 (Fyn Fynn's message of "Tue, 24 Mar 2009 14:16:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94CC9274-18BD-11DE-9701-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114495>

Fyn Fynn <fynfynn@gmail.com> writes:

> Unfortunately, the default text foreground color for the "commit
> <HASH>" line of git-log is 3 - yellow.
> ...
> Is there any good solution for this that I missed?

Perhaps...

$ git config color.diff.commmit cyan
