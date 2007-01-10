From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Re: git-mailinfo '-u' argument should be default.
Date: Wed, 10 Jan 2007 11:24:53 +0800
Message-ID: <1168399493.14763.462.camel@shinybook.infradead.org>
References: <1147452362.2794.452.camel@pmac.infradead.org>
	 <1168351405.14763.347.camel@shinybook.infradead.org>
	 <7vzm8skphz.fsf@assigned-by-dhcp.cox.net>
	 <1168386544.14763.407.camel@shinybook.infradead.org>
	 <7vejq3hf8m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 04:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4U4u-0007ef-Ou
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 04:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbXAJDYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 22:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbXAJDYi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 22:24:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47622 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932695AbXAJDYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 22:24:37 -0500
Received: from mail3.quantacn.com ([61.152.217.200] helo=[172.21.170.25])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H4U4m-00064X-QD; Wed, 10 Jan 2007 03:24:35 +0000
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejq3hf8m.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36475>

On Tue, 2007-01-09 at 16:55 -0800, Junio C Hamano wrote:
> > That's not the use case for the -n option. Their case is what the
> > i18n.commitencoding configuration option exists for.
> 
> I think you missed a subtle difference.
> 
> For a project that is latin-1 only (or ISO-2022 only, for that
> matter -- 'only' is the real keyword here), users did not have
> to do anything, and happily kept using git, and that includes
> that they did not have to set i18n.commitencoding to anything.

Well, apart from the fact that gitweb and git-format-patch would be
mislabelling their output, for example.

> Defaulting to -u now means disrupt their established workflows
> are disrupted by people coming from UTF-8 only world.  They now
> are forced to set i18n.commitencoding to latin-1 and/or use -n.
>
> When we inconvenience others by making changes to make our own
> life easier, it is not a good idea to insult them at the same
> time; rather, we should be asking forgiveness from them.

This is true. Sometimes when we fix bugs, we find that people were
relying on the old behaviour and are inconvenienced by the fix. That's
unfortunate, and we should make sure there's a simple way for those
people to adapt -- which in this case is setting 'i18n.commitencoding'.

I'm not entirely sure where the 'insulting' comes in though -- I think
you're referring to a comment which was 
 a) Only in my cover message rather than in the documentation, and
 b) Not even relevant to these people -- these people should be 
    setting i18n.commitencoding to match their status quo, and my
    disparaging comment was about the '-n' option which should be
    avoided.

-- 
dwmw2
