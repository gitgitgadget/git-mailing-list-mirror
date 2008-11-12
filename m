From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fixing duplicated history
Date: Wed, 12 Nov 2008 14:53:55 -0800
Message-ID: <7vod0klfng.fsf@gitster.siamese.dyndns.org>
References: <20081112222346.GA24013@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: me@felipebalbi.com
X-From: git-owner@vger.kernel.org Wed Nov 12 23:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Oce-0005D6-4P
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYKLWy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbYKLWyZ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:54:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbYKLWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:54:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E5E87C5C2;
	Wed, 12 Nov 2008 17:54:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 899F77C5BC; Wed,
 12 Nov 2008 17:54:02 -0500 (EST)
In-Reply-To: <20081112222346.GA24013@frodo> (Felipe Balbi's message of "Thu,
 13 Nov 2008 00:23:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D924E00C-B10C-11DD-9108-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100831>

Felipe Balbi <me@felipebalbi.com> writes:

> I have a git tree which history is completely messed up with duplicated
> entries. By reading git man pages I saw that it might be possible to
> delete those duplicated entries with git reflog delete, am I reading it
> right ?
>
> If so, would it cause any problems to the users who already cloned the
> original tree ? I mean, will git see it as a different history line and
> try a merge or will it figure it's the same tree with the duplicated
> entries removed ?

I assume that you meant "commit" by "entry", and also I assume that you
read "git filter-branch" not "git reflog delete".  Then you are right.

And rewriting history with filter-branch will cause problems to the
downstream users.
