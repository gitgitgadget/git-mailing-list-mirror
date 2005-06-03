From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: qgit-0.3
Date: Fri, 03 Jun 2005 14:18:50 +0200
Message-ID: <42A04AAA.4080205@gorzow.mm.pl>
References: <20050601111949.90043.qmail@web26303.mail.ukl.yahoo.com> <1117770909.31082.121.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:18:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeB5H-0006Ye-B7
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 14:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFCMSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 08:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFCMSl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 08:18:41 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:9939 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261227AbVFCMSi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 08:18:38 -0400
Received: (qmail 15106 invoked from network); 3 Jun 2005 12:18:37 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <benh@kernel.crashing.org>; 3 Jun 2005 12:18:37 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id BF38358FFD9;
	Fri,  3 Jun 2005 14:18:50 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1117770909.31082.121.camel@gaston>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Benjamin Herrenschmidt wrote:

>On Wed, 2005-06-01 at 13:19 +0200, Marco Costalba wrote:
>  
>
>>New version of qgit, the QT/C++ git viewer.
>>
>>Download at:
>>
>>http://prdownloads.sourceforge.net/qgit/qgit-0.3.tar.gz?download
>>
>>This time we use scons instead of qmake as build system (many thanks to Stanislav Karchebny), I
>>hope people have less problems compiling it.
>>
>>As before just run make and copy the bin in the path.
>>
>>New feature is async loading of diff and file blobs, should be much faster navigate the logs with
>>secondary windows (double click on logs or file names to show) opened.
>>    
>>
>
>I spent 1/2h and never managed to build it. When it doesn't find some
>includes, it doesn't look for some Qt related binaries in the right
>path, or whatever, it's just basically unbuildable.
>
>Ben.
>
>
>  
>
It is buildable, but you need to install your own scons in the correct
paths, e.g.
on Gentoo:

emerge scons
And then build it by hand with:
./configure
scons

Then you get bin/qgit which is ready to run and/or copy.

AstralStorm

