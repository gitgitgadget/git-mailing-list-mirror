From: =?UTF-8?Q?Nico_Schl=C3=B6mer?= <nico.schloemer@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Mon, 16 Feb 2015 16:10:41 +0100
Message-ID: <CAK6Z60dZu_0kNJF2-eJMgnjYVhxfyps53mcfZT41V1DBZZ+zhw@mail.gmail.com>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
 <20150129233429.GA7162@dcvr.yhbt.net> <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
 <20150130002247.GA22519@dcvr.yhbt.net> <CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com>
 <20150130013017.GA10713@dcvr.yhbt.net> <CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com>
 <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com> <20150212191807.GA30062@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Valery Yundin <yuvalery@gmail.com>, git@vger.kernel.org,
	Minty <mintywalker@gmail.com>, Mike <ipso@snappymail.ca>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:11:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNNKK-0000Vi-KW
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 16:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbbBPPLG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 10:11:06 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:44379 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbbBPPLD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2015 10:11:03 -0500
Received: by lams18 with SMTP id s18so29563507lam.11
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f2OHltAdfAvxh7cWW4zDlhQKOvW193jz46OlTLWIvas=;
        b=ZDv4n5garmFFm9Z0PUMAkw0XG5pC9tzogoTVXK6l1Idoobq4ToTpIuRqaUQDgYZHtq
         HyfdgyjUCouV/z1AomIS7Dx3Kpxpn4DvGe2z1P5KHw3GpaxQObh6XA5O1+jgjAK+ZWOt
         RieIb3rJAiC41/AV16jscCVxzBGOLJIbyPqeVCWqRGsrZ1yNdE9g7Vnt87va0g8I4XdV
         TqM18oc/5rs/Avu4UWmyldIV4TCxgdlfoXcv9ie4W93u80bOlY75FbitOzHGRycKTfc3
         mkg7T7INvxIBtHySbGsvIMx/+lyfGPjz8nztBMncu3B87yFmkQSchm1WUVgSzpR+cXHs
         Pu9Q==
X-Received: by 10.152.10.98 with SMTP id h2mr16273310lab.18.1424099461703;
 Mon, 16 Feb 2015 07:11:01 -0800 (PST)
Received: by 10.114.11.73 with HTTP; Mon, 16 Feb 2015 07:10:41 -0800 (PST)
In-Reply-To: <20150212191807.GA30062@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263902>

I just double-checked and I can only produce this issue on one machine
(tested on 3). Apparently, this is has nothing to do with Git itself
then.

Any ideas of what could be wrong?

Cheers,
Nico

On Thu, Feb 12, 2015 at 8:18 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Valery Yundin <yuvalery@gmail.com> wrote:
>> On 31 January 2015 at 13:51, Nico Schl=C3=B6mer <nico.schloemer@gmai=
l.com> wrote:
>> > I tried the patch and I still get
>> > ```
>> > [...]
>> > r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/gi=
t-svn)
>> > Unexpected result returned from git cat-file at
>> > /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 335.
>> > Failed to read object 619f9d1d857fb287d06a70c9dac6b8b534d0de6a at
>> > /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 336, <GEN1=
6>
>> > line 757.
>> >
>> > error closing pipe: Bad file descriptor at
>> > /home/nschloe/libexec/git-core/git-svn line 0.
>> > error closing pipe: Bad file descriptor at
>> > /home/nschloe/libexec/git-core/git-svn line 0.
>> > ```
>> > when
>> > ```
>> > git svn clone https://geuz.org/svn/gmsh/trunk
>>
>> It seems that the same commit dfa72fdb96 is responsible for the erro=
r
>> in "git svn clone https://geuz.org/svn/gmsh/trunk". But unlike in my
>> case, the patch doesn't fix it.
>
> (top-posting corrected)
>
> Odd, I managed to clone that without issues, but I couldn't reproduce
> this problem with or without the tempfile clearing patch applied.
>
>    git svn clone --username gmsh https://geuz.org/svn/gmsh/trunk
>
> Anybody else?
