From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 06/11] replace: bypass the type check if -f option is used
Date: Thu, 5 Sep 2013 14:56:30 +0200
Message-ID: <CAP8UFD33DdRjpZnQmPkexpGsKOm7=zouuteMpioGRJ+6LyjVNw@mail.gmail.com>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.76437.chriscool@tuxfamily.org>
	<xmqq4na0mi51.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 14:56:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHZ6y-0004dm-OE
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 14:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab3IEM4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 08:56:32 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:34437 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab3IEM4c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 08:56:32 -0400
Received: by mail-ve0-f174.google.com with SMTP id jy13so463929veb.33
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fp8HsRETwl9kLG2CdDri7x8EDDD5vVY5lxsOmxuhtvU=;
        b=hsElsOVs/sxQ30J5WdswfZSV/qW/kNcjGar/OYziXWUK8OBoXOv14t7WdFSlk45KJ8
         xVRXfg1AFYF1BsJBRN1W323oyz102JUrMz5RRJ6hd5T62FwBWpjddPSP/ssFPi8CN0cm
         Oh9qX3U52SMHwpLeJu0iVRX6koaY5wmdgdEV4FJjZDhuRZLfHgt8X4stpHKyPLgjmQd0
         seswXfugmIFPqV3OXZL6XtwXaf++QycG8vj0pHPcvX1DPrbRf5JIN7T9R73GQbCJviUP
         No9vWE/Mz6LwdNbeFsNhvIT6nj0bF9SiJ0wyeJT3CCSxamXsF8OscTCfcXporVpRyEBb
         LfIQ==
X-Received: by 10.52.230.74 with SMTP id sw10mr5949508vdc.6.1378385790979;
 Thu, 05 Sep 2013 05:56:30 -0700 (PDT)
Received: by 10.58.240.102 with HTTP; Thu, 5 Sep 2013 05:56:30 -0700 (PDT)
In-Reply-To: <xmqq4na0mi51.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233956>

On Wed, Sep 4, 2013 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> If -f option, which means '--force', is used, we can allow an object
>> to be replaced with one of a different type, as the user should know
>> what (s)he is doing.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>
> This does not matter in a larger picture, but between 1/11 and this
> patch, there is a window where an operation that has been useful in
> some workflows becomes unavailable to the user.
>
> For future reference, it would be better to do this as a part of
> 1/11, to make sure that there always is an escape hatch available to
> the users.

Ok, I will squash patchs 6/11, 7/11 and 8/11 with 1/11, 2/11 and 3/11
respectively.

Thanks,
Christian.
