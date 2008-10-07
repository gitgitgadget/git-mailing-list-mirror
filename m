From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: [RFC] git rev-contains [Was: merge -s ffonly]
Date: Tue, 7 Oct 2008 20:58:15 +0200
Message-ID: <20081007185815.GA10744@strlen.de>
References: <20081006235611.GA17662@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 21:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnHmO-0007sk-TW
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 20:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYJGS6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbYJGS6T
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 14:58:19 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:33513 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752486AbYJGS6T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2008 14:58:19 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1KnHl9-0002r4-8f; Tue, 07 Oct 2008 20:58:15 +0200
Content-Disposition: inline
In-Reply-To: <20081006235611.GA17662@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97742>

Hello,

> +	if test -n "$(git rev-list $1..HEAD)"
I already wrote similar tests and I wonder if this couldn't be done in a
new builtin command more effectively.  Something like

	git rev-contains HEAD "$1"

.  I expect it to be faster and maybe it prevents a command line
overflow?!  (I remember something like 32000 chars max in a command, but
I could not trigger that with bash.)

Best regards
Uwe
