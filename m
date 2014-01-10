From: Dan Kaplan <dank@mirthcorp.com>
Subject: Re: A question about the error: svn_fspath__is_canonical
Date: Fri, 10 Jan 2014 12:36:18 -0800
Message-ID: <CABRpx=1eGFMGMx--a6hErbO1Hdk_HKvFRF_v33d7nc3yJob2Dg@mail.gmail.com>
References: <CABRpx=1CvB55zeL1L8QOvyfbJCaG9FK+HEz-iK9cFGrnxmOJtg@mail.gmail.com>
	<20140110191650.GF4776@google.com>
	<CABRpx=3vf-bwtA8_2ndPYo+fWCNiHQdSbLRGFWts4Wp3uN6yDA@mail.gmail.com>
	<20140110192825.GG4776@google.com>
	<52D04B38.6060203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 10 21:36:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1ioa-0007yZ-Su
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 21:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115AbaAJUgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jan 2014 15:36:20 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:45614 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbaAJUgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jan 2014 15:36:19 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so3195654qab.37
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirthcorp.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eQicX6wUYmh6s3IAVB4ZLHkJOJyLNSwaWdEc4jNHiQU=;
        b=GuOXvI6an9M1SyFphFd2Vsoat23zUesdysUo5zB2NDd2uGNHZcgq8sMlOCqD9i8Xoo
         QSRY/iysiHfgo88crBADN8y70uFzW838GiDg5JhIf7b6t8hAE/ZeYq3qVjkvsuTCYnKP
         xL/o7Yt7k7XbcZghPjEQFx5ehJb1pVhN5rsRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eQicX6wUYmh6s3IAVB4ZLHkJOJyLNSwaWdEc4jNHiQU=;
        b=SAE9LnqiE0t4Md1wXI2bbiI54lInqq2AyetUgVc/kn6p3b8WGkiIN5opVUtg2vvzOO
         7Edmh4+v7xD99VmJn9grmBH6sQSSY9VcOKDLdQoz2yPsjV9EICz1TAgQ7TyU5VWo9Ptg
         Cw1NYLB5vMYejwn9sqqvmr99FvAKRNZdIcj+Vj8eMl9tpLJFkK7p8T+5qyzbpq4o4BZ9
         TDePNg1EKs41ZUr2PDL4SRR88yEJ4Situb7j5RcMNGq9kQOfXSIaKPBqhIuw4Z8LYOy2
         VmDaO/uEYAJMECZEd0W8OJWH3ddWq6wErr7Yw4WeqNqc5Q0XsaXwz/nKbsWhjOxjXDHJ
         TgAg==
X-Gm-Message-State: ALoCoQkeeOdboGqEhZqIyDAcnD8Ysuqvhd/aK/OOqk6WLFYfT5uP47nrBddbSa2xWlz0qir5bDqfq5bLN2CUdOMda45jeFSV7BNEZR02oBhDQOR80YROBVg=
X-Received: by 10.49.104.210 with SMTP id gg18mr11377284qeb.54.1389386178176;
 Fri, 10 Jan 2014 12:36:18 -0800 (PST)
Received: by 10.96.76.5 with HTTP; Fri, 10 Jan 2014 12:36:18 -0800 (PST)
In-Reply-To: <52D04B38.6060203@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240317>

I had to convert every file from windows line endings to unix line
endings with dos2unix (dos2unix was a separate install).  I did that
with this command: find . -type f | xargs dos2unix

I also had to install: libiconv, gettext, expat, gettext-devel, expat-d=
evel

That got my make -j8 to run without error.

I then ran make test and it looked like most of the passed.  I added
it to my path and now my bug is fixed!  Thanks for the help guys.


On Fri, Jan 10, 2014 at 11:34 AM, Torsten B=F6gershausen <tboegi@web.de=
> wrote:
> On 2014-01-10 20.28, Jonathan Nieder wrote:
>> Dan Kaplan wrote:
>>
>>>                              Do you think it'll still work?
>>
>> Yes, that's why I suggested it. ;-)
>>
>> You might need to install the gcc-core, libcurl-devel, openssl-devel=
,
>> and subversion-perl packages first.
>>
>> Regards,
>> Jonathan
> Out of my head:
> You probably need to install even:
> make, expat-devel (or similar)
>



--=20
Thanks,
Dan

--=20
CONFIDENTIALITY NOTICE: The information contained in this electronic=20
transmission may be confidential. If you are not an intended recipient,=
 be=20
aware that any disclosure, copying, distribution or use of the informat=
ion=20
contained in this transmission is prohibited and may be unlawful. If yo=
u=20
have received this transmission in error, please notify us by email rep=
ly=20
and then erase it from your computer system.
