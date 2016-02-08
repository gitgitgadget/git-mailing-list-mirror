From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 8 Feb 2016 20:59:31 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602082056410.2964@virtualbox>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net> <20160208135013.GA27054@sigill.intra.peff.net> <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com> <20160208163700.GA22929@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602082027550.2964@virtualbox> <20160208193509.GA30554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:59:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSryS-0005ac-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbcBHT7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:59:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:57402 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbcBHT7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:59:47 -0500
Received: from virtualbox ([89.204.153.48]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lmb2Z-1ZuM6A2xAx-00aB58; Mon, 08 Feb 2016 20:59:34
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160208193509.GA30554@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hUgdj0Vfhq3VJARs4c3XU30boyBey1Z+lfVw+E40Rg4n7uI7MsX
 Oz0pvvRp3erv2a5PDJ8eEERUn9+vZT7VPRSJBW2mA3FrKauFjH3NtAI/CkOKsNlCY8SVw+z
 KM3+9NY4dFsqRFbZoFw/UOxGuSpPFJXuXrmH76O9iZPfB4HKSSwPLITE64Ly/KllumqCcSr
 lw2zZxF6T1cNL+LMJbpQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S2JRS73DcMI=:6a0RmqzTvM7bwCIgfj1Gdy
 nRyPkr4qoszxBHDUQ1Tz2Z8LBcWuXYVdCJ8cfKUsmm8kTi3v2HE17KGzDidqISNnaJ97FqFZB
 6kTsvoMVogKYVAmMmtyUtvmrTGo4FvuNYfp+baS5OC0Cqq1YdLDsXz46EXkiAU375C9/Uv5k9
 KAH0mBRKKvqL8Bvp2SU52Q9uYUI2Pd1sA9EzTKtab/IRIxVCnugVN/FfxI8qgbMYCisjj3o58
 /wHl/u28ZFnQtuhicKeNv+d3T+aMdklQit5T/56oT8OvkrvrFqbxHOHJt/2HVC0SqdWCMNVas
 EHumqLe6w7v5EI10CRQtEpqPuOJi0Ew//qjMLqZbCS20yImI9oZZwZRf2FKmdzISfUavK2h6i
 vQMVefZ8TOFR7Fu4gP+R4S4Aar3nwfgZ6WI5e4pHuu+cqLuUzjjxqlqxfA/eWp0D6RO7M9umq
 SwSE8DUbrS6yfpOBZZOzGvp0CgZrtX+EBJ7ay2dDLl67cHIqIU+Lv7GtW9A8hIeC5PbadxIQu
 70MUwvttQY6CmGEPI8pPWzlnDznVbOYWA2ByGYWWJipC+RsWn37vJxwQnvdIOAJdBQZvrCNA+
 Zrt5VLw7zYLnmaPpjQnHAjrfRuGgPqh8+1p2ooqOFS7RB0Y19x6JXEMGP5c/76fND85Umh3CO
 5Zf/ayvnMANJiFHFGhOv1Fz8kcjxZTaaX6GJq1oJKlXepzs90LQy1HA5od0LZYhPu/C3We9iB
 f3uHNbIJib4Oz1sn55P13/XD1rdYW/JftWDwtLcgXIW4DwoKR+ALA7wzxcM8VcZc6g0DD0C6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285798>

Hi Peff,

On Mon, 8 Feb 2016, Jeff King wrote:

> On Mon, Feb 08, 2016 at 08:31:54PM +0100, Johannes Schindelin wrote:
> 
> > On Mon, 8 Feb 2016, Jeff King wrote:
> > 
> > > Assuming your patch works on Windows
> > 
> > If it re-introduces that chmod +x, it won't.
> > 
> > Please note that my *original* patch actually only guarded the chmod +x,
> > but Junio suggested switching to write_script and since it passed the test
> > suite here, I though it would be safe.
> > 
> > I still think write_script is the better alternative.
> 
> I'm confused why it matters. write_script() unconditionally calls "chmod
> +x", doesn't it?

Hmpf, you're right. I'll check tomorrow what's going wrong.

> I just double-checked its definition in test-lib-function.sh; am I
> missing some Windows-specific magic that kicks in?

No Windows magic I know of. But actually, the patch could be simplified to

-- snip --
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 56acc1e..ee85cc7 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -30,7 +30,7 @@ test_expect_success \
 		echo "deep dir" >dir/a/b/c/d/e/file &&
 		mkdir bar &&
 		echo "zzz" >bar/zzz &&
-		write_script exec.sh </dev/null &&
+		write_script exec.sh /bin/sh </dev/null &&
 		svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
 	) &&
 	rm -rf import &&
-- snap --

> > So why not just prefix it with `SHELL_PATH=/bin/sh`?
> 
> But then what is write_script buying us?

write_script is a semantically unambiguous way to specify what we *want*.
And it would allow us to handle chmod specifically for Windows *in one
place only*.

But as I said, I have to investigate what's going on.

Ciao,
Dscho
