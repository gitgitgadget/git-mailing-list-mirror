From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] git-p4: import the ctypes module
Date: Wed, 21 Oct 2015 22:00:36 +0200
Message-ID: <C5786C82-72C3-48C5-A8D0-8DD824F247C9@gmail.com>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com> <CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com> <xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com> <1445369506.8543.10.camel@kaarsemaker.net> <xmqqwpuh72ot.fsf@gitster.mtv.corp.google.com> <5626C79C.8060503@diamand.org> <CAJA=mv7N=PmL69kgZRjq8P6J_qsfUbLx76WguhvqPrG2o1UFww@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git Users <git@vger.kernel.org>
To: Etienne Girard <etienne.g.girard@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:00:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozZ0-0006PW-V7
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbbJUUAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:00:43 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33122 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbbJUUAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 16:00:42 -0400
Received: by wijp11 with SMTP id p11so933694wij.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YqijwAq658kQRUM4sXaOooSGFo+ZYup8CXZ5iKzfVp4=;
        b=Ezq6ib3Pi9Y3tRwBtIm03WAYBCChm8yEnTBoGdroAsUNVrJy7iY5WCt/xmGgJ5apgb
         Ss4JZCmublRMvpkogqSQ1kM1/AAM7zD2sKcfv6eJuJO0be8X9Q8NjkyajMdlRUXK3+n4
         gIuwdzeNj5UP5RC8TdaU6vtFLUqGNF4CkCfkr14SbPQ8n1QXyzzUZPEsxFf+Sl025Aa9
         UxkxSs+ZJnd2timG/+dLfV4EDYrAMKJjacF+ulTDQK1jvSJyOg9y4vwLtLHhTwDOOCcn
         0vN4cvR4rKA59F5e+njxUcX1o9DLkpIVS4imlzyflMbm8gjS2k8i0vH84VtDFr71fOIN
         aZRg==
X-Received: by 10.194.223.72 with SMTP id qs8mr13820806wjc.145.1445457641064;
        Wed, 21 Oct 2015 13:00:41 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5C89.dip0.t-ipconnect.de. [93.219.92.137])
        by smtp.gmail.com with ESMTPSA id qr6sm23400658wic.13.2015.10.21.13.00.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 13:00:40 -0700 (PDT)
In-Reply-To: <CAJA=mv7N=PmL69kgZRjq8P6J_qsfUbLx76WguhvqPrG2o1UFww@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280008>

Hi Etienne,

thanks for reporting this! Junio is right, I messed that up on my Windows testing box! :-( Sorry! 
If you have any questions around submitting patches I am happy to help as I just recently went through the learning process myself!

@Dennis: Thanks for the quick patch!

Thanks,
Lars

On 21 Oct 2015, at 10:23, Etienne Girard <etienne.g.girard@gmail.com> wrote:

> Hello,
> 
> I couldn't work further on this yesterday (but I read
> Documentation/SubmittingPatches, which is a good start I guess). The
> diff proposed by Dennis works on my machine, I'll try to figure out
> why the original script worked with 2.7.10.
> 
> Thanks
> 
> 2015-10-21 1:00 GMT+02:00 Luke Diamand <luke@diamand.org>:
>> On 20/10/15 20:36, Junio C Hamano wrote:
>>> 
>>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>> 
>>>>> I do not follow Python development, but does the above mean that
>>>>> with recent 2.x you can say ctypes without first saying "import
>>>>> ctypes"?  It feels somewhat non-pythonesque that identifiers like
>>>>> this is given to you without you asking with an explicit 'import',
>>>>> so I am puzzled.
>>>> 
>>>> 
>>>> No, you cannot do that. The reason others may not have noticed this bug
>>>> is that
>>>> in git-p4.py, ctypes is only used on windows.
>>>> 
>>>>  111     if platform.system() == 'Windows':
>>>>  112         free_bytes = ctypes.c_ulonglong(0)
>>>>  113
>>>> ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(os.getcwd()),
>>>> None, None, ctypes.pointer(free_bytes))
>>>> 
>>>> The fact that it works for the OP with 2.7.10 is puzzling (assuming that
>>>> it's
>>>> on the same system).
>>> 
>>> 
>>> Exactly.  That is where my "I am puzzled" comes from.
>>> 
>>> The patch looks obviously the right thing to do.  Luke?  Lars?
>> 
>> 
>> It looks sensible to me, and works fine on Linux, thanks. ack.
>> 
>> I can't test on Windows today but I can't see why it wouldn't work.
>> 
>> Luke
>> 
>> 
