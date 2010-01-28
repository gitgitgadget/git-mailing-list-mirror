From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 22:29:32 +0100
Message-ID: <4B6201BC.9030800@web.de>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>	 <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nabvo-0004Km-RA
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 22:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab0A1V3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 16:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456Ab0A1V3f
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 16:29:35 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:41845 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0A1V3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 16:29:34 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5C40614CC34FE;
	Thu, 28 Jan 2010 22:29:33 +0100 (CET)
Received: from [80.128.66.195] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nabvh-00010q-00; Thu, 28 Jan 2010 22:29:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Wgz51j7ypXvQk3XxS0yKsHHBWUbOPGlD3rF2g
	h1VXi9klbAo+RxX1y1xu32lPM933VwCn2rboWCesqntMnyOgYo
	fMNEC9vWPABAjKhrCnyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138273>

Am 28.01.2010 22:17, schrieb Mike Linck:
> Well, even gitk can't show me the information I'm looking for if the
> parent branch ended up fast-forwarding to include the changes made in
> the topic branch.  As far as I can tell there is *no way* to tell what
> changes were made in a particular branch after a fast-forward has
> taken place, which seems to make it hard to organize fixes for
> specific topics/bugs/tickets.

You could disable fast forward merges using the --no-ff option. Then
git will always create a merge commit even if it could have done a
fast forward. This can be enabled permanently for a branch with
'git config branch.master.mergeoptions  "--no-ff"'. We use that at my
dayjob to preserve the branches after merging.
