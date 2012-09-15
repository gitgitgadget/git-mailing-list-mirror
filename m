From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Please pull git-l10n updates for git v1.7.12-146-g16d26
Date: Sat, 15 Sep 2012 11:31:00 +0700
Message-ID: <CACsJy8B8EtMWnJdPqNQ6J-NA+qpv2HXjo-rC5YkFQ9-GqkV1Mg@mail.gmail.com>
References: <CANYiYbExJRAK0zvO4FSce2tOTyW1fLW1OLqZSm0KLjG1V4nTbg@mail.gmail.com>
 <CACsJy8A-prPd=5R83LhcLO1rd-rBZRhfnvABvzvdDiC=hZ3ofQ@mail.gmail.com> <CANYiYbGJP3rpd+t-gVSc0EpbHg9e_8_z24S6v0g2bT72+faj2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 06:32:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCk37-0001t9-Me
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 06:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926Ab2IOEbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 00:31:32 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63831 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2IOEbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 00:31:31 -0400
Received: by ieje11 with SMTP id e11so7328634iej.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 21:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A/t9Uaee7p0DrC7y/w2iJkV52HJrnvjNlEln4hYOvGo=;
        b=Xi+T+TytmXtwyiPxtn7YMyyVxvqykuD/aUpSyWtuvAkbJK1Tm4iZW+pLJr2+Z95DhB
         Qq7A1qx50XRxHwA6OiC3cnAl3muXAjq6SImrUo7Zlar8KCNaK5ncK6FstLcBLaNkzcvu
         sSoDKEoUVqjz7dpxungJs9vmXoJ91jgcfScpqCTKDcKKygUPWi1r9/yWLipULzGO+miA
         DGjixSNSOdE2GHR5R3yrTfzn1pVth5nHtaoufT8oTKMUTfRfDxdDnRHif27zL/0k3Q8l
         6detNXBSa7cpdA4CIFU08O4X21wQXKqKuAyceqo7cAzJoMTv4jlH5JD8fi9qlIaiiFjI
         s+Nw==
Received: by 10.50.85.134 with SMTP id h6mr457132igz.2.1347683490349; Fri, 14
 Sep 2012 21:31:30 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Fri, 14 Sep 2012 21:31:00 -0700 (PDT)
In-Reply-To: <CANYiYbGJP3rpd+t-gVSc0EpbHg9e_8_z24S6v0g2bT72+faj2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205546>

On Sat, Sep 15, 2012 at 8:34 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
> 2012/9/14 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> (Dropping translators as they probably are not interested in this)
>>
>> I saw a gnu project does this (I don't remember what project). If we
>> update .po* files with --no-location, we can avoid a lot of diff
>> noises due to line number changes. A typical translator does not care
>> about these lines anyway. Those who do can easily search the string in
>> source files without them.
>
> I believe some translators need these location infomation to find the
> context.

Unless you are also a git developer, I doubt if sha1_file.c makes
sense to any translators. In my 8 years of being translator/programmer
to open source world, I rarely look at those lines (though I admit I
do). A slightly modified suggestion is just drop line number, not the
file name, but xgettext does not support that, unfortunately.
-- 
Duy
