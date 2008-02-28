From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Improve t6029 to check the real "subtree" case
Date: Thu, 28 Feb 2008 14:57:44 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281456550.22527@racer.site>
References: <7vprun32m2.fsf@gitster.siamese.dyndns.org> <20080228015122.GB31441@genesis.frugalware.org> <alpine.LSU.1.00.0802280944110.22527@racer.site> <20080228123654.GE31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 15:58:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkDm-0004ip-Hv
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 15:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbYB1O6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 09:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbYB1O6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 09:58:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:60231 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753069AbYB1O6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 09:58:16 -0500
Received: (qmail invoked by alias); 28 Feb 2008 14:58:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 28 Feb 2008 15:58:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UtytHHdBUA+fWK9Wy1g8+OAF7zPb/+TxqHbMJ8W
	E2E+Psxx+UWeYZ
X-X-Sender: gene099@racer.site
In-Reply-To: <20080228123654.GE31441@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75404>

Hi,

On Thu, 28 Feb 2008, Miklos Vajna wrote:

> On Thu, Feb 28, 2008 at 09:45:03AM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Why yet another file?  Why not enhance t6029, as suggested?
> 
> here it is.

Thanks.

> diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
> index 3900a05..35d66e8 100755
> --- a/t/t6029-merge-subtree.sh
> +++ b/t/t6029-merge-subtree.sh
> @@ -29,4 +29,51 @@ test_expect_success 'subtree available and works like recursive' '
>  
>  '
>  
> +test_expect_success 'setup' '

I'd call this 'setup subproject', but that's just nitpicking.

Ciao,
Dscho
