From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: use themed tk widgets
Date: Fri, 17 Apr 2009 12:10:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904171206290.6675@intel-tinevez-2-302>
References: <873ac8m8jg.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, paulus@samba.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 12:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lul3Z-0005T4-TO
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 12:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbZDQKKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 06:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbZDQKKw
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 06:10:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:43053 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755263AbZDQKKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 06:10:51 -0400
Received: (qmail invoked by alias); 17 Apr 2009 10:10:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp034) with SMTP; 17 Apr 2009 12:10:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1gso7XNS12itJckq+l08gTVCe9fyMaZ6YMohfRV
	2MYmg0AWJX88DJ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <873ac8m8jg.fsf@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116730>

Hi,

On Fri, 17 Apr 2009, Pat Thoyts wrote:

> 
>   With Tk 8.5+ use the themed widgets to improve the appearence
>   on Windows and MacOSX. On X11 less difference is apparent but
>   users can select alternate themes by setting *TkTheme in the
>   resource database (eg: *TkTheme: clam)
> 
>   With Tk 8.6 there is a built-in font selection dialog and this
>   patch will make use of that when available as on Windows and
>   MacOSX it calls the native font selection dialog.

I had several conflicts applying your patch, and I do not have object 
a346bd5 here (not even fetching from Paul's repository), but I fixed them 
all up.  (In function setoptions(), you seemed to remove a part asking 
about the windowingsystem being "aqua", but my gitk did not have that.)

The end result can be marveled at in 4msysgit's 'ttk' branch.

I did not have time to go through your changes, though.

But can I place another wish with you?  It all looks nicer now, except the 
text which is not anti-aliased...  Any chance to fix that?

Ciao,
Dscho
