From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Spurious warning when moving a file in presence of submodules
Date: Fri, 11 Oct 2013 19:53:04 +0200
Message-ID: <52583B00.8040700@web.de>
References: <vpq38o7nao9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 11 19:53:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUgu2-0000as-TL
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 19:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab3JKRxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 13:53:15 -0400
Received: from mout.web.de ([212.227.17.12]:50032 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567Ab3JKRxO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 13:53:14 -0400
Received: from [192.168.178.41] ([91.3.182.215]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M2MUi-1VnbKO2XQ4-00s72K for <git@vger.kernel.org>;
 Fri, 11 Oct 2013 19:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <vpq38o7nao9.fsf@anie.imag.fr>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:6FEkhD4gq3fGeZGcPaU3VO2gbYTKxIrgmw6wBNyo9nNaCl1cr5W
 q8hdwOxiqq5urSPjrgF9lrGu9oRCUcyzW5UjdOmeAmWGPv4ftY4vluj9Fhkw8cPP53f8CsG
 JJxTdamdPimqaXm6ELv71vukGBbXWIXmlMEJXI/inJd0QYRAPDAwBipAa+bFb1BXPFN9ewU
 7cr8YPnd8EwhcQ5si6qWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235914>

Hi Matthieu,

Am 11.10.2013 16:29, schrieb Matthieu Moy:
> I'm getting this warning:
> 
>   warning: Could not find section in .gitmodules where path=XXX
> 
> whenever I use "git mv" to move a file in a repository containing a
> submodule. The file is outside the submodule and is completely
> unrelated, so I do not understand the intent of the warning.
> 
> My understanding (without looking at the code in detail) is that Git
> tries to be clever about submodule renames, hence checks whether the
> source file is a submodule. But then if the lookup fails, it should just
> silently move on to "normal file move" mode I guess...

Right. Thanks for reporting, I can reproduce that here and am currently
looking into that.
