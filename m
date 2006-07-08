From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitweb/test/Marchen always untracked?
Date: Sat, 8 Jul 2006 21:02:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607082058340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060708185322.GA17708@spearce.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-797604247-1152385350=:29667"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 21:02:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzI4b-0006qD-Bo
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 21:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWGHTCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 15:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWGHTCc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 15:02:32 -0400
Received: from mail.gmx.de ([213.165.64.21]:58538 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030217AbWGHTCc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 15:02:32 -0400
Received: (qmail invoked by alias); 08 Jul 2006 19:02:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 08 Jul 2006 21:02:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060708185322.GA17708@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23498>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-797604247-1152385350=:29667
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 8 Jul 2006, Shawn Pearce wrote:

> I'm not sure what is going on here but on my Mac OS X system
> the file `gitweb/test/Marchen` is always untracked:

I noticed that problem also. It seems to be yet another encoding problem, 
because you see the Latin1 interpretation of a UTF-8 encoded umlaut, ä.

What is fascinating:

> git-ls-files --cached|grep chen.$
"gitweb/test/M\303\244rchen"

but

> git-ls-files --others|grep chen.$
"gitweb/test/Ma\314\210rchen"

Will investigate,
Dscho

---1148973799-797604247-1152385350=:29667--
