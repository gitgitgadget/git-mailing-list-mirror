From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Wed, 25 Feb 2015 12:33:59 -0800
Message-ID: <8FAF534A-812E-4FBD-AEE4-907C83CEC007@gmail.com>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com> <20150129233429.GA7162@dcvr.yhbt.net> <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com> <20150130002247.GA22519@dcvr.yhbt.net> <CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com> <20150130013017.GA10713@dcvr.yhbt.net> <CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com> <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com> <20150212191807.GA30062@dcvr.yhbt.net> <CAK6Z60dZu_0kNJF2-eJMgnjYVhxfyps53mcfZT41V1DBZZ+zhw@mail.gmail.com> <20150217061707.GA4308@dcvr.yhbt.net> <801181a93d829d68b96c4b61d1ebdc3@74d39fa044aa309eaea14b9f57fe79c> <CAK6Z60fqEkM_tON6tcnwBqJzBCvLB=eVJdyXSnNb7N1iR_DSsw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Nico_Schl=F6mer?= <nico.schloemer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 21:34:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQieo-0002EA-HB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 21:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbbBYUeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2015 15:34:06 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32945 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbBYUeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2015 15:34:04 -0500
Received: by pabkx10 with SMTP id kx10so8013222pab.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 12:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=mJ9fpHDHYhEcJD0vXXE8w1HV39+Y2jCHZrdiePsdh9U=;
        b=RcUEJtU2UOnFwjQayWTC/Re04FEyQtHVXRqyeFSNZ/Tsyn3G9PNnSHwzmli+lGl8gt
         JdgvOz5qjITvkzNNouQPRC4HINlWgxNgqQioagh571qD8yxlAx/WOSLaAFkLEDQmlzLZ
         1ZWYgdUBGd5XQTrSEbutAnkzS9QWaaqyAxkmXXhAX+b7ZkJrMYF//K+BknO8+nBEA+dY
         uazSAe3tlN+a5jK+W2DNYeGWOtadAY7G00UMP1XnnZJpBL9aYQ/WjOQ6/ufh2Iqfpn36
         MYvjG5qvNk0JL0QBbBD1OlQ3aQMmgmKtS8/QaxbrDpobEEuMzYXfsILKksKh+Sh4oD9p
         f8Mg==
X-Received: by 10.70.4.226 with SMTP id n2mr8649801pdn.11.1424896443185;
        Wed, 25 Feb 2015 12:34:03 -0800 (PST)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id ce1sm43018333pdb.34.2015.02.25.12.34.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 12:34:02 -0800 (PST)
In-Reply-To: <CAK6Z60fqEkM_tON6tcnwBqJzBCvLB=eVJdyXSnNb7N1iR_DSsw@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264413>

On Feb 25, 2015, at 07:07, Nico Schl=F6mer wrote:

> Thanks Kyle for the patch! I applied it and ran
> ```
> git svn clone https://geuz.org/svn/gmsh/trunk
> ```
> Unfortunately, I'm still getting
> ```
> [...]
> r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/git-s=
vn)
> error closing pipe: Bad file descriptor at /usr/share/perl5/Git/SVN/=20
> Fetcher.pm line 335.
> error closing pipe: Bad file descriptor at /usr/share/perl5/Git/SVN/=20
> Fetcher.pm line 335.
> out pipe went bad at /usr/share/perl5/Git.pm line 955.
> ```

Are you certain you're running with the patch?  I ask because earlier =20
you sent this:

On Jan 31, 2015, at 04:51, Nico Schl=F6mer wrote:

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

And as the patch below applies to Fetcher.pm at line 322 and inserts 8 =
=20
lines, I do not see how you could be getting the same error message at =
=20
line 335 if the patch was present.  Even if you manually applied it by =
=20
only inserting the two lines of code, the line numbers would be at =20
least 337, not 335 as reported above.  I also notice the path to =20
=46etcher.pm is different from your earlier report.

That said, the fact that it happens right after r100 (which is when =20
SVN::Pool::clear is getting called) suggests there's another file =20
handle getting caught up in the SVN::Pool somehow.  (When I try to =20
clone gmsh, I got to r4885 before a server disconnection.)

