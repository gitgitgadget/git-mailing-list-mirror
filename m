From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/4] gitweb: introduce remote_heads feature
Date: Sun, 16 Nov 2008 10:14:42 -0800
Message-ID: <7vabbz35d9.fsf@gitster.siamese.dyndns.org>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7vvdun3827.fsf@gitster.siamese.dyndns.org>
 <cb7bb73a0811160940wd3624ccl4f1f184cff729b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 19:16:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1mAZ-0007sp-K3
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 19:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbYKPSPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 13:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYKPSPI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 13:15:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbYKPSPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 13:15:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 30AF77E6E3;
	Sun, 16 Nov 2008 13:15:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 003E97E6E1; Sun,
 16 Nov 2008 13:14:51 -0500 (EST)
In-Reply-To: <cb7bb73a0811160940wd3624ccl4f1f184cff729b6@mail.gmail.com>
 (Giuseppe Bilotta's message of "Sun, 16 Nov 2008 18:40:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7ED9ED26-B40A-11DD-8773-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101148>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> For example, because the only remote for the tree is the author's own
> private tree, or because the only remotes are the mirrors on gitorious
> or github. In both cases, there would be no reaso to waste resources,
> bandwidth and screen estate loading and displaying the remote
> references.

Sorry, but you are not making sense.  The above may be a reason not to run
gitweb in such a repository, but if you are viewing such a private tree,
perhaps thru instaweb, wouldn't you be interested in viewing them?

> OTOH, it might make sense to make remote_heads enabled by default (and
> overridable).

Perhaps.  I'll stop commenting on "should this be optional, if so what
should be the default" and let others chime in.  Honestly I do not care
that deeply either way.
