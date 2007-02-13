From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 13:37:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131328440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702131816.27705.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 13:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGwuW-0007XG-G9
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 13:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXBMMhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 07:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXBMMhY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 07:37:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:58374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932289AbXBMMhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 07:37:24 -0500
Received: (qmail invoked by alias); 13 Feb 2007 12:37:22 -0000
X-Provags-ID: V01U2FsdGVkX189cDp8ScY9cDg60rDhJsv7yYWfWq/0ss6Fw0EAFS
	IZAw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702131816.27705.litvinov2004@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39520>

Hi,

On Tue, 13 Feb 2007, Alexander Litvinov wrote:

> Tuesday 13 February 2007 16:06 Johannes Schindelin:
> > At some stage, Alexander wrote this:
> 
> > > The only trouble is the rebase, it does not like \r\n ending and othen
> > > produce unexpected merge conflict. But I don't use rebse to othen to
> > > realy investigate and try to solve the problem.
> >
> > Well, if everybody thinks like you, maybe we do not have to change
> > anything for Windows after all?
>
> I still wish to have working rebase so if git will hanle somehow \r\n it 
> would be nice. But please do not produce the same behavior as cvs does: 
> under cygwin it still use \n !

You really should teach format-patch to output \n patches, and keep all 
your blobs CR free.

> By the way, most windows programmers I work with says 'git is cool but 
> is there gui like tortoise or wincvs ?' :-)

Some time ago, I started playing with a shell extension. Now that MinGW 
git is almost there, I might clean it up... Would you be interested in 
working on it, or is this just wishtalk?

Ciao,
Dscho
