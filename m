From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] rebase-i: work around Windows CRLF line endings
Date: Tue, 27 Oct 2015 10:55:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510271054380.31610@s15462909.onlinehome-server.info>
References: <cover.1445782122.git.johannes.schindelin@gmx.de> <cover.1445939154.git.johannes.schindelin@gmx.de> <adcab7dcf9d802b3703b9ec9291132259a092a04.1445939154.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:56:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0z3-0007R2-4a
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbbJ0Jz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:55:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:63927 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754AbbJ0Jz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:55:56 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MUTSJ-1ZyxD003Dn-00RLUj;
 Tue, 27 Oct 2015 10:55:45 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <adcab7dcf9d802b3703b9ec9291132259a092a04.1445939154.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:yRllQJVaUwa0XxrnEqeZJhURF5NvqkiqVMhO0+3ts4G/llIXZl4
 FNMcvNaTgJJN2hV5rCc/RFHUZUUDbwnzadr3/dGFaFkOXqzP316dVbQVN7pQHP2Jf1cace9
 cyTY76UCg1mwHle53vSE6wnKF67guulqGkYnQr3ffHw3uxTmpPiTsD+iJFUoeDc2wSu9Txi
 x1j7B5Lb8v4piECugFvoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1fjJX80sgvQ=:gq8xlF+hIWf/RlRUk0a292
 RrUT8xmhULcpkyOVeafRrFK13vN9bxmGaxKVonn6Zeqt58eAaFL6u3JbJ7aPxzfUSY1kpya2/
 kxwCdE9Fx4EtPNP1km5tQli7m2fWSasFAdJl1BabdgMa2C2uoQu2aJZ85/lPq9MIZM9dpc7hf
 HW0AUJ+McxVNHXH89VaLp+zsl3tCdMfvjPDsMIuJv+K1/6O02q/ND4yynxDDtMwQbERB/mP2f
 qDUWvPvZXj9dlMHtasn3uybDtFnqKrm4qc8BGGS3n/oavNiKskUDb1uRsiMx74vGVgZV8B4ae
 NjyQNZZ2lSlZIq25pIB05t8jpZ//LxnuHJGTEbzCncEfdSjyzWjSAP3qhvdGpt71az7WStjVB
 /2G+DKxc2rGLvtIzsEGjB1OVuopXemWBlXeiyybhYI555i5WALt0mXtthzl0u6cix9x2VKUJ9
 n2bpB6r+aDpEy7akSSOxZBPpFOU5N7vl/lVYKO8G1BsynRAFiNVSCqShwh071UR0J4eRtQHhR
 30KjMOwpFXOt0iIqnb6LEQnvH/G9TDiv2nyAM1VngiH6LRZWfVHRCWdoqT47qEPSMN7iC75VH
 7qSsEWbmwSqDYfqQGlMtFEP5ikgWNXFmyI2u0RxZ3N8W2KjTckEPsgO3j+WLY+bHp4QEsAZ/F
 PkKecI1ML5nzkpHWSWlYVKrI/PgEN3xpSCVTEixT5mdVGdF1fBxvcnAzsufZqCKlzQBHHurmX
 74HuAa13moA1MaFPei9AxH49sRMGi7BgtzXC/wDHOkXtAJj3EFSAKkO1dOuzStaFpX9ffIXT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280256>

Hi,

On Tue, 27 Oct 2015, Johannes Schindelin wrote:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 5dfa16a..98eb49a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1261,7 +1261,7 @@ test_expect_success 'static check of bad SHA-1' '
>  	test E = $(git cat-file commit HEAD | sed -ne \$p)
>  '
>  
> -test_expect_failure 'editor saves as CR/LF' '
> +test_expect_success 'editor saves as CR/LF' '
>  	git checkout -b with-crlf &&
>  	write_script add-crs.sh <<-\EOF &&
>  	sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&

My apologies: I forgot to spell out explicitly that this passes in Git for
Windows 2.x' SDK: It does.

Ciao,
Johannes
