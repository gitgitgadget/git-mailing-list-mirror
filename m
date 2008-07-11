From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/6] Using the page site selection turned out to
	be cumbersome.
Date: Fri, 11 Jul 2008 03:52:49 +0000
Message-ID: <20080711035249.GA32652@spearce.org>
References: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com> <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com> <1215729573-26536-3-git-send-email-robin.rosenberg@dewire.com> <20080711034717.GA32633@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 05:53:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH9hd-0002Va-Ga
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 05:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYGKDwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 23:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbYGKDwu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 23:52:50 -0400
Received: from george.spearce.org ([209.20.77.23]:48132 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYGKDwu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 23:52:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EEEC838222; Fri, 11 Jul 2008 03:52:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080711034717.GA32633@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88077>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > +         <action
> > +               class="org.spearce.egit.ui.internal.actions.BranchAction"
> > +               id="org.spearce.egit.ui.action1"
> > +               label="Kolla"
> 
> What does this label mean?
> 
> > +         <action
> > +               class="org.spearce.egit.ui.internal.actions.ResetAction"
> > +               id="org.spearce.egit.ui.action1"
> > +               label="Titta"
> 
> Ditto.  You can use i18n translations in plugin.xml by putting these
> into a properties file and using %propertyname inside the XML.
> So we can prepare translations, but given that all of our source
> is documented in English I would prefer the property names to be
> the English name if we are going to start supporting translations.

Never mind, I see you fixed this in 6/6.  Don't bother reworking
the series of this minor issue.

-- 
Shawn.
