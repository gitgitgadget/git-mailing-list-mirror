From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is incremental staging really the common mode?
Date: Sun, 07 Sep 2008 17:40:20 -0700
Message-ID: <7v1vzvjwqz.fsf@gitster.siamese.dyndns.org>
References: <51419b2c0809071317g6f916b19p1c2792595be58047@mail.gmail.com>
 <alpine.DEB.1.10.0809071729310.8096@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 08 02:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcUoy-00018q-UV
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 02:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYIHAkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 20:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYIHAka
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 20:40:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYIHAka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 20:40:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59C2178083;
	Sun,  7 Sep 2008 20:40:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 05F8478080; Sun,  7 Sep 2008 20:40:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0809071729310.8096@asgard.lang.hm>
 (david@lang.hm's message of "Sun, 7 Sep 2008 17:32:09 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC6B4BCE-7D3E-11DD-AC98-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95201>

david@lang.hm writes:

> also, how many are doing 'git add .' or 'git add *' followed by git
> commit?

Everybody who starts a new history from scratch from an existing tarball
would be doing this at least once ;-)

> there were several commands listed that I have never heard of before
> and will want to research to see what they do to see if I should be
> using them.

The commands singled out were either (1) ancient, nobody should be using
them, and we would love to prove that nobody is using them anymore so that
we can remove them, or (2) reasonably new inventions that would help
common situations more than the stock Porcelain we have had for years, to
see if they are already widely adopted.

Perhaps somebody (or group of people, taking turns) should post a "git
trick of the week" series to this mailing list?
