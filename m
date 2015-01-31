From: Valery Yundin <yuvalery@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Sat, 31 Jan 2015 15:52:11 +0100
Message-ID: <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
	<20150129233429.GA7162@dcvr.yhbt.net>
	<CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
	<20150130002247.GA22519@dcvr.yhbt.net>
	<CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com>
	<20150130013017.GA10713@dcvr.yhbt.net>
	<CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Minty <mintywalker@gmail.com>, Mike <ipso@snappymail.ca>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Nico_Schl=C3=B6mer?= <nico.schloemer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:52:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHZPI-0002f3-Um
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 15:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbbAaOwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2015 09:52:15 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:59952 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbbAaOwM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jan 2015 09:52:12 -0500
Received: by mail-qc0-f171.google.com with SMTP id s11so24706860qcv.2
        for <git@vger.kernel.org>; Sat, 31 Jan 2015 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=HbjRNc5ctU3eo62nxRex6xOYXGI3mMkVUAD8mMvxaxA=;
        b=AQ/hM2kLQdTdqL3WvGyaEm/cjp5unimfZEfMXM1J9dTx9aa0IlfruDObZLOTQ40iuY
         6VBZNmvA5S5JKoT5TxbdHde9fCH1z7k55yL1dNgrz+OATTMbtBt5oqHKklbCwayiZsBo
         qljzsoBe+0rya1t4xCu57QUbF5RQqWa9gyKauw8MGoHhmzIpjh3o0WPzNcFsh/3FfSB9
         oJQUk17W0xqUJnm5Y2N/6cmYuiShBRVx8HSJLIJHNn0R3b17bVb87AoYG2k6xGRp1ptC
         HgeZwOugLfjPeifQ3hyqTKJPUGMpU29/9B1YF9Dai1cB1IAURvjLLbF8zTeYZCKZURbC
         9EqQ==
X-Received: by 10.224.135.200 with SMTP id o8mr23720308qat.1.1422715931882;
 Sat, 31 Jan 2015 06:52:11 -0800 (PST)
Received: by 10.96.46.170 with HTTP; Sat, 31 Jan 2015 06:52:11 -0800 (PST)
In-Reply-To: <CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com>
X-Google-Sender-Auth: bCz0ONLYbVPv4Ey8Nj9yJ37Q9YE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263207>

Hi,

It seems that the same commit dfa72fdb96 is responsible for the error
in "git svn clone https://geuz.org/svn/gmsh/trunk". But unlike in my
case, the patch doesn't fix it.

Cheers,
Valery


On 31 January 2015 at 13:51, Nico Schl=C3=B6mer <nico.schloemer@gmail.c=
om> wrote:
> I tried the patch and I still get
> ```
> [...]
> r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/git-s=
vn)
> Unexpected result returned from git cat-file at
> /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 335.
> Failed to read object 619f9d1d857fb287d06a70c9dac6b8b534d0de6a at
> /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 336, <GEN16>
> line 757.
>
> error closing pipe: Bad file descriptor at
> /home/nschloe/libexec/git-core/git-svn line 0.
> error closing pipe: Bad file descriptor at
> /home/nschloe/libexec/git-core/git-svn line 0.
> ```
> when
> ```
> git svn clone https://geuz.org/svn/gmsh/trunk
> ```
>
> Cheers,
> Nico
>
> On Fri, Jan 30, 2015 at 2:30 AM, Eric Wong <normalperson@yhbt.net> wr=
ote:
>> Valery Yundin <yuvalery@gmail.com> wrote:
>>> Hi,
>>>
>>> Your patch seems to fix the problem.
>>> I tried several times and I can svn clone the whole repository in o=
ne
>>> go without a crash.
>>
>> Thanks for the confirmation.  Cc-ing a few other folks who encounter=
ed
>> this problem (and Bcc-ing some folks who emailed me privately).
>>
>> Can the rest of you give this patch a try on your respective platfor=
ms
>> and confirm the fix?
>>
>> http://article.gmane.org/gmane.comp.version-control.git/263168/raw
>> (also: http://mid.gmane.org/20150130002247.GA22519@dcvr.yhbt.net )
>>
>> Junio: assuming all goes well with testers, can you apply my patch
>> to the appropriate maintenance tracks with Tested-by:s?
>> I'm going offline in a few hours and don't think I'll be around
>> much the next week or so.
>>
>> Thanks.
>>
>>> Thanks,
>>> Valery
>>>
>>> On 30 January 2015 at 01:22, Eric Wong <normalperson@yhbt.net> wrot=
e:
>>> > Valery Yundin <yuvalery@gmail.com> wrote:
>>> >> Hi,
>>> >>
>>> >> Here you go:
>>> >> dfa72fdb96befbd790f623bb2909a347176753c2 is the first bad commit
>>> >
>>> > Thank you.  Can you give the following patch a try?
>>> > I have not been able to reproduce the problem on my end.
>>> > If it doesn't work out, I might be out of ideas for a bit :/
>>> > Increasing --log-window-size will help you run longer without
>>> > the error, but that's not ideal as it can also eat memory.
>>> >
>>> > -----------------------8<----------------------
>>> > From: Eric Wong <normalperson@yhbt.net>
>>> > Subject: [PATCH] git-svn: destroy all tempfiles when reloading RA
>>> >
>>> > This may fix the errors some users are seeing with:
>>> > "write .git/Git_svn_hash_XXXXXX: Bad file descriptor"
>>> >
>>> > Thanks to Valery Yundin for helping bisect the problem introduced=
 in
>>> > commit dfa72fdb96befbd790f623bb2909a347176753c2
>>> > (git-svn: reload RA every log-window-size)
>>> >
>>> > Cc: Valery Yundin <yuvalery@gmail.com>
>>> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
>>> > ---
>>> >  perl/Git.pm        | 6 ++++++
>>> >  perl/Git/SVN/Ra.pm | 1 +
>>> >  2 files changed, 7 insertions(+)
>>> >
>>> > diff --git a/perl/Git.pm b/perl/Git.pm
>>> > index b5905ee..698018e 100644
>>> > --- a/perl/Git.pm
>>> > +++ b/perl/Git.pm
>>> > @@ -1347,6 +1347,12 @@ sub temp_path {
>>> >         $TEMP_FILES{$temp_fd}{fname};
>>> >  }
>>> >
>>> > +sub temp_reset_all {
>>> > +       unlink values %TEMP_FILEMAP if %TEMP_FILEMAP;
>>> > +       %TEMP_FILEMAP =3D ();
>>> > +       %TEMP_FILES =3D ();
>>> > +}
>>> > +
>>> >  sub END {
>>> >         unlink values %TEMP_FILEMAP if %TEMP_FILEMAP;
>>> >  }
>>> > diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>>> > index 622535e..878679d 100644
>>> > --- a/perl/Git/SVN/Ra.pm
>>> > +++ b/perl/Git/SVN/Ra.pm
>>> > @@ -397,6 +397,7 @@ sub gs_fetch_loop_common {
>>> >                 $_[0] =3D undef;
>>> >                 $self =3D undef;
>>> >                 $RA =3D undef;
>>> > +               Git->temp_reset_all;
>>> >                 $gpool->clear;
>>> >                 $self =3D Git::SVN::Ra->new($ra_url);
>>> >                 $ra_invalid =3D undef;
>>> > --
>>> > EW
>>> --
