From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative submodule URLs vs. clone URL DWIMming
Date: Sat, 30 Aug 2008 16:45:16 -0700
Message-ID: <7vabeuf4oj.fsf@gitster.siamese.dyndns.org>
References: <200808271400.54302.johan@herland.net>
 <200808290101.20048.johan@herland.net>
 <7vhc92f8ay.fsf@gitster.siamese.dyndns.org>
 <200808310123.48018.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 01:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZa9F-0005U6-4z
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 01:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbYH3XpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 19:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbYH3XpX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 19:45:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbYH3XpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 19:45:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 205746E4E2;
	Sat, 30 Aug 2008 19:45:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 164056E4E1; Sat, 30 Aug 2008 19:45:17 -0400 (EDT)
In-Reply-To: <200808310123.48018.johan@herland.net> (Johan Herland's message
 of "Sun, 31 Aug 2008 01:23:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B5D93DFE-76ED-11DD-851F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94445>

Johan Herland <johan@herland.net> writes:

> $ git clone /repo/foo bar
> $ grep -B1 url bar/.git/config
> [remote "origin"]
>         url = /repo/foo/.git
>
> vs.
>
> $ git clone file:///repo/foo bar
> $ grep -B1 url bar/.git/config
> [remote "origin"]
>         file:///home/johan/git/foo
>
> Hmm?

If you mean "the latter lacks 'url =' and is broken", and if that is what
happens, then it needs to be fixed.  But otherwise, I do not personally
find these differences interesting.

But that does not mean I'd veto if somebody else cares deeply enough and
comes up with a clean solution.
