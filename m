From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 16:20:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <200701231322.32987.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231518310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701231506.32396.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 16:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9NS6-00030S-Ca
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbXAWPUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbXAWPUe
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:20:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:44349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932437AbXAWPUd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:20:33 -0500
Received: (qmail invoked by alias); 23 Jan 2007 15:20:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 23 Jan 2007 16:20:31 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701231506.32396.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37531>

Hi,

On Tue, 23 Jan 2007, Andy Parkins wrote:

> On Tuesday 2007 January 23 14:21, Johannes Schindelin wrote:
> 
> > Uhm. You do understand that we use MinGW to port to, not _plain_ 
> > Windows? So we do have a "less".
> 
> Nope; I didn't.  Oh dear.  I've obviously misunderstood.  I thought 
> MinGW was for compiling to native Windows?  Do you use MinGW to compile 
> to cygwin as well?

MinGW and cygwin differ in one very important point: cygwin needs an extra 
dll, MinGW does not.

However, the development environment is still console-based, with a bash 
so you can run configure and simple bash scripts. It is definitely more 
catering to Unix types than Windows types.

So yes, there is a bash, and there is a less, and there is perl.

> > That was not Windows. That was DOS.
> 
> I'm sure pipes were still awful in Win98.  I accept though, that it is 
> possible Windows has changed in the last 9 years :-)

Win98 was based on DOS. Windows XP is based on VMS.

<tongue-in-cheek>
Yes, I know. They left everything behind, and started Windows NT anew. 
Yeah, right.
</tongue-in-cheek>

> > With less, on the other hand, you just exit the pager, or let it 
> > search through stdin. It is so much more convenient.
> 
> That sounds better than I remember.  You'll have talked me into 
> migrating to Windows soon :-)

I don't understand. The command "less" is the default pager of git, so you 
are prone to have used it already.

Ciao,
Dscho
