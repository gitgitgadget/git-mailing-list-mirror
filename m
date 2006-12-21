From: Nicolas Pitre <nico@cam.org>
Subject: Re: specify charset for commits
Date: Thu, 21 Dec 2006 13:48:35 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612211336240.18171@xanadu.home>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus>
 <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com>
 <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 19:48:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxSyD-00018l-EQ
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 19:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423021AbWLUSsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 13:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423024AbWLUSsi
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 13:48:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20964 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423021AbWLUSsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 13:48:37 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAN00IVW08ZEC01@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Dec 2006 13:48:36 -0500 (EST)
In-reply-to: <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35080>

On Thu, 21 Dec 2006, Junio C Hamano wrote:

> Alexander Litvinov <litvinov2004@gmail.com> writes:
> 
> > May we can add new header into commit with commit text encoding ?
> 
> I do not think we want to change the commit header, nor we would
> want to re-encode, but I can see two possible improvements:
> 
>  (1) git-am should default to -u; this was suggested on the list
>      long time ago, but is an incompatible change.  v1.5.0 we
>      can afford to be incompatible to make it more usable and
>      safer.
> 
>  (2) update commit-tree to reject non utf-8 log messages and
>      author/committer names when i18n.commitEncoding is _NOT_
>      set, or set to utf-8.

This would be a good thing, both of them actually.

The Linux kernel already contains different charsets for author full 
name and/or commit messages making git-log output a mix of encodings 
already.  And sometimes this inconsistency comes from the _same_ author.


Nicolas
