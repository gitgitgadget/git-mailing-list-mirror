From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Change in "git checkout" behaviour between 1.6.0.2 and 1.6.0.3
Date: Wed, 12 Nov 2008 19:44:47 +0000
Message-ID: <80od0ksp8w.fsf@tiny.isode.net>
References: <80wsf9ovsp.fsf@tiny.isode.net>
            <491B131D.2050501@drmicha.warpmail.net>
            <80r65gon3m.fsf@tiny.isode.net>
            <7vprl0oiw6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0LfC-0003iJ-Uc
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbYKLTov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYKLTov
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:44:51 -0500
Received: from rufus.isode.com ([62.3.217.251]:43774 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbYKLTou (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:44:50 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SRsyLwAJxXun@rufus.isode.com>; Wed, 12 Nov 2008 19:44:47 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 12 Nov 2008 19:44:47 +0000
X-Hashcash: 1:20:081112:gitster@pobox.com::+itcnGTN4/nuDv/9:000000000000000000000000000000000000000000005g5t
X-Hashcash: 1:20:081112:git@drmicha.warpmail.net::2q3qaskjDgN71MEi:00000000000000000000000000000000000004Wmm
X-Hashcash: 1:20:081112:git@vger.kernel.org::z6n99FyNBG2AAITd:000000000000000000000000000000000000000000424q
In-Reply-To: <7vprl0oiw6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 12 Nov 2008 11\:15\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100809>

Junio C Hamano <gitster@pobox.com> writes:

[...]

> Yeah, it was meant to allow:
>
> 	git clone -n $there $here
>         cd $here
>         git checkout
>
> and was not taking care of the case to switch branches when the initial
> checkout is made.

That specific sequence does work.  I guess that's why I hadn't noticed
the issue for so long (I guess git's test suite has some tests using
"clone -n", and perhaps they're of that form).

> Perhaps this would help.

Works for me.

[...]
