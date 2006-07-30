From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pager: config variable pager.color
Date: Sun, 30 Jul 2006 11:33:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607301132320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1G6xHb-0008Rw-G2@moooo.ath.cx>
 <Pine.LNX.4.63.0607300112340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <E1G6zPH-00062L-Je@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 11:33:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G77g0-0002S3-AR
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 11:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWG3Jdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 05:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWG3Jdc
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 05:33:32 -0400
Received: from mail.gmx.net ([213.165.64.21]:37561 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932152AbWG3Jdc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 05:33:32 -0400
Received: (qmail invoked by alias); 30 Jul 2006 09:33:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 30 Jul 2006 11:33:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G6zPH-00062L-Je@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24448>

Hi,

On Sun, 30 Jul 2006, Matthias Lederhofer wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Why? The three users of cmd_log_walk() need to call setup_pager() 
> > explicitely, when cmd_log_walk() can do it for them?
> 
> The explanation is below the commit message:
> "setup_pager has to be called before git_diff_ui_config because the
> latter uses pager_use_color initialized by setup_pager."
> 
> > Oh, and I do not really understand why you would enable color _at all_ if 
> > you want to disable it when paging. Do you have many instances when you 
> > want a color diff which is short enough not to be paged?

> When I use a pager that escapes the escape character or highlights the
> content itself the output of git diff without the pager should have
> colors but not with the pager.  For example using git diff with a
> pathspec is quite short most of the time.  For git diff I have to
> enable paging manually and run git diff | $PAGER usually but git log
> uses the pager automatically and should not use colors with it.

I understand now. Maybe you want to put such reasoning into the commit 
message next time?

Ciao,
Dscho
