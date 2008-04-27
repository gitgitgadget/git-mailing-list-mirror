From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: move options of git-diff-tree to a
 separate file.
Date: Sat, 26 Apr 2008 17:24:57 -0700
Message-ID: <7vod7wkuue.fsf@gitster.siamese.dyndns.org>
References: <b57b2d5d484b6e099382900069ed6ca2afc6922d.1209243527.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 02:25:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpuiF-0003sv-WB
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 02:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbYD0AZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 20:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbYD0AZE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 20:25:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbYD0AZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 20:25:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 744E22169;
	Sat, 26 Apr 2008 20:25:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E97A92168; Sat, 26 Apr 2008 20:24:58 -0400 (EDT)
In-Reply-To: <b57b2d5d484b6e099382900069ed6ca2afc6922d.1209243527.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Sat, 26 Apr 2008 23:01:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80401>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +--stdin::
> +	When '--stdin' is specified, the command does not take
> +	<tree-ish> arguments from the command line.  Instead, it
> +	reads either one <commit> or a pair of <tree-ish>
> +	separated with a single space from its standard input.

Are you sure "git show" takes --stdin?

Also for "show", listing --cc as one of the options does not make much
sense, as that is an unoverridable default.

And no, making it overridable so that it can take -m to show independent
diff against each parent of a merge commit do not make much sense in the
context of "git show".
