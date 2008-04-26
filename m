From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resubmit] Allow cherry-pick (and revert) to add signoff
 line
Date: Sat, 26 Apr 2008 14:07:49 -0700
Message-ID: <7vbq3wmije.fsf@gitster.siamese.dyndns.org>
References: <1209221215-13476-1-git-send-email-dpmcgee@gmail.com>
 <1209240868-30815-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, B.Steinbrink@gmx.de, gitster@pobox.com
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 23:08:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jprdc-0004GB-Fs
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 23:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760600AbYDZVIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 17:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760461AbYDZVIE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 17:08:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760274AbYDZVID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 17:08:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C1036410B;
	Sat, 26 Apr 2008 17:08:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2F573410A; Sat, 26 Apr 2008 17:07:56 -0400 (EDT)
In-Reply-To: <1209240868-30815-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Sat, 26 Apr 2008 15:14:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80393>

Dan McGee <dpmcgee@gmail.com> writes:

> +-s|--signoff::
> +	Add Signed-off-by line at the end of the commit message.
> +

Good.

> +		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),

Not so good ;-)

Will apply with an obvious "s/by: header/by:/" and merge to 'next'.

Thanks.
