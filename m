From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sat, 22 Apr 2006 13:25:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604221318500.30863@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vzmieo2j3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 22 22:42:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOvd-0004Ip-Ua
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWDVUmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDVUmA
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:42:00 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:28112 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751168AbWDVUl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:41:57 -0400
Received: from mailrelay.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MBQTEO020636;
	Sat, 22 Apr 2006 11:26:30 GMT
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8F236C63;
	Sat, 22 Apr 2006 13:25:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 82ACEC24;
	Sat, 22 Apr 2006 13:25:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 5DA46B5D;
	Sat, 22 Apr 2006 13:25:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmieo2j3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19056>

Hi,

On Fri, 21 Apr 2006, Junio C Hamano wrote:

>   - diff --stat: do not drop rename information.
> 
>     Johannes suggested "file => /dev/null" to show a deleted
>     file as if a rename was done.  While I think it makes some
>     sense, I am afraid it diverges too much from the traditional
>     diffstat output.  I am undecided, somewhat negative, about
>     the suggestion.

It was not so much a suggestion, but a misinterpretation of your patch. I 
am also undecided and slightly negative about it.

> * The 'pu' branch, in addition, has these.
> 
>   - gitk: Fix geometry on rootless X (Johannes Schindelin)

I talked to Paul about this, and was not only slightly negative about it. 
The suggestion was to either use native versions of Tk (which might or 
might not fix it), or fix Tk.

Having spent already some time with this workaround, I am not willing to 
invest more of it, though.

So, if people want to do something about this patch, go wild.

Ciao,
Dscho
