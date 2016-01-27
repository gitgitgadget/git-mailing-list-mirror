From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 16/19] mingw: mark t9100's test cases with appropriate
 prereqs
Date: Wed, 27 Jan 2016 17:02:25 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601271701390.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de> <49a0657c42cba813c4cf0c17169b28031c6d4312.1453818790.git.johannes.schindelin@gmx.de> <xmqqoac8au3t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:02:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSYM-0004rO-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbcA0QCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:02:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:61399 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933151AbcA0QCi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:02:38 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MeMOx-1ak7tl2w6J-00QD3J; Wed, 27 Jan 2016 17:02:26
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoac8au3t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:psjB9z6Ghi/sP0oiaCqy0oG5WUTYS5psjQcjB9FbRzUyYTEgZvv
 XkV3dy3L8pma8fm07EbvNskGc3KtdtXDtJtrS34ljwTQfFuUJobOZh6TAdEf25zd3EvV5hM
 fF4UpreUIZ3WttaIf7aguYLp8oBnk4BHsORG3ufBgZqGc1G+oFJ8eh9QxusQP/LHMnOGefD
 MzcWramTXVyqoquMyY3xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ns9T9uZXPRg=:Kx8Ixo1iOcjIEfd1nCOxsA
 pquSRmWyc91ltyjk8Fqrr7+W3I0WT/0nZJmU9IZGs1ZNUDfFzY7Ox5NDur33TxbVYnCMl95lU
 PPgfR57f5FsD3/Ok4c6YzkhQdJUxSWBMcxbImHBBNz0luMi7ki7bsgEIUXnVkibf4HZaExxfS
 j3VCnC4dL3gwxUUyisQuitsiV80Pa0N+9qWGa5cQfkc8+9MV/7i27W/xb5vzltxEwIQeQBk8h
 cPwDRjmE9GznjaNg6A1KKkY01pT5ZZWjsWlD3DYO1UnyErGGXpOy7ImLwIQSMgep8SE4clPuH
 XdKc5J6V4OVo+JIBJfhiHCuBodNjyAqLVHlL7Q/0x8oajHJRu3dCNpoVryZe0GB6sw7fs7R/+
 OSvPbu0B2QxipnWl70oo7ilEldg1EfIOM1pNa+57zkSeU/eKWJyH9d82iyT+rlC9ynVfpRbQW
 5ehKC+/vu+2SAiZaYmRx50vpFyhhtmYq7HqGs7dJ6lA+YUgBSy8MX4lsPYFLhzKx6t9+/p3WO
 JLMopMsMRogNMAx3AKGVvISOQBH+2yqY45DkjT4yc8nuuaJNMjwXh5cPN9ZqqW5Kc3tTQlC/g
 l19nyxM9qh0Nz6dCETZl9aISvOldJBGOp8RhIOK4D8VDUFDYnfqLVduS+iH9gnuA7SROh2uxH
 7W6gV3xF4OXeNcBkWh+C7YvWa4RozKh5Z4WgbzKCW//ybV1jUJwD/ZqMnqJ0BYB7n2ceuw6VJ
 vIjd/DC9JK+ASdlp7eLIshWO0IlOytBNQsXmNT6pW/Hq24c5cGOZiag1amSlImS+MWPoJ7Dp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284918>

Hi Junio,

On Tue, 26 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -181,7 +180,8 @@ test_expect_success "$name" '
> >  name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
> >  LC_ALL="$GIT_SVN_LC_ALL"
> >  export LC_ALL
> > -test_expect_success UTF8 "$name" "
> > +# This test relies on the previous test, hence requires POSIXPERM,SYMLINKS
> > +test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
> >  	echo '# hello' >> exec-2.sh &&
> >  	git update-index exec-2.sh &&
> >  	git commit -m '???????' &&
> 
> Hmph.  "Content-Type: text/plain; charset=X-UNKNOWN" in the header
> gives a hint to me, too.

Bah. I recently upgraded to a newer Alpine and must have overlooked the
unknown charset option. Sorry for that, I think I fixed it now (let me
know if not).

Ciao,
Dscho
