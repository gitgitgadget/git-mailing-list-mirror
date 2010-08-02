From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 00/11] Splitting gitweb
Date: Mon, 2 Aug 2010 17:03:59 +0200
Message-ID: <201008021704.00753.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <AANLkTi=L4xieJ_HuoX7aGVVVjujdY6bE78iq4v2=nxgx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 17:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfwYr-0002w2-4v
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 17:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0HBPEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 11:04:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42176 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0HBPEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 11:04:08 -0400
Received: by bwz1 with SMTP id 1so1499914bwz.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=GKdsx/SYAg2KmwSUTlY55sNFD71O9v0fkmKouMhKRuU=;
        b=r2qmbAi3/ajccRLH4l/qsMVkXLa7qbN15cQOQGKyRvXgKiQQoc/yWL+JpKtOj93Qu3
         QkE2XI9+hDap1uOd1Qo55Xgc4C5clLY0Eg0no10vdo656qCYzU+XYD9GyFb8b+E+Fz2g
         1r7LB3YHM4tyKZ7DtiiOyOHy9brsig0orCzf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=dFU5uFRSmONJNOZeYhas8h2A+MZKU/XJq4iZwjLVLHymMPJb63QYfKs6ssKulRIWaK
         2Al6tpRtH/dqz+nWfpd5arsOa1VFPH9kghBXPmTkq+AMtQatSo99MDW8NT/rD3CYEKao
         cgFUPG8PpgX+uknTRpr/XPZWFujpDKrbta//0=
Received: by 10.204.141.16 with SMTP id k16mr4217935bku.177.1280761445534;
        Mon, 02 Aug 2010 08:04:05 -0700 (PDT)
Received: from [192.168.1.13] (aeho67.neoplus.adsl.tpnet.pl [79.186.196.67])
        by mx.google.com with ESMTPS id y2sm4181550bkx.8.2010.08.02.08.04.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 08:04:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=L4xieJ_HuoX7aGVVVjujdY6bE78iq4v2=nxgx@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152413>

On Sun, Aug 1, 2010, Sverre Rabbelier wrote:
> On Thu, Jul 15, 2010 at 02:29, Pavan Kumar Sunkara <pavan.sss1991@gma=
il.com> wrote:

> > 10 patches out of the 11 patches in this patch series split gitweb =
into
> > several small sized modules
>=20
> What is the status of this series? Is anyone going to carry it
> forward? I remember multiple people wishing for gitweb to be more
> modular to make it easier to hack on? What shape is the series in, is
> it almost done, or will it need a lot more work?

It is almost done.  The only major thing seems to be the "Prepare for
splitting gitweb" patch, which should be I think replaced by updated
version that uses shell loop in place of make's $(foreach ...) function
to avoid possibility with generating a command line that exceeded the
maximum argument list length.  Might be unnecessary.

Most if not all comments that I have to this version of series was
about commit messages, not the content of the patch itself.

If Pavan would not do re-roll of this series in a few days time, I will
pick it up myself, and resubmit.

> Pavan Kumar Sunkara (11):
> =C2=A0 gitweb: fix esc_url

Comitted: 109988f (gitweb: fix esc_url, 2010-07-15)

> =C2=A0 gitweb: Prepare for splitting gitweb

To be replaced by new version of my "gitweb: Prepare for splitting
gitweb" patch:

  "[PATCHv3/RFC] gitweb: Prepare for splitting gitweb"
  Message-ID: <201007080920.38724.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/150463/focus=3D=
150544

Also it would need explanation that moving from

  install SOURCE DEST

to

  install SOURCE DIRECTORY

was done for security reason (I think), and because we cannot use
portably  `-T' / `--no-target-directory' option to install, as
1.) it is GNU-ism, 2.) it is not present in older GNU install.

> =C2=A0 gitweb: Create Gitweb::Git module

There was an issue about where to put descriptions of build-time
variables: in gitweb.perl or in individual modules.  I think the
issue was addressed somewhat in later commit, but I think it should
be addressed here too.

> =C2=A0 gitweb: Create Gitweb::Config module

Here it would be nice to have description which related subroutines wer=
e
not included, and why.

> =C2=A0 gitweb: Create Gitweb::Request module

It is quite strange for me that evaluate_query_params is in this module=
,
but evaluate_path_info is not.

Also this module needs to be updated to newer codebase (lacks reset_tim=
er
subroutine).

> =C2=A0 gitweb: Create Gitweb::Escape module

ACK-ed.

> =C2=A0 gitweb: Create Gitweb::RepoConfig module

I'd like to have here better description of the intent behind this modu=
le,
i.e. what kinds of subroutines it is to contain.

Here, and in later commits, the modules it depends on are named like
Git.pm instead of Gitweb::Git in the commit message.  This is a minor
issue.

> =C2=A0 gitweb: Create Gitweb::View module

If it contains subroutines related only to HTML output, why isn't it
called Gitweb::HTML then?  If it contains some subroutines which are
not strictly about HTML, it should be stated so in the commit message.

Also in the commit messages dividing moved subroutines into groups
should be done better.

> =C2=A0 gitweb: Create Gitweb::Util module

Just a question: shouldn't git_get_last_activity subroutine be in
Gitweb::RepoConfig module?  Or is Gitweb::RepoConfig only about "static=
"
properties of a repository?

This is result of not well enough described goal of Gitweb::RepoConfig
module, see above.

> =C2=A0 gitweb: Create Gitweb::Format module

Straighforward moving of format_* subroutines and avatar formatting.
The only thing that could be improved is describing why avatar related
subroutines were put there.

> =C2=A0 gitweb: Create Gitweb::Parse module

The commit message might be improved by stating that it is output of
git commands that gets parsed.  There is also odd duck of=20
parsed_difftree_line subroutine.

--=20
Jakub Narebski
Poland
