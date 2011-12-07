From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] test: add missing "&&" after echo command
Date: Wed, 7 Dec 2011 18:10:03 -0500
Message-ID: <20111207231002.GD21852@sigill.intra.peff.net>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
 <7vk469fm9j.fsf@alter.siamese.dyndns.org>
 <20111207144217.GA30157@elie.hsd1.il.comcast.net>
 <20111207144540.GB30157@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Vijay Lakshminarayanan <laksvij@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 00:10:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYQcu-0002Z1-7W
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 00:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758121Ab1LGXKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 18:10:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42952
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab1LGXKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 18:10:05 -0500
Received: (qmail 21275 invoked by uid 107); 7 Dec 2011 23:16:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 18:16:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 18:10:03 -0500
Content-Disposition: inline
In-Reply-To: <20111207144540.GB30157@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186520>

On Wed, Dec 07, 2011 at 08:45:40AM -0600, Jonathan Nieder wrote:

> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 3ad04363..da75abc1 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -60,7 +60,7 @@ test_expect_success \
>  
>  test_expect_success \
>  	"next commit" \
> -	"echo 'bongo bongo bongo' >file \
> +	"echo 'bongo bongo bongo' >file && \
>  	 git commit -m next -a"

Patch is obviously correct, but isn't the "\" here just superfluous and
error-prone? Maybe it should just be dropped from the new version (and
possibly from other tests in t7501).

-Peff
