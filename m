From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv3] transport: Catch non positive --depth option value
Date: Tue, 26 Nov 2013 10:06:47 +0700
Message-ID: <CACsJy8BV74W63Sak-j_9RMjp_5Bo8HMd3Xc93GTtSn4yWStfEA@mail.gmail.com>
References: <5283A380.9030308@gmail.com> <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
 <528A9877.4060802@gmail.com> <xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
 <528E2660.6020107@gmail.com> <xmqq1u294ih3.fsf@gitster.dls.corp.google.com>
 <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com> <5293DE93.3020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 04:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl8zk-0001Ga-Sc
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 04:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab3KZDHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 22:07:20 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:57919 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3KZDHS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 22:07:18 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so3914203qab.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 19:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZNrqOe34flvImImpcM+rjS+xEeDZ5sCMTeHZDFMCv0c=;
        b=OthNan9TVmNCNos4ZWAmKsP5LmVFAaKqQ6QHgGRbdbkzHW9Cq5IVX3vs7QPxdkdqCq
         JSngSoCTIjmnd+6Fh9YBMGoDZwoIbUIq34NAh7+oW+u/OZulzxqyxVBcOo0eH0Z9DZ/I
         MYfzR2DVmF0Bz2Uedv9n83B4pHWUGm4H7rGwuL8ZCiy30PZ9QvazZAK4uYkzj7CcZgFc
         weKHQ8XHa8Cc/WiRkgAst7fuLuSqN4IM8Ry134ctBOQ+SKZ/QafK3eUu+1dB+RidmuIV
         1KeVEThkYLmHTsYji64GyMS+PX4BsJmxSFjGwlS0Jn+Xesy31LnrePlTN+dqHuL3QGgN
         DXfw==
X-Received: by 10.224.171.196 with SMTP id i4mr52460725qaz.38.1385435238453;
 Mon, 25 Nov 2013 19:07:18 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Mon, 25 Nov 2013 19:06:47 -0800 (PST)
In-Reply-To: <5293DE93.3020008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238368>

On Tue, Nov 26, 2013 at 6:34 AM, "Andr=C3=A9s G. Aragoneses"
<knocte@gmail.com> wrote:
> On 22/11/13 02:18, Duy Nguyen wrote:
>> On Fri, Nov 22, 2013 at 3:18 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Have you run the tests with this patch?  It seems that it breaks
>>> quite a lot of them, including t5500, t5503, t5510, among others.
>>
>> I guess it's caused by builtin/fetch.c:backfill_tags(). And the call
>> could be replaced with
>>
>> transport_set_option(transport, TRANS_OPT_DEPTH, NULL);
>>
>
> Not sure what you mean,
> https://github.com/git/git/blob/master/t/t5550-http-fetch.sh doesn't
> call backfill_tags. What do you mean?

I wrote "I guess" ;-) I did not check what t5550 does.

>
> Thanks
>



--=20
Duy
