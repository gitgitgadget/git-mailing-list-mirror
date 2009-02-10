From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking
 backwards
Date: Tue, 10 Feb 2009 14:52:22 -0800
Message-ID: <7vbpt9lxax.fsf@gitster.siamese.dyndns.org>
References: <200902091508.11460.trast@student.ethz.ch>
 <200902102342.29962.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1UJ-0002qh-Ht
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbZBJWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755732AbZBJWwb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:52:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756510AbZBJWw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:52:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 200B3984C5;
	Tue, 10 Feb 2009 17:52:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8EC3C984C2; Tue,
 10 Feb 2009 17:52:24 -0500 (EST)
In-Reply-To: <200902102342.29962.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue, 10 Feb 2009 23:42:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7DBBA6BA-F7C5-11DD-95DE-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109330>

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas Rast wrote:
>>   git fetch git://repo.or.cz/git/trast.git mailnotes &&
>>   GIT_NOTES_REF=FETCH_HEAD git log origin/pu
>
> An update: I have fully automated the process, it now fetches mails
> from Gmane over HTTP which gives it the Gmane URLs for free.  I'm
> rather happy with the latter feature, especially since Konsole has a
> feature to recognize and open links directly.
>
> I have imported all commits, and mails since roughly July 2008
> (starting with Gmane 89000).  In this timeframe there were 1802
> non-merge commits, and the mailnotes tree now holds 1122 annotations.

Wonderful.
