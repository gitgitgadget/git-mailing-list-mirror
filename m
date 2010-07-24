From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [WIP PATCH 12/22] Add tests for line history browser
Date: Sun, 25 Jul 2010 00:14:49 +0200
Message-ID: <201007250014.49568.trast@student.ethz.ch>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com> <1279984434-28933-13-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 00:15:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocmzh-0002fF-CD
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 00:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab0GXWOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 18:14:52 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:35654 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab0GXWOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 18:14:51 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 00:14:49 +0200
Received: from thomas.localnet (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 00:14:50 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <1279984434-28933-13-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151680>

Bo Yang wrote:
> +test_expect_success \
> +    'validate the output.' \
> +    'test_cmp current-path0 expected-path0 &&
> +	 test_cmp current-path1 expected-path1 &&
> +	 test_cmp current-pathall expected-pathall &&
> +	 test_cmp current-linenum expected-linenum &&
> +	 test_cmp current-always expected-always'

Please put the validation in the corresponding output-generating test,
so that they can fail individually.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
