From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Fri, 12 Jun 2015 22:41:26 +0200
Message-ID: <557B43F6.9070502@web.de>
References: <5575F948.4060400@web.de> <xmqqioavob7n.fsf@gitster.dls.corp.google.com> <20150612044906.GA17424@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, eda@waniasset.com,
	Duy Nguyen <pclouds@gmail.com>
To: Scott Schmit <i.grok@comcast.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Vll-0003el-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 22:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbbFLUlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 16:41:36 -0400
Received: from mout.web.de ([212.227.15.4]:53611 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbFLUlf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 16:41:35 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MHp7t-1Z29Fq3uPt-003ef1; Fri, 12 Jun 2015 22:41:28
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150612044906.GA17424@odin.ulthar.us>
X-Provags-ID: V03:K0:GgKTACFPW+o/rRVvf8c7WZi5T1Fa/S0ygE7vVHxNj6ga6spnVl9
 05odtcZxvxbIsmfwmgNxDVzbHBAqpPqgaNAW1YkC9UJTpzvZJUnp+PZtgyosdttO6hu34kf
 r8lEgMg4ZjxvDZKgA9omK/mnwHTXnl8qpq2TDflz3/SZM2HDjlysHAci7QFJE49X70LboGe
 1O2cY7xVK7vnpis8KJSBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iVsNYg9B0nI=:J1KHhQ7EUhS1fETu0czu27
 nWJbyyY69OwdUfW9cWEOedq+VkQHfJWR1nkP4Uce81cfhGSGel4lIrK+q3HoQd88nTC8OP21v
 8FRCfoGzgGFgBR1SppeNXRVpA3DAW3k7U2gJWwnCnEUpJ9O74GOAfMgqNWQb7IxUd21L9/V1T
 K1fsQ56kbtYUN6DnUZMJTbfoVVB/ZNNcu9hZAyyOHM+E+1nHnXXhulh5GSlyL1DMLyXwMr0/z
 JvzIHDG8rCAdKgY+uLWx1mM7F0/GLpUCG+H2L89IZdwcDMA4UwrkXtnmbA7iGoN2oZ60GSuDi
 xM9Xl3JLaofUxFab1yMvT2n4DHZEeP0gGXBbQm2r+uulJLOxc/REbb8g5+RNcbxU0dvS6IPvo
 uAJxgKHUVIYjcprXjMmCnXY8KnGCOZfDHLGijiQQVjbrncaibRbk5tuYl7oZJ5G6M7Kq0Fbc5
 FwOvjiFYCXBHs/6zLL1d6aaoTnSQXqrsl58clH4adkgvJTb3udnB0sGKfeoLreRGrnhvQX0kX
 BnG4/hToHaEthSb7ei+TjfbRZq/FM4Y8XdHyO6dljQgDsEK79UqVdJamQ3BjcZtkrys1G5hs2
 p8E/K/doZ0zrGvGF4Zp3Km6tuBkm9XamgpwtGTsGCRCwgEIKDnIygKQ3i2e6Mvq+m6mp+XudY
 evw4aztSR5Uoh4hg6XeuIa1jk/9RMCpY89sHVI6T8JOBdvbm+l9T10fmHuguguhl/pEg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271520>

On 2015-06-12 06.49, Scott Schmit wrote:
> 'git checkout' with <paths> or `--patch` is used to restore modified or
> deleted paths to their original contents from the index or replace paths
> with the contents from a named <tree-ish> (most often a commit-ish)
> instead of switching branches.
-------------------
I will probably send a patch, the next days or so.
It feels as if we can split the long sentence, and differntiate
between the "restore" and "copy content from other tree-sh".
How about this:


'git checkout' [--] <pathspec>...::
	'git checkout' with <paths> is used to restore modified or
	deleted paths to their original contents from the index.

'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
	'git checkout' with [<tree-ish>] and <paths> or `--patch` is used
	to replace <paths> with the contents from a named <tree-ish>
	(most often a commit-ish) instead of switching branches.
	In this case, the `-b` and `--track` options are
	meaningless and giving either of them results in an error.  The
	<tree-ish> argument can be used to specify a specific tree-ish
	(i.e.  commit, tag or tree) to update the index for the given
	paths before updating the working tree.
+
