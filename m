From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Mon, 28 Sep 2009 10:10:13 +0200
Message-ID: <4AC06F65.1020301@viscovery.net>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com> 	<d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com> 	<4AB89B7F.3050902@gmail.com> <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com> 	<4AC05BA5.4050106@viscovery.net> <d2e97e800909280047l5da52ffdxd86589cda4542f46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 10:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsBJR-000506-FM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 10:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZI1IKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 04:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbZI1IKN
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 04:10:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15370 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZI1IKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 04:10:12 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MsBJG-0008H8-Cz; Mon, 28 Sep 2009 10:10:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 17E20A4A1; Mon, 28 Sep 2009 10:10:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <d2e97e800909280047l5da52ffdxd86589cda4542f46@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129234>

Michael Wookey schrieb:
> 2009/9/28 Johannes Sixt <j.sixt@viscovery.net>:
>> Michael Wookey schrieb:
>>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>>> Michael Wookey said the following on 22.09.2009 11:17:
>>>>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>>>>> Michael, how are you trying to compile git? With the IDE or the
>>>>>> GNU Make? Which version of MSVC? If you use the IDE, can you make
>>>>>> sure it doesn't contain the UNICODE define in the compiler
>>>>>> section of the properties of the projects?
>>>>> I'm using the VS 2008 Professional IDE (the solution doesn't open
>>>>> in VS 2005). I made no changes to the build settings. In the
>>>>> Preprocessor section of the project, UNICODE is defined.
>>>> Were these projects generated with the Vcproj generator in
>>>> contrib/buildsystem, with the Qmake generator, or the projects from Frank's
>>>> repo?
>>> The project was generated from the vcproj generator in
>>> contrib/buildsystem from git.git/master.
>> What's the status of this?
> 
> I was hoping that this gets included into git.git because it fixes a
> real issue with MSVC builds. Since Junio is away, perhaps Shawn can
> take the patch into his interim tree?
> 
> BTW - would you mind giving this patch an ack?

As I said, the patch looks fine. However, in the commit message you say:

  MSVC builds define UNICODE which results in the "WIDE" variation of
  Win32 API's being used.

But since Marius has built the code without your patch, this justification
must be incomplete. I won't give a formal Ack until this is clarified.

Please work with Marius to figure out why your build uses UNICODE while
Marius's doesn't.

-- Hannes
