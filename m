From: =?UTF-8?B?6YOR5paH6L6JKFRlY2hsaXZlIFpoZW5nKQ==?= 
	<techlivezheng@gmail.com>
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Mon, 7 Jan 2013 23:00:00 +0800
Message-ID: <CAPYzjrRzXqgYRQZ429iVv-HPA_gatoE+H0ofyebYAEBmYoQ71w@mail.gmail.com>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-2-git-send-email-greened@obbligato.org> <7vtxr1bg4g.fsf@alter.siamese.dyndns.org>
 <CAPYzjrTqmzuWoDg+zvLxwB7g6J4J2wbBqpL+UbHKRHcbjA4HrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: greened@obbligato.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 16:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsECF-0004JW-AT
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 16:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab3AGPAn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 10:00:43 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:39103 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3AGPAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 10:00:42 -0500
Received: by mail-vc0-f171.google.com with SMTP id n11so19417810vch.2
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 07:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U4AC7O4RA+Z2t7NqhzRCxepCVQ67Yt6p5q08VwnHeAY=;
        b=y1ou3Dl03Ba1jTZx3CZVuxJv/10jbfbOAdaoe/mD1Vm+fPDPC4BQSckjxTFyJtvl54
         XuDOVrFgYmwNEzkRE/SDPqCbonEMugmEsYqlf4GjOEym3ZqzbaUMvhqeMDamp/xlAD//
         xPiYrsEI0ZE30iJcLftiW+xa3Jx3jxB/c/NONTfrnJs7JRKSZDhYdvNhVQTjX9fkYy7x
         J9dEqu92DRXUy6qO0z0kKWY4kRpQ5F003zNdi8K5chkTjW0NvLrHKM0+q/48aO5CsnEs
         ilUebbIAzBH/rF0KSti2pcl/IZGYHe2VLtQaO1CLdAFZ2tqNrhQeeaZ2TM4NTn8Cdetg
         XAHQ==
Received: by 10.52.16.17 with SMTP id b17mr72326297vdd.86.1357570841063; Mon,
 07 Jan 2013 07:00:41 -0800 (PST)
Received: by 10.58.106.48 with HTTP; Mon, 7 Jan 2013 07:00:00 -0800 (PST)
In-Reply-To: <CAPYzjrTqmzuWoDg+zvLxwB7g6J4J2wbBqpL+UbHKRHcbjA4HrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212895>

 2013/1/1 Junio C Hamano <gitster@pobox.com>:
> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: Techlive Zheng <techlivezheng@gmail.com>
>>
>> Use %B to format the commit message and body to avoid an extra newli=
ne
>> if a commit only has a subject line.
>
> Is this an unconditional improvement, or is it generally an
> improvement but for some users it may be a regression?  I am
> guessing it is the former but am just making sure.
>
>> Author:    Techlive Zheng <techlivezheng@gmail.com>
>>
>> Signed-off-by: David A. Greene <greened@obbligato.org>
>
> Please don't do "Author: " which does not add anything new.  That is
> what "From: " is for.  Instead it needs to be a sign-off.
>
> Also, is that a real name, I have to wonder?
>
Hmm, sorry about the confusing.

I am a Chinese, I coined that first name a couple years ago when I
decided to have a unique name across the web. My real name is "=E9=83=91=
=E6=96=87=E8=BE=89" in
Chinese=EF=BC=8Ctranslate to English by its pronucation is "Wenhui
Zheng"=EF=BC=8Cwhich means "Zheng" is acturally my real last name. The =
first
name "Wenhui" does not have any meaning in English, so I coined it by
"Tech" + "Live", which I interprate it as "Technological Living",
thus, "Techlive Zheng" is the name I am currently using online.

Here are some links:

* Let the code talks. https://github.com/techlivezheng
* I cross the great GFW to use twitter. https://twitter.com/techlivezhe=
ng
* Also search "Techlive Zheng" in Google, the result should be unique t=
o me.

So, no doubt, I am a real person, just with kind of an uncommon name.

>> Thanks.
