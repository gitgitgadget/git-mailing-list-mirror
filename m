From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 19:40:26 +0200
Message-ID: <20071016174026.GA506@uranus.ravnborg.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <20071016070421.GE13801@spearce.org> <11F85069-1013-4685-9D56-C53F0F8231BF@MIT.EDU> <4714F2CA.5000509@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@MIT.EDU>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhqOB-0008DA-VP
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539AbXJPRi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759111AbXJPRi6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:38:58 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:48312 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761663AbXJPRi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:38:57 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 3EED4E3100E;
	Tue, 16 Oct 2007 19:38:53 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id B6BA5580D2; Tue, 16 Oct 2007 19:40:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4714F2CA.5000509@op5.se>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61231>

General comment about the <tab> versus spaces debate.

The root problem is stupid editors that does not show when a tab is used
and when spaces are used.
So people continue to mix tabs and spaces.

In linux people generally think that 8 aligned spaces equal a tab
which is IMHO stupid.
Tabs should be used for indent and not general alignment.

Consider:
<tab>if (some long condition that
<tab>....&& spans two lines) {
<tab><tab>my_private_printf("bla bla bla"
<tab><tab>.................."more bla bla\n");
<tab><tab>}

This will look good and align "more bla bla\n" as
intended no matter your tab setting.
But replacing the 8 spaces with a tab will
cause it to look bad.

And using tabs let me use the tabsetting I like (8) and other
use the tab setting they like (2,3,4,5,6,7) and all is good.

And why a tab is 8 spaces and in considered good.
Thats to teach people to write small independent functions
that does _one_ thing and does it well.
Mega functions with 6 times indent or more usually needs to
be breaked up anyway.

	Sam
