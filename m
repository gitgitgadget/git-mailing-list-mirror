From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 2/2] Move git-dir for submodules
Date: Mon, 8 Aug 2011 22:44:40 +0200
Message-ID: <20110808204439.GA41500@book.hvoigt.net>
References: <1312831022-12868-1-git-send-email-iveqy@iveqy.com> <1312831022-12868-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 22:44:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqWgq-0007RS-8E
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 22:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab1HHUon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 16:44:43 -0400
Received: from darksea.de ([83.133.111.250]:37124 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752196Ab1HHUom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 16:44:42 -0400
Received: (qmail 13979 invoked from network); 8 Aug 2011 22:44:40 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 8 Aug 2011 22:44:40 +0200
Content-Disposition: inline
In-Reply-To: <1312831022-12868-3-git-send-email-iveqy@iveqy.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178979>

Hi,

On Mon, Aug 08, 2011 at 09:17:02PM +0200, Fredrik Gustafsson wrote:
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index c679f36..1ae6b4e 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -408,6 +408,7 @@ test_expect_success 'submodule update exit immediately in case of merge conflict
>  	 test_cmp expect actual
>  	)
>  '
> +

There is a whitespace error here which we seem to have overlooked. Junio
could you remove that?

>  test_expect_success 'submodule update exit immediately after recursive rebase error' '
>  	(cd super &&
>  	 git checkout master &&

Cheers Heiko
