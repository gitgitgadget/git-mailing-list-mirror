From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone over http
Date: Tue, 04 Sep 2007 10:29:10 -0700
Message-ID: <7vir6qnxuh.fsf@gitster.siamese.dyndns.org>
References: <200709021123.04218.robin.rosenberg.lists@dewire.com>
	<1188924876.6192.21.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:29:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScDL-0000td-Cb
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbXIDR3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754866AbXIDR3S
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:29:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbXIDR3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:29:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 64E7C12E672;
	Tue,  4 Sep 2007 13:29:34 -0400 (EDT)
In-Reply-To: <1188924876.6192.21.camel@beauty> (Josh England's message of
	"Tue, 04 Sep 2007 10:54:36 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57623>

"Josh England" <jjengla@sandia.gov> writes:

> On Sun, 2007-09-02 at 11:23 +0200, Robin Rosenberg wrote:
>> git clone (1.5.3) with http is somewhat unreliable. I've noticed if
>> can actually give
>> me different versions of a branch each time I run it, eventually yielding
>> the one I'm expecting.  And now this:
>
> I don't see this behavior, but I do see other wierdness cloning via
> http.  Anytime I clone a repo (any repo) via http from behind the
> firewall/proxy at work I never get any branches.  'git branch' only ever
> shows 'master'.  I can't checkout and work on any other branch.  I can
> work around the problem by cloning on a box that is more open, but was
> wondering if anyone knows how to fix this.

Well, what does "git branch -r" say?

If you see the remote tracking branches out of your branch (aka
"heads/") namespace, that has been the default for quite some
time since 1.5.0 days.

Perhaps "more open" one has ancient git that dumped remote
tracking branches in your branch namespace, while your "behind
firewall" one has not so ancient git?
