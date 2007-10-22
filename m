From: Federico Mena Quintero <federico@novell.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Mon, 22 Oct 2007 14:36:25 -0500
Message-ID: <1193081785.4522.181.camel@cacharro.xalalinux.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se>
	 <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se>
	 <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se>
	 <Pine.LNX.4.64.0710221558230.25221@racer.site>  <471CBEB1.2030008@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 21:35:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik33E-0001dJ-TL
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbXJVTet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbXJVTet
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:34:49 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:9456 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXJVTes (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 15:34:48 -0400
Received: from [164.99.195.83] ([164.99.195.83])
	by jericho.provo.novell.com with ESMTP; Mon, 22 Oct 2007 13:34:32 -0600
In-Reply-To: <471CBEB1.2030008@op5.se>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62039>

On Mon, 2007-10-22 at 17:16 +0200, Andreas Ericsson wrote:

> To me, it's more along the lines of "let git help me not make the 
> mistake of hacking on a six-week old codebase when I've explicitly asked 
> it to merge these and those remote tracking branches into these and 
> those local branches". Not updating those branches when there *are* 
> changes on them is something users can understand and will probably also 
> appreciate, but the reason for not allowing even fast-forwards escape me.

I'd love this behavior, FWIW.

The "branches should not track their origin by default" seems suited
only to Linux kernel maintainers who frequently pull from many different
people, not to "random hacker who wants to keep track of a project he
doesn't maintain" :)

  Federico
