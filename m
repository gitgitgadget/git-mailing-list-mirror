From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 06 Feb 2008 00:46:17 -0800
Message-ID: <7v3as6321y.fsf@gitster.siamese.dyndns.org>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com>
	<7vr6fr9noj.fsf@gitster.siamese.dyndns.org>
	<C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>, srp@srparish.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 09:47:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMfvs-0006K6-Ar
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 09:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466AbYBFIq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 03:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758669AbYBFIq0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 03:46:26 -0500
Received: from rune.pobox.com ([208.210.124.79]:59038 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757149AbYBFIqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 03:46:25 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 72E891941B5;
	Wed,  6 Feb 2008 03:46:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CB52F194166;
	Wed,  6 Feb 2008 03:46:41 -0500 (EST)
In-Reply-To: <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com> (Wincent
	Colaiuta's message of "Wed, 6 Feb 2008 09:05:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72773>

Wincent Colaiuta <win@wincent.com> writes:

> This fails with the "remote end hung up unexpectedly" error:
>
>    # /usr/local/bin/git-daemon --inetd --base-path=/blah -- /blah
>
> Drop the --inetd option and it works with no errors:

Do you mean you run the above from your command line and it
fails?

I do not think --inetd mode is supposed to work as a daemon that
accepts connections.  Wouldn't it be talking with a single peer
via its stdin/stdout?

Puzzled.
