From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] MinGW readdir reimplementation to support d_type
Date: Fri, 08 May 2009 07:45:17 +0200
Message-ID: <4A03C6ED.5050904@trolltech.com>
References: <1239224507-5372-1-git-send-email-marius@trolltech.com> <49DE5BDE.9050709@kdbg.org> <49DEFA30.1000101@gmail.com> <49E10F5A.9010400@kdbg.org> <20090507212629.GC6751@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 08 07:45:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Ith-0004LE-Cx
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 07:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbZEHFpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 01:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbZEHFpQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 01:45:16 -0400
Received: from hoat.troll.no ([62.70.27.150]:35084 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbZEHFpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 01:45:15 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 91A6B2106F;
	Fri,  8 May 2009 07:45:11 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 2CA8821061;
	Fri,  8 May 2009 07:45:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <20090507212629.GC6751@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118564>

Heiko Voigt said the following on 07.05.2009 23:26:
> On Sat, Apr 11, 2009 at 11:44:58PM +0200, Johannes Sixt wrote:
>> With a comment in the commit message, it would have been clear,
>> perhaps.
>> 
>> I'll carry this in my (private) tree for a while with the below
>> squashed in to avoid a lot of warnings.
> 
> What happened to this patch? Is there any reason it can not be
> included? I can confirm the factor 2 speedup which is very
> noticeable. Especially when working with "git gui" which does git
> status very often.

Msysgit 1.6.3 (http://code.google.com/p/msysgit/downloads/list) contains 
this patch ontop of baseline 1.6.3. It hasn't made it into the mainline 
yet though. All in good time :-)

--
.marius
