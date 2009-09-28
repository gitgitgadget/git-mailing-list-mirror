From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Mon, 28 Sep 2009 17:47:08 +1000
Message-ID: <d2e97e800909280047l5da52ffdxd86589cda4542f46@mail.gmail.com>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 
	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com> 
	<d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com> 
	<4AB89B7F.3050902@gmail.com> <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com> 
	<4AC05BA5.4050106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 28 09:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsAxK-0007FI-FY
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 09:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbZI1HrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 03:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZI1HrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 03:47:25 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:62362 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZI1HrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 03:47:24 -0400
Received: by yxe37 with SMTP id 37so4959927yxe.33
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=RuJQ3vrFU92RDbeQZGEgXDw5vtwtJ1WjYXYAh5Di+S4=;
        b=l4XULFZiJ4aeDxWHSkjqe4lIEhbIapV29nx3w3fjaL0abvEggXdxGGDxGF8OqEfXAF
         G8apW5snMxegqU1jK5yLIZDGVNG5dT7EFFD9EyF6XGMLn7MdTB4PNZAhRksHIBHg7wfh
         sDUJUOpISuTsMRw/bBDwgY/tVUb8oF+hz4w0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kWAaUTai+KzTtbTR4b6B5f7s8GEquavcD16ktbeI2avsPCAuP09AlabE8DCh6r3rhU
         KZ8TQBomp8uzXuI6wdITGeFKezDf14jHRRBBaq9L/oE1X/tBJuRnxD3KxgA9FFnTS05d
         pp9nm72SBO8GBpQPWxoUiGdpL8SxakSI2JgqA=
Received: by 10.101.84.11 with SMTP id m11mr2627881anl.70.1254124048364; Mon, 
	28 Sep 2009 00:47:28 -0700 (PDT)
In-Reply-To: <4AC05BA5.4050106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129233>

2009/9/28 Johannes Sixt <j.sixt@viscovery.net>:
> Michael Wookey schrieb:
>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>> Michael Wookey said the following on 22.09.2009 11:17:
>>>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>>>> Michael, how are you trying to compile git? With the IDE or the
>>>>> GNU Make? Which version of MSVC? If you use the IDE, can you make
>>>>> sure it doesn't contain the UNICODE define in the compiler
>>>>> section of the properties of the projects?
>>>> I'm using the VS 2008 Professional IDE (the solution doesn't open
>>>> in VS 2005). I made no changes to the build settings. In the
>>>> Preprocessor section of the project, UNICODE is defined.
>>> Were these projects generated with the Vcproj generator in
>>> contrib/buildsystem, with the Qmake generator, or the projects from Frank's
>>> repo?
>>
>> The project was generated from the vcproj generator in
>> contrib/buildsystem from git.git/master.
>
> What's the status of this?

I was hoping that this gets included into git.git because it fixes a
real issue with MSVC builds. Since Junio is away, perhaps Shawn can
take the patch into his interim tree?

BTW - would you mind giving this patch an ack?

> Do Sebastian Schuberth's patches
> http://article.gmane.org/gmane.comp.version-control.msysgit/7152
> http://article.gmane.org/gmane.comp.version-control.msysgit/7153
>
> make a difference?

Unfortunately, no. Those patches do not make a difference.
