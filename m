From: Martin <html-kurs@gmx.de>
Subject: Re: git svn fetch -with -r doesn't fetch anything
Date: Tue, 05 May 2009 22:30:10 +0200
Message-ID: <4A00A1D2.3020508@gmx.de>
References: <4A009F16.50107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 22:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1RJn-0008C1-O7
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 22:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbZEEUci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbZEEUci
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 16:32:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:53620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751808AbZEEUci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 16:32:38 -0400
Received: (qmail invoked by alias); 05 May 2009 20:30:23 -0000
Received: from p54B2299A.dip0.t-ipconnect.de (EHLO [192.168.0.123]) [84.178.41.154]
  by mail.gmx.net (mp069) with SMTP; 05 May 2009 22:30:23 +0200
X-Authenticated: #4107867
X-Provags-ID: V01U2FsdGVkX185chJRil45+i4a7LXCz8Uuydwyj4R2ATCUvwKnSA
	z917WOzXZ2Q/rA
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A009F16.50107@gmx.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118314>

Okay,
I found it:

> and want to fetch the latest revision (or a little bit in the past) with
>  > git svn fetch -r1234
> 
 > git svn fetch -r1234:HEAD
will do what I want ...

Martin
