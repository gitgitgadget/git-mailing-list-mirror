From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] diff.c: Ensure "index $from..$to" line contains unambiguous SHA1s
Date: Sun, 30 May 2010 21:58:40 +0200
Message-ID: <201005302158.40314.j6t@kdbg.org>
References: <201005301537.18039.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 30 22:01:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIoho-0001dQ-Fa
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab0E3UBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 16:01:35 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15545 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753510Ab0E3UBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:01:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 059C510010;
	Sun, 30 May 2010 22:01:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5F61719F758;
	Sun, 30 May 2010 21:58:40 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <201005301537.18039.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148013>

On Sonntag, 30. Mai 2010, Johan Herland wrote:
> +cat >expect_initial <<EOF
> +100644 blob 51d2738463ea4ca66f8691c91e33ce64b7d41bb1	foo
> +EOF
> +
> +cat >expect_update <<EOF
> +100644 blob 51d2738efb4ad8a1e40bed839ab8e116f0a15e47	foo
> +EOF
> +
> +test_expect_success 'setup' '
> +	echo 4827 > foo &&
...
> +	echo 11742 > foo &&

How the fscking hell did you find these two simple values that are an 
almost-SHA1-collision? It's easier to hit the jackpot!?!

-- Hannes