It could be as simple as the open2 call FileHandle result in later =20
perl versions ends up in the SVN::Pool whereas in earlier Perl and/or =20
svn versions it does not.

What happens if you add this change on top of the Fetcher.pm change:

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 622535e2..96888228 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -391,6 +391,7 @@ sub longest_common_path {
  sub gs_fetch_loop_common {
  	my ($self, $base, $head, $gsv, $globs) =3D @_;
  	return if ($base > $head);
+	$::_repository->_open_cat_blob_if_needed;
  	my $gpool =3D SVN::Pool->new_default;
  	my $ra_url =3D $self->url;
  	my $reload_ra =3D sub {

-Kyle

> Cheers,
> Nico
>
> On Wed, Feb 25, 2015 at 11:20 AM Kyle J. McKay <mackyle@gmail.com> =20
> wrote:
> I believe I have been able to track down this problem and implement a
> fix.  Please report back if this patch fixes the problem for you.
>
> -Kyle
>
> -- 8< --
> Subject: [PATCH] Git::SVN::Fetcher: avoid premature 'svn_hash' temp =20
> file closure
>
> Since b19138b (git-svn: Make it incrementally faster by minimizing =20
> temp
> files, v1.6.0), git-svn has been using the Git.pm temp_acquire and
> temp_release mechanism to avoid unnecessary temp file churn and =20
> provide
> a speed boost.
>
> However, that change introduced a call to temp_acquire inside the
> Git::SVN::Fetcher::close_file function for an 'svn_hash' temp file.
> Because an SVN::Pool is active at the time this function is called, i=
f
> the Git::temp_acquire function ends up actually creating a new
> FileHandle for the temp file (which it will the first time it's calle=
d
> with the name 'svn_hash') that FileHandle will end up in the SVN::Poo=
l
> and should that pool have SVN::Pool::clear called on it that =20
> FileHandle
> will be closed out from under Git::temp_acquire.
>
> Since the only call site to Git::temp_acquire with the name 'svn_hash=
'
> is inside the close_file function, if an 'svn_hash' temp file is ever
> created its FileHandle is guaranteed to be created in the active
> SVN::Pool.
>
> This has not been a problem in the past because the SVN::Pool was not
> being cleared.  However, since dfa72fdb (git-svn: reload RA every
> log-window-size, v2.2.0) the pool has been getting cleared =20
> periodically
> at which point the FileHandle for the 'svn_hash' temp file gets =20
> closed.
> Any subsequent calls to Git::temp_acquire for 'svn_hash', however,
> succeed without creating/opening a new temporary file since it still =
=20
> has
> the now invalid FileHandle in its cache.  Callers that then attempt t=
o
> use that FileHandle fail with an error.
>
> We avoid this problem by making sure the 'svn_hash' temp file is =20
> created
> in the same place the 'svn_delta_...' and 'git_blob_...' temp files =20
> are
> (and then temp_release'd) so that it can be safely used inside the
> close_file function without having its FileHandle end up in an =20
> SVN::Pool
> that gets cleared.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  perl/Git/SVN/Fetcher.pm | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
> index 10edb277..613055a3 100644
> --- a/perl/Git/SVN/Fetcher.pm
> +++ b/perl/Git/SVN/Fetcher.pm
> @@ -322,6 +322,14 @@ sub apply_textdelta {
>         # (but $base does not,) so dup() it for reading in close_file
>         open my $dup, '<&', $fh or croak $!;
>         my $base =3D $::_repository->temp_acquire("git_blob_${$}_=20
> $suffix");
> +       # close_file may call temp_acquire on 'svn_hash', but =20
> because of the
> +       # call chain, if the temp_acquire call from close_file ends =20
> up being the
> +       # call that first creates the 'svn_hash' temp file, then the =
=20
> FileHandle
> +       # that's created as a result will end up in an SVN::Pool =20
> that we clear
> +       # in SVN::Ra::gs_fetch_loop_common.  Avoid that by making =20
> sure the
> +       # 'svn_hash' FileHandle is already created before close_file =
=20
> is called.
> +       my $tmp_fh =3D $::_repository->temp_acquire('svn_hash');
> +       $::_repository->temp_release($tmp_fh, 1);
>
>         if ($fb->{blob}) {
>                 my ($base_is_link, $size);
> --
