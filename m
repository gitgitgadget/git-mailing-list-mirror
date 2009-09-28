From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Mon, 28 Sep 2009 08:45:57 +0200
Message-ID: <4AC05BA5.4050106@viscovery.net>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com> 	<d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com> 	<4AB89B7F.3050902@gmail.com> <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 08:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms9zq-0007xT-AL
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 08:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZI1Gp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 02:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbZI1Gp5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 02:45:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40883 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZI1Gp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 02:45:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ms9zi-0005Uk-0s; Mon, 28 Sep 2009 08:45:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A9DD0A4A1; Mon, 28 Sep 2009 08:45:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129229>

Michael Wookey schrieb:
> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>> Michael Wookey said the following on 22.09.2009 11:17:
>>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>>> Michael, how are you trying to compile git? With the IDE or the
>>>> GNU Make? Which version of MSVC? If you use the IDE, can you make
>>>> sure it doesn't contain the UNICODE define in the compiler
>>>> section of the properties of the projects?
>>> I'm using the VS 2008 Professional IDE (the solution doesn't open
>>> in VS 2005). I made no changes to the build settings. In the
>>> Preprocessor section of the project, UNICODE is defined.
>> Were these projects generated with the Vcproj generator in
>> contrib/buildsystem, with the Qmake generator, or the projects from Frank's
>> repo?
> 
> The project was generated from the vcproj generator in
> contrib/buildsystem from git.git/master.

What's the status of this? Do Sebastian Schuberth's patches

http://article.gmane.org/gmane.comp.version-control.msysgit/7152
http://article.gmane.org/gmane.comp.version-control.msysgit/7153

make a difference?

-- Hannes
