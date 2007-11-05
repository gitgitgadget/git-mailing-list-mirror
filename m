From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] parse-options: abbreviation engine fix.
Date: Mon, 5 Nov 2007 12:38:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051237420.4362@racer.site>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <Pine.LNX.4.64.0711051230020.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1FE-0003eh-PD
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbXKEMjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbXKEMjf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:39:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:60151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754689AbXKEMje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:39:34 -0500
Received: (qmail invoked by alias); 05 Nov 2007 12:39:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 05 Nov 2007 13:39:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Cc7EHaHLCX0sE58SCMwanYnx2Udrhv1amdvVC5w
	pmqvDqoV+fbaTy
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711051230020.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63507>

Hi,

On Mon, 5 Nov 2007, Johannes Schindelin wrote:

> +cat > expect << EOF
> +boolean: 0
> +integer: 2
> +string: 123
> +EOF
> +
> +test_expect_failure 'non ambiguous option (after two options it abbreviates)' '
> +	test-parse-options --st 123 &&
> +	test ! -s output.err &&
> +	git diff expect output
> +'
> +

Aaargh!  Yet another instance of test_expect_failure being wrong, wrong, 
wrong.

I'll come up with a replacement patch.

Ciao,
Dscho
