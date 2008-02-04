From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Sun, 03 Feb 2008 16:24:13 -0800
Message-ID: <7vodaxpo0i.fsf@gitster.siamese.dyndns.org>
References: <prvd3i9e.fsf@blue.sea.net> <ir15399p.fsf@blue.sea.net>
	<m3lk6161jo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLp92-00056o-AP
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbYBDAYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYBDAYW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:24:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbYBDAYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:24:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A6667F1F;
	Sun,  3 Feb 2008 19:24:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 98D9D7F1E;
	Sun,  3 Feb 2008 19:24:15 -0500 (EST)
In-Reply-To: <m3lk6161jo.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sun, 03 Feb 2008 15:52:23 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72431>

Jakub Narebski <jnareb@gmail.com> writes:

> Besides here the mutually exclusive options are naturelly delimited,
> so you can say just (I think):
>    [--whitespace=nowarn|warn|error|error-all|strip]

I think that is probably the right thing to do in this case.  It
is clear where the alternatives end, without adding extra
grouping, so it keeps the description easy to read.

It may fail with a sick reader who would complain "but 'git
rebase --whitespace=nowarn' is correct while 'git rebase warn'
is not!", but personally I do not think we deeply care about
pleasing such a pedantic nitpicker.
