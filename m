From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git - index-pack missing
Date: Wed, 17 Dec 2008 19:15:00 -0800
Message-ID: <7vr646i37v.fsf@gitster.siamese.dyndns.org>
References: <54F47863-AF55-4FB7-8A43-A4253E1F782C@michaelbutros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Boutros <me@michaelboutros.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 04:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9NA-00023x-JL
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbYLRDPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYLRDPI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:15:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYLRDPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:15:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C14C88815D;
	Wed, 17 Dec 2008 22:15:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 002878815C; Wed,
 17 Dec 2008 22:15:02 -0500 (EST)
In-Reply-To: <54F47863-AF55-4FB7-8A43-A4253E1F782C@michaelbutros.com>
 (Michael Boutros's message of "Wed, 17 Dec 2008 18:40:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1151B82C-CCB2-11DD-9C06-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103423>

Michael Boutros <me@michaelboutros.com> writes:

> I'm trying to clone a repository for the first time on a hosting
> account that just got setup with Git. However, the problem is that for
> some reason there is no git-index-pack. I cannot find any reason that
> that one particular command would not be installed, but for some
> reason that seems to be the case.

You may want to study output from "git help --all" to see if there is
anything *else* that is missing.  You did not say which version of git you
use, and how it was built and installed with which non-standard options
and in what way, so it is hard to guess what is going on.

Perhaps:

	$ cd ~root
        $ grep 'rm .*index-pack' .history .bash_history

could help locating the cause of breakage, but there are other ways to
break your installation, so...

> Has anyone ever heard of anything like this?

Not me.
