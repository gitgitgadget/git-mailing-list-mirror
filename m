From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t/t3404: fix test for a bogus todo file.
Date: Tue, 13 Nov 2007 21:52:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711132152040.4362@racer.site>
References: <7vhcjpsv9a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:53:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3gr-0008I0-OH
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762975AbXKMVwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762953AbXKMVwr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:52:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:43057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762900AbXKMVwq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:52:46 -0500
Received: (qmail invoked by alias); 13 Nov 2007 21:52:44 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 13 Nov 2007 22:52:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kJCMYe70ksNOBk/U8cbSWStTVlbZAVvFW/iePKR
	5Nu2VM01rv9+hD
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcjpsv9a.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64887>

Hi,

On Tue, 13 Nov 2007, Junio C Hamano wrote:

> The test wants to see if there are still remaining tasks, but checked a 
> wrong file.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3404-rebase-interactive.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 1113904..f1039d1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -149,7 +149,7 @@ test_expect_success 'stop on conflicting pick' '
>  	diff -u expect .git/.dotest-merge/patch &&
>  	diff -u expect2 file1 &&
>  	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
> -	test 0 = $(grep -v "^#" < .git/.dotest-merge/todo | wc -l)
> +	test 0 = $(grep -v "^#" < .git/.dotest-merge/git-rebase-todo | wc -l)

Oh well, another fallout of my brilliant name picking.

Thanks,
Dscho
