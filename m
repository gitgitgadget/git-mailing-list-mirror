From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 14:12:48 +0100
Message-ID: <46d6db660701230512l571d8c35k24e475c3fe0933cf@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <200701222127.09601.johannes.sixt@telecom.at>
	 <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 14:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9LSX-0004rV-58
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbXAWNMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbXAWNMw
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:12:52 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:38195 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965032AbXAWNMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 08:12:51 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1010809wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 05:12:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DTjageKUTlBkHVkuIG0aQkGtouG/tDFFkbe1pmSwxoyIjVeAD1Csz2h+wUAVRIeE+ZyE61rjhWOipd/xI1BawYTzD6JbDV1HeNym3OPN+mpexElAYYiTTKNOEQRe5B8FjAsAX0I4/2K3f0zSyarQ+lLaLClrDwMm2uA7NEcacnY=
Received: by 10.78.193.19 with SMTP id q19mr330808huf.1169557969140;
        Tue, 23 Jan 2007 05:12:49 -0800 (PST)
Received: by 10.78.175.18 with HTTP; Tue, 23 Jan 2007 05:12:48 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37511>

On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Maybe we have to go the other way round, just as POSIX git does: instead
> of spawning the pager, we should _beginthread() the actual work, and
> execl() the pager.

actually, one other issue is the spawning of vim when doing commits.
I usually end up in using -m "my commit message" because of these
2 errors (basically terminal not recognized, I tried many different
options to no avail)

$ git commit -a
Vim: Warning: Output is not to a terminal
Vim: Warning: Input is not from a terminal

> On the third hand, I fully expect git on Windows to be used only by GUI
> wieners who cannot handle the command line, let alone a pager! ("WTF! How
> do I go back to that dollar thingie? You know, where I type git-blabla?")

maybe I'm stuck with windows at work, but I still use vim inside mingw.
it would be nice to fix the pager issue...

>
> Since Tcl/Tk is available for MinGW, git-gui seems to be a way to go
> there.

I did not know about this... let me try... yes! not bad...
it's working too, so your assumption was correct.

thanks for the suggestion.

--
Christian
