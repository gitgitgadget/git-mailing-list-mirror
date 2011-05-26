From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] git-grep: Fix problems with recently added tests
Date: Thu, 26 May 2011 17:55:50 -0400
Message-ID: <A33A9CA5-B648-44AE-9B8E-7C27AB48FE54@gernhardtsoftware.com>
References: <1306446622-12784-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 23:55:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPiX8-00078Z-Gl
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab1EZVzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 17:55:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45927 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab1EZVzw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 17:55:52 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id DF57A1FFC146; Thu, 26 May 2011 21:55:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 613F41FFC135;
	Thu, 26 May 2011 21:55:44 +0000 (UTC)
In-Reply-To: <1306446622-12784-1-git-send-email-michal.kiedrowicz@gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174581>


On May 26, 2011, at 5:50 PM, Micha=C5=82 Kiedrowicz wrote:

> test_expect_success 'grep -E -F -G pattern' '
> 	echo ab:aab >expected &&
> -	git grep -E -F -G a\\+b >actual &&
> +	git grep -E -F -G "aa*b" ab >actual &&
> 	test_cmp expected actual
> '

Wouldn't this also pass if -E was active instead of -G?  That's why I m=
entioned using a literal + in the pattern so that what -G and what -E w=
ould match would be different.

~~ Brian
