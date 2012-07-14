From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Sat, 14 Jul 2012 14:03:52 +0200
Message-ID: <CAJzBP5S5mR+D99R6y=CDwf1YArsnuVuDQhw4Lrm72knhnEhZtg@mail.gmail.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
	<loom.20120714T114314-421@post.gmane.org>
	<CALUzUxoi-X2nTTFF7utJz2DOTDE8-s7QOgR=HmQAkOVkGY17BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 14:04:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq14p-0004PM-61
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 14:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab2GNMDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jul 2012 08:03:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48434 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab2GNMDx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2012 08:03:53 -0400
Received: by yhmm54 with SMTP id m54so4557379yhm.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ufPdC+cvFlGi5s/bWF0NRhZ9Clpdj5gMJtBT4TAJLj8=;
        b=Fpu4Gfu1CKyDyee+asTrgFVObcscSYEHmUD51FdoeoH64tOrPsQjHH7WkwLHRpSIiO
         RQwP9lccRkDHDCc9EFmYCBm0HlfGUthMrZ51MZZp4FtkPDqq/B+w7GYhg15mLVEI7+d+
         1VWsrNflid6kIGXMh/0gfEeehS0LyWT3mKtX51EkV1a9WOCefFsBR/IXQMftQOSZ1xzx
         uhXpauIoYHn0t2tA/PmzFaPT6bmemPQZtxBiuh/1VnYUOEg4hVgxhWOuzPXqxWGjFAD1
         M1DfzUzz648+fUQJqI+B36frmNUdHva05KsLeyAgJ/YXafP3tqncp4uDQ7KMeSFXAKi7
         uFYw==
Received: by 10.236.200.167 with SMTP id z27mr4205792yhn.131.1342267432538;
 Sat, 14 Jul 2012 05:03:52 -0700 (PDT)
Received: by 10.101.213.21 with HTTP; Sat, 14 Jul 2012 05:03:52 -0700 (PDT)
In-Reply-To: <CALUzUxoi-X2nTTFF7utJz2DOTDE8-s7QOgR=HmQAkOVkGY17BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201438>

On Sat, Jul 14, 2012 at 12:37 PM, Tay Ray Chuan <rctay89@gmail.com> wro=
te:
> Hi Stefan,
>
> On Sat, Jul 14, 2012 at 5:46 PM, Stefan N=C3=A4we <stefan.naewe@gmail=
=2Ecom> wrote:
>>
>> Do you have a fork of git.git somewhere that contains the script?
>> (I find it so much easier these days to simply fetch another repo in=
stead
>> of applying patches with 'git am'.)
>
>
> you can try "Show Original" in gmail's interface and saving the text =
file,
> then running git am directly on it. Old gits used to have problems wi=
th the
> leading newline, but I don't see this problem nowadays.

If I only would be subscribed to gitlist with my gmail account...

Anyways, there's a nice script in msysgit.git [1] that makes applying p=
atches
from gmane pretty easy. Thanks Dscho!


Stefan

[1] https://github.com/msysgit/msysgit/blob/devel/bin/apply-from-gmane.=
sh
--=20
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode(=
'hex')"
