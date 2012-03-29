From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 5/8] gitweb: Move HTML-formatting diff line back to process_diff_line()
Date: Thu, 29 Mar 2012 17:14:42 +0100
Message-ID: <201203291814.42803.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-6-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:14:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDHzv-0001Rw-P2
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 18:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759538Ab2C2QOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 12:14:46 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54124 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758981Ab2C2QOp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 12:14:45 -0400
Received: by wibhq7 with SMTP id hq7so210238wib.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=dMZI1k0kaLDQSARD3pYbOJPYz5mIwvTSesooWBtE6gU=;
        b=UxtseFadfox9+G7pKOGTpBbrxtZDSh0OnWvhNSfeHazpq2Ej36+nnLqghBetULcXH1
         mViuJWFMQpWtaw2iITwzPDTzL1dFmfU56gTWrXCQnp2raLEScGq9Ql7Z2FFxmzNlSUQc
         Ae6P9kR6TaPUY433uw69JBvpiZn5X2fM5WgBfoXEVNHOd8uXu7YlNu671tT42QvJN+a/
         A/ZgmRC9F5SIJcLnD1W0KGD4A1c0F8sGKVcrcfYAnwERvPYZV6qaEvDyQ0hx1BVj0l7v
         vpVplVgJPAKGoUA8IJqp/VRZpmyyY8C+vk2lqIoLsIlN6hzjB9UtPTn7JkPA5htDImkf
         /jmQ==
Received: by 10.180.80.104 with SMTP id q8mr7026642wix.14.1333037684072;
        Thu, 29 Mar 2012 09:14:44 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id k6sm68099355wiy.7.2012.03.29.09.14.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 09:14:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-6-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194266>

On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> Commit 6ba1eb51b (gitweb: Add a feature to show side-by-side diff,
> 2011-10-31) for no special reason moved wrapping diff line in <div> o=
ut
> of format_diff_line(). Bring back old behavior.
>=20
I remember that originally process_diff_line was format_diff_line...=20

> This simplifies code in git_patchset_body() and keeps formatting of a
> diff line in one place.
>=20
That is a good enough reason for me.

> The more long-term purpose of this patch is to move formatting diff
> lines down to print_diff_chunk(), to allow processing lines without
> HTML-formatting.
>=20
Excuse me, but from this commit message (and from the patch itseld)
I don't see how this commit (patch) can help with this goal (and
don't remember details of discussion).

Please explain it in more detail, or simply remove above paragraph.

> This is just a refactoring patch. It's not meant to change gitweb
> output.
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
[...]
--=20
Jakub Narebski
Poland
