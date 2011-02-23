From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: non-interactive rebase opens vim
Date: Wed, 23 Feb 2011 14:38:42 +0100
Message-ID: <1298468234-sup-5475@localhost.localdomain>
References: <4D6509C4.4000501@syntevo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 14:38:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsEvb-00088d-PM
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 14:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab1BWNir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 08:38:47 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:55340 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754644Ab1BWNiq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 08:38:46 -0500
Received: (qmail invoked by alias); 23 Feb 2011 13:38:43 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp022) with SMTP; 23 Feb 2011 14:38:43 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+APUFtXq2A3YwQCJCrxyCXlc4IVAUv5U5RAzKkt2
	kGakklEV/RGv0o
Received: by mail.gmx.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 14:38:42 +0100
In-reply-to: <4D6509C4.4000501@syntevo.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167694>

Excerpts from Marc Strapetz's message of Wed Feb 23 14:21:08 +0100 2011:
> which brings up vim. I would not expect that. The main problem with this
> behavior is that, when invoked from our GUI client, this results in the
> client hanging forever. What forces git to open vim and how can I avoid
> that?

Maybe use gvim --nofork as editor?
Its not a true fix.. but the most simple workaround which comes to my
mind.

Marc Weber
