From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when not
 running verbosely
Date: Fri, 29 Feb 2008 23:34:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802292334040.22527@racer.site>
References: <1204323805-23185-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVEmA-0004BR-7H
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397AbYB2Xfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758744AbYB2Xfc
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:35:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:56601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758397AbYB2Xfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:35:31 -0500
Received: (qmail invoked by alias); 29 Feb 2008 23:35:29 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp044) with SMTP; 01 Mar 2008 00:35:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/J0t8JVHrJ0jjB0ej90ZZtZ4y5b4qfGPJQ49qsuY
	RrhaMSHhvncRcX
X-X-Sender: gene099@racer.site
In-Reply-To: <1204323805-23185-1-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75591>

Hi,

On Fri, 29 Feb 2008, Mike Hommey wrote:

> diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
> index 149ea85..43b5f15 100755
> --- a/t/t6024-recursive-merge.sh
> +++ b/t/t6024-recursive-merge.sh
> @@ -81,7 +81,7 @@ EOF
>  
>  test_expect_success "virtual trees were processed" "git diff expect out"
>  
> -git reset --hard
> +git reset --hard >&3 2>&4
>  test_expect_success 'refuse to merge binary files' '

Would it not be _much_ more sensible to pull that command _into_ the 
test_expect_success?

Ciao,
Dscho
