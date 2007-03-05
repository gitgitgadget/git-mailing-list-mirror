From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Conflict editing
Date: Mon, 5 Mar 2007 12:25:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051223420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <190CCFDA-7BCC-4CC9-81D5-F38B14D8D54D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 12:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOBJx-00081w-Jv
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 12:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbXCELZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 06:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbXCELZe
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 06:25:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:47814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932563AbXCELZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 06:25:34 -0500
Received: (qmail invoked by alias); 05 Mar 2007 11:25:32 -0000
X-Provags-ID: V01U2FsdGVkX18DlUFv+ywDgYEpI4LZMwWboBdnOP6nC/x3CSIiMY
	eo9ggttvQgmyj3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <190CCFDA-7BCC-4CC9-81D5-F38B14D8D54D@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41436>

Hi,

On Mon, 5 Mar 2007, Brian Gernhardt wrote:

> On Mar 4, 2007, at 7:43 AM, Johannes Schindelin wrote:
> 
> > Of course, this script is dumb and has no way to edit files whose 
> > names contain spaces
> 
> Wouldn't using xargs fix that?

I tried that first, even in the proper form to catch newlines also, with 
"-z" for ls-files and "-0" for xargs.

Alas, vi complained to me by saying "Not started from a terminal", and 
wrecking my terminal settings. For example, echo was set to off, and 
Ctrl+C no longer worked.

Since I am a nice person, I did not want you to have the same experience 
with this dumb script.

Ciao,
Dscho
