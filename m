From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
 UTF8
Date: Mon, 21 Jan 2008 11:24:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211121440.5731@racer.site>
References: <fn1nl6$ek5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGum2-000550-Oh
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758957AbYAULYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 06:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758895AbYAULYh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:24:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:42246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753163AbYAULYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 06:24:36 -0500
Received: (qmail invoked by alias); 21 Jan 2008 11:24:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 21 Jan 2008 12:24:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/f6wlr+QrfR5+vAIrV7bjL4SpqHzkCJaJl1wIQhM
	6z+V15Xz2JPRZi
X-X-Sender: gene099@racer.site
In-Reply-To: <fn1nl6$ek5$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71264>

Hi,

On Mon, 21 Jan 2008, Mark Junker wrote:

> Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8 for readdir 
> and get_pathspec.
> 
> I had to change get_pathspec too because otherwise git-add wouldn't work 
> anymore because it uses the output of get_pathspec as strings to compare 
> with the output of readdir.
> 
> I'm quite unsure because this is my first patch for the git project and 
> I have several questions:
> 
> 1. Is FIX_UTF8_MAC the right name for this "feature"?
> 2. Do I have to introduce a configuration option for this "feature"?
> 
> Signed-off-by: Mark Junker <mjscod@web.de>

I hate three facts about this patch:

- it is too specific to the MacOSX filesystem issues (and better 
  alternatives have _already_ been proposed),

- it is a new feature and not a bug fix, very, _very_ late in the rc 
  cycle,

- it contains questions in the commit message? WTF?  Should it not be 
  marked as PATCH/RFC, possibly without a signoff to make sure that you 
  want to discuss it first?

It's possible I am grumpy because everybody and her dog seems to work on 
her little projects, while I listen to Junio and try to work with/on 
"master" already since a month.

Ciao,
Dscho
