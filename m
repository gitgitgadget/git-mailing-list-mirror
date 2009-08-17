From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [msysGit] quick question about __stdcall at run-command.c mingw.c
Date: Mon, 17 Aug 2009 10:43:44 +0200
Message-ID: <4A891840.4050403@viscovery.net>
References: <1976ea660908161619x5182762sade051f24fef13db@mail.gmail.com> <a5b261830908161703l2296448l698d07d01ae8a6d3@mail.gmail.com> <4A890C32.6010507@viscovery.net> <alpine.DEB.1.00.0908171018490.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@googlemail.com>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcxon-0000ce-T1
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416AbZHQInp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757401AbZHQInp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:43:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39165 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400AbZHQIno (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:43:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mcxof-0000Ut-0s; Mon, 17 Aug 2009 10:43:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B6860C6C2; Mon, 17 Aug 2009 10:43:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0908171018490.4991@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126142>

Johannes Schindelin schrieb:
> On Mon, 17 Aug 2009, Johannes Sixt wrote:
>> Pat Thoyts schrieb:
>>> 2009/8/17 Frank Li <lznuaa@gmail.com>:
>>>> I am tring to clear VC build patch.
>>>>
>>>> I found __stdcall position break MSVC build.
>>>>
>>>> static __stdcall unsigned run_thread(void *data)
>>>>
>>>> MSVC require __stdcall should be between return type and function 
>>>> name. like static unsigned __stdcall run_thread(void *data)
>>>>
>>>> I think msys gcc should support MSVC format.
> 
> I think that it does.
> 
> But it is _your_ duty to check.

Cool down. Asking for "please could you check whether this works" *if* you
don't have the infrastructure to test it yourself is certainly dutyful enough.

Do you have an Irix, Solaris, HP box on your desk next to your Linux, so
that you don't have to ask others to test your patches?

-- Hannes
