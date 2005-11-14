From: Andreas Ericsson <ae@op5.se>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 15:34:12 +0100
Message-ID: <4378A064.3000200@op5.se>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>	 <437870AF.8060607@op5.se>	 <cda58cb80511140322v686e4ee0g@mail.gmail.com>	 <43787831.3030404@op5.se>	 <cda58cb80511140355q1add0ba5n@mail.gmail.com>	 <43787E6E.8030702@op5.se>	 <cda58cb80511140600k2c0188c4i@mail.gmail.com>	 <59a6e5830511140604o12af40fdp1b05cc84962d5903@mail.gmail.com> <cda58cb80511140631n46fdce52n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 15:39:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbfQ1-0003sK-FK
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 15:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVKNOeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 09:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVKNOeO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 09:34:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:16578 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751137AbVKNOeN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 09:34:13 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 909796BCBE
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 15:34:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <cda58cb80511140631n46fdce52n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11803>

Franck wrote:
> 2005/11/14, Wayne Scott <wsc9tt@gmail.com>:
> 
> well I found a fix, but I don't know why it actually fixes things :)
> 
> I replaced in .bash_profile
>         PATH=~/bin:$PATH
> by
>         PATH=$HOME/bin:$PATH
> 
> Any ideas ?
> 

~ is only interpolated as $HOME when bash (or /bin/sh) is run as an 
interactive shell. Tab-completion won't work from non-interactive shells 
either.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
