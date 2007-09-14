From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 03/13] Moved that status function to the status command file
Date: Sat, 15 Sep 2007 00:36:47 +0200
Message-ID: <877imsdgcg.fsf@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070914223124.7001.29374.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 00:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJmW-0002aG-V4
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbXINWg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756993AbXINWg5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:36:57 -0400
Received: from main.gmane.org ([80.91.229.2]:46945 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747AbXINWg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:36:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IWJmP-00022R-Hh
	for git@vger.kernel.org; Sat, 15 Sep 2007 00:36:53 +0200
Received: from c83-253-242-75.bredband.comhem.se ([83.253.242.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 00:36:53 +0200
Received: from davidk by c83-253-242-75.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 00:36:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-242-75.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:HOPRwlsUoARrz5y5QnRPu4ICSGY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58206>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> diff --git a/t/t0002-status.sh b/t/t0002-status.sh
> index 790b9fb..d0c31b2 100755
> --- a/t/t0002-status.sh
> +++ b/t/t0002-status.sh
> @@ -60,6 +60,14 @@ test_expect_success 'Status with an added file' '
>  '
> =20
>  cat > expected.txt <<EOF
> +foo/bar
> +EOF
> +test_expect_success 'Status with an added file and -n option' '
> +    stg status -n > output.txt &&
> +    diff -u expected.txt output.txt
> +'
> +
> +cat > expected.txt <<EOF
>  EOF
>  test_expect_success 'Status after refresh' '
>      stg new -m "first patch" &&
>

Oops, that should have been in the first patch.

--=20
David K=C3=A5gedal
