From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH RFC GSoC] gitweb: Use -M option while using format-patch
Date: Mon, 10 May 2010 18:56:58 +0200
Message-ID: <AANLkTikR7zxbhcAjg2WXv9V-eFOkPMf77uCpmo8csr7n@mail.gmail.com>
References: <4BE82F8D.8060205@gmail.com> <201005101841.40011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 18:57:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWIK-0005HI-4M
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 18:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab0EJQ5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 12:57:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:4110 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0EJQ5V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 12:57:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so852273fgg.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FQpSDnKRRZdWXmUqDMeBv7JkiCV1QX5jEE2JWPLJEHk=;
        b=wQqB1r31ABlzse0jWgCvAe7ql/Zui7nFxQSs5BkxQnXpxu+4vgq+fH3o6MlpfNptsS
         EUpTecEFkB4HduaxG13LWarV2bcnJyFQ78pRRomtZK5DgJ8pK+V+pMlUW0FDQNqRfJ9d
         LrhwJoN12X+Kzua4nviGarg/EyjUCs/Ju4BfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IelBoMcXO1vTu9Zhus7WzPbkxS4TYlVVfEd0KV/pKpf+OQk9X91wuGO2Vthc4WfLsg
         q77kced0FV4v7zv2FSDHdhnZDGR0dDrWsSDFO8U7f2XO5L1X8x2Q40ftqucIOOT1ERzs
         5XdQKMcH3mlAeZNluAy2owxXF+gWnbfmV9Pn8=
Received: by 10.204.134.70 with SMTP id i6mr2611966bkt.74.1273510639385; Mon, 
	10 May 2010 09:57:19 -0700 (PDT)
Received: by 10.204.11.7 with HTTP; Mon, 10 May 2010 09:56:58 -0700 (PDT)
In-Reply-To: <201005101841.40011.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146825>

On Mon, May 10, 2010 at 6:41 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> CC-ed Guiseppe Bilotta, author of 'patch' and 'patches' views
> (you can find this information using "git blame" or "git log --grep")=
=2E
>
> On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:
>
>> Add option '-M' to use with format-patch whcih detects
>> renames in the commit.
>
> =A0Subject: [PATCH RFC GSoC] gitweb: Use @diff_opts while using forma=
t-patch
>
> =A0Make git-format-patch (used by 'patch' and 'patches' views) use th=
e
> =A0same rename detection options that git-diff and git-diff-tree (use=
d
> =A0by 'commitdiff', 'blobdiff', etc.) use.

Excellent idea.

> Note that I am not sure if it is really a good change, as it might
> create patches that (currently) can be applied only with git.

I think we can live with that. If we get strong complains about this,
we can always introduce support for extra options to cancel the rename
detection. (Also, the upcoming GNU patch release seems to support the
git diff format, including copies and renames.)

> -- >8 --
> Subject: [PATCH RFC GSoC] gitweb: Use @diff_opts while using format-p=
atch
>
> Make git-format-patch (used by 'patch' and 'patches' views) use the
> same rename detection options that git-diff and git-diff-tree (used
> by 'commitdiff', 'blobdiff', etc.) use.
>
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Acked-by: Jakub Narebski <jnareb@gmail.com>
Acked-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

> ---
> =A0gitweb/gitweb.perl | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
> index 225f404..d983ce5 100755
> --- i/gitweb/gitweb.perl
> +++ w/gitweb/gitweb.perl
> @@ -6295,8 +6295,8 @@ sub git_commitdiff {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0push @commit_spec, '--=
root', $hash;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 open $fd, "-|", git_cmd(), "format-patc=
h", '--encoding=3Dutf8',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '--stdout', @commit_spe=
c
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 open $fd, "-|", git_cmd(), "format-patc=
h", @diff_opts,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '--encoding=3Dutf8', '-=
-stdout', @commit_spec
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or die_error(500, "Ope=
n git-format-patch failed");
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die_error(400, "Unknown commitdiff for=
mat");
>

--=20
Giuseppe "Oblomov" Bilotta
