From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Sep 2015, #06; Wed, 23)
Date: Thu, 24 Sep 2015 11:28:34 +0200
Organization: gmx
Message-ID: <0ddd415aa3fdb36def9f7c4c43735afd@dscho.org>
References: <xmqq8u7wwxql.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 11:28:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf2pi-00049b-PN
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 11:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbbIXJ2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 05:28:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:60878 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbbIXJ2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 05:28:49 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lm34j-1aDpcB3qFd-00Zcam; Thu, 24 Sep 2015 11:28:34
 +0200
In-Reply-To: <xmqq8u7wwxql.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:MILN9ocNfE6T+VAYOYlSFsLZsi1l721GccBwI541A7NmO9zcm4Y
 MHf4ojobUq+eXT5Ih7LUrss24mzZh5+LtQTxISukpD9f1WzFIzmyPz74/ewhamfGkiD7uCy
 5TdZBCUUvN3RrIVxDDRpubyj5trfeiNC9AqKWmPoImMD3UTijPDWHMlSR4A/pYHlGuw693Y
 e7VB5tzjGj7RWpONX595w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2T68PGs0Zaw=:Khi5wjSUxesra8vn9eQyVO
 jle72TqGGbIdxhIujqOAV7rLHjoEuOdykRTk8s3dsGmKNfzZ5glLdRdnBrUZVj8Sp1G4zZwPK
 hgdXjZGNkZIF2xI03HwORYZXvmhrS5pyd4725H3XS7tec/cno9YdBqQwt+x1SJCLPYGxKR1cB
 lDDku9/uP2Te7wgUyOOiALV4KiCuEpB0u06eVjrUzVeYlK52f1iDAGH9a5V6fGB++tPcA5sc0
 cD77Mg1hwmWzAq9Fn5+Yo3mfzR958MVrgOqhbh2RHdY47LPFtPmpc/ubDN6ccqREnuDvMMmQ9
 a/GTKO7OBSFrxR1PtzbMp2U92RpI8rkNDx/ilrtla+pKJbsAkD5PPxErBhkl03APP5CazeTIO
 FOR60YEKd7ogr8U9gaIM7hqYqVf//HK0MxsTJ/RSZBuQp6Z6aLwalgzXOrDCj25XGohIC6xFW
 lLFt7PHem86otR0K7PwX0RXDtq2nG+g1aVvoitfG1xm5Nl6i6OfhtVnVsobQNEQwfO7AQle3l
 2eTQSdrMMurZAUQKQhrNZK3vP8XE7oFY2Rf5EzRPvABqAlv0jNUyw6i0u/rnWLZo3luK2EFAI
 PmJQvvSLxv0mD7EcUw5k9CxYR4wEIVH8TYHpGuyfUzf2PYOtuZCOgq4J/GfLREltUoHSl2sxl
 GAUQl9hyD7umxkobLSUy/v0efGuOZPTDd9JsDlgY/she4uHWpj7kaKq9nB+/8In51alvYABX5
 g/RQF8plylYotE2jussUjU4y8jbbTMZUm+kehA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278543>

Hi Junio,

On 2015-09-24 00:56, Junio C Hamano wrote:
 
> * jc/fsck-dropped-errors (2015-09-23) 1 commit
>  - fsck: exit with non-zero when problems are found
> 
>  There were some classes of errors that "git fsck" diagnosed to its
>  standard error that did not cause it to exit with non-zero status.

Thanks for this!

> * sb/submodule-parallel-fetch (2015-09-23) 9 commits
>  - submodules: allow parallel fetching, add tests and documentation
>  - fetch_populated_submodules: use new parallel job processing
>  - SQUASH???
>  - run-command: add an asynchronous parallel child processor
>  - run-command: factor out return value computation
>  - strbuf: add strbuf_read_once to read without blocking
>  - xread_nonblock: add functionality to read from fds without blocking
>  - xread: poll on non blocking fds
>  - submodule.c: write "Fetching submodule <foo>" to stderr
>  (this branch uses sb/submodule-helper.)
> 
>  Add a framework to spawn a group of processes in parallel, and use
>  it to run "git fetch --recurse-submodules" in parallel.
> 
>  It seems that the fundamentals are almost there, modulo polishing
>  the overall structure to ensure that future enhancement can be made
>  cleanly.

Awesome. As I stated before, I am a big fan of this enhancement, even if I am sad that I have too little time to participate effectively.
 
Ciao,
Dscho
