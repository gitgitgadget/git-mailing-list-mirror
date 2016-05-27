From: David Aguilar <davvid@gmail.com>
Subject: Re: t7800 test failure
Date: Thu, 26 May 2016 21:19:44 -0700
Message-ID: <20160527041944.GA17438@gmail.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
 <vpqk2ijs8p2.fsf@anie.imag.fr>
 <xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
 <CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
 <xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
 <CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 27 06:19:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b69Fa-0000N2-KX
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 06:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbcE0ETu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 00:19:50 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35025 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbcE0ETt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 00:19:49 -0400
Received: by mail-pa0-f66.google.com with SMTP id gp3so4378602pac.2
        for <git@vger.kernel.org>; Thu, 26 May 2016 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DYM8jyXiTaYh1p3kQsc+1T4sqst+y4WbD3MhFdU6iWc=;
        b=Ii6jhI67fgGQETvQzpoBSq2yECe/qAfw956JZjMkPRRQ7F9x0c+FzbUjtKHOLHnrYp
         WTA/p9PT3TLrXssH6UIiN+l75YuyY1FG5K7V0LmTvuitNFvK2Z9QYcttqmUDt9xEtAxW
         lOlGMuNLu4cA+WmuK5K9ArJTCRIgWm8I1W4CkcNPIvGxJ+Fy4gB605A86yWBrvX8Hu4t
         IlPdrOhzaUt0YNlofXsQJGsl0fKbYo0r9f/hRNuRduJ8Z1vwGpeqITnNwse7pJ6soxDk
         1sldZFFWbMZOYuRtWY3VD+vAiW/DxFB1VlQvsuYFVVPuSSZ3jiKza3wxqFQslSEPbDSO
         m0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYM8jyXiTaYh1p3kQsc+1T4sqst+y4WbD3MhFdU6iWc=;
        b=B8pDG8KQMfmq06S5MumehM9iQxSH6xgNSEe0URu0Tsr/u50zv1cE4HKK4MoGGHNmJS
         UbEzGnlacwSgamW08JuYFA6TokjBPZPc6N95XaJttcgg3Ak7ONXnyNryBYt+jgllWWCg
         eD1EU7OXgDM7kJ2f6PFChVptiSWuFgvHDgRKgwAIjwPd4UW9VCd2WgEMQ5mZltqn/66A
         XFjAzbJ+kQUvJjM2TVjprFmjWbWBbvTUSIG53pZ+0xmcscF6+HzwcaEXqwlB23gPeWB6
         teML2TlCnHKa9G7UyROdAz00tAJ3+2OVzx7Q+herE4A+cdGSe+C+ayjMLMZFOTsQvLHr
         RzwQ==
X-Gm-Message-State: ALyK8tJwqSAVjI8jUSEs9j04lCd2V3qU0CY8m8AqRnJ8rQzTc64puq9o9tbuNJjzS1O6ug==
X-Received: by 10.66.164.133 with SMTP id yq5mr19199670pab.107.1464322788054;
        Thu, 26 May 2016 21:19:48 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id l67sm9560455pfi.10.2016.05.26.21.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2016 21:19:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295728>

On Wed, May 25, 2016 at 11:33:33AM +0200, Armin Kunaschik wrote:
> On Tue, May 24, 2016 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Armin Kunaschik <megabreit@googlemail.com> writes:
> >>
> >> Ok, how can this be implemented within the test environment?
> >
> > I actually think an unconditional check like this is sufficient.
> 
> Ah, good. My thoughts were a bit more complicated.
> Anyway, this works for me.
> Thanks!

Would you mind submitting a patch so that we can support these
tests when running on AIX/HP-UX?


> >  t/t7800-difftool.sh | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index 7ce4cd7..f304228 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -442,15 +442,16 @@ run_dir_diff_test 'difftool --dir-diff with unmerged files' '
> >         test_cmp expect actual
> >  '
> >
> > -write_script .git/CHECK_SYMLINKS <<\EOF
> > -for f in file file2 sub/sub
> > -do
> > -       echo "$f"
> > -       readlink "$2/$f"
> > -done >actual
> > -EOF
> > -
> >  test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
> > +
> > +       write_script .git/CHECK_SYMLINKS <<-\EOF &&
> > +       for f in file file2 sub/sub
> > +       do
> > +               echo "$f"
> > +               ls -ld "$2/$f" | sed -e "s/.* -> //"
> > +       done >actual
> > +       EOF
> > +
> >         cat >expect <<-EOF &&
> >         file
> >         $PWD/file

I was curious so I whipped together a small tweak to
t/check-non-portable-shell.pl below.

The difftool tests are not the only ones that use readlink.
My guess is you haven't run the p4 tests because AIX/HP-UX doesn't have p4?

	$ make test-lint-shell-syntax
	t7800-difftool.sh:449: error: readlink is not portable (please use ls -ld | sed):       readlink "$2/$f"
	t9802-git-p4-filetype.sh:266: error: readlink is not portable (please use ls -ld | sed):                test $(readlink symlink) = symlink-target
	t9802-git-p4-filetype.sh:332: error: readlink is not portable (please use ls -ld | sed):                test $(readlink empty-symlink) = target2
	test-lib.sh:757: error: readlink is not portable (please use ls -ld | sed):             test "$1" = "$(readlink "$2")" || {

If we want to ban use of readlink from the test suite we could
add it to the check script.  test-lib.sh also includes it for
valgrind support so I'm not really sure whether we'd want to
apply this, but I figured I'd bring it up for discussion.

If we end up fixing all of these then I can send this to the
list as a proper patch.

Curious, is there an easy way to get readlink and mktemp installed on AIX?

Another alternative is that we can compile our own
"git-readlink" and "git-mktemp" programs and use those instead,
but that seems like a big maintenance burden compared to the
relative simplicity of the test-suite workarounds.

Thanks for fixing my non-portable tests ;-)

--- 8< --- 8< ---
From 40c41402dfa24ca16b41062172c34f238d77b42c Mon Sep 17 00:00:00 2001
From: David Aguilar <davvid@gmail.com>
Date: Thu, 26 May 2016 02:42:52 -0700
Subject: [PATCH] tests: add shell portability check for "readlink"

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b170cbc..2707e42 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -18,6 +18,7 @@ while (<>) {
 	chomp;
 	/\bsed\s+-i/ and err 'sed -i is not portable';
 	/\becho\s+-n/ and err 'echo -n is not portable (please use printf)';
+	/\breadlink\s+/ and err 'readlink is not portable (please use ls -ld | sed)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
-- 
2.7.0.rc3

-- 
David
