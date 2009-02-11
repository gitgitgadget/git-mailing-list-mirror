From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] completion: Change "if [...]" to "if test ..." to
 match git convention
Date: Wed, 11 Feb 2009 08:46:01 -0800
Message-ID: <7vwsbwgbw6.fsf@gitster.siamese.dyndns.org>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:47:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIFN-0007Wn-8r
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbZBKQqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbZBKQqL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:46:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbZBKQqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:46:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EF8C9855D;
	Wed, 11 Feb 2009 11:46:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2613A9855A; Wed,
 11 Feb 2009 11:46:02 -0500 (EST)
In-Reply-To: <1234366634-17900-3-git-send-email-ted@tedpavlic.com> (Ted
 Pavlic's message of "Wed, 11 Feb 2009 10:37:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AAEC7E0-F85B-11DD-B591-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109442>

Ted Pavlic <ted@tedpavlic.com> writes:

> In the single case of:
>
>     if [...] || [...]
>
> changed to:
>
>     if test ... || test ...

In [0/3] you talked about "git convention", but please match the local
convention, especially inside contrib/ area.  That is, consistency of the
style within the same file (and files in vicinity), is more important.

> Also changed:
>
>     if test ...
>     then
>
> to:
>
>     if test ...; then

The prevailing style in bash completion script is to write "then" on the
same line as "if", so I think this is a good example of matching the local
convention (if you are trying to match "git convention", "then" is written
on the same column as "if" on a line by itself for readability, so this
change is going backwards).
