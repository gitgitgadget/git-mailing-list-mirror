From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v2 0/7] http: minor improvements
Date: Thu, 4 Mar 2010 21:38:11 +0100
Message-ID: <20100304203811.GB5626@darc.dnsalias.org>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 21:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnH1v-0003rf-IE
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 20:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab0CDTmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 14:42:19 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:55081 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932232Ab0CDTmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 14:42:17 -0500
Received: from bsmtp.bon.at (unknown [172.18.12.54])
	by lbmfmo03.bon.at (Postfix) with ESMTP id AF166CECA6
	for <git@vger.kernel.org>; Thu,  4 Mar 2010 20:42:15 +0100 (CET)
Received: from proxy.surfnet.iacbox (sadler01.aparthotel-adler.at [80.122.230.142])
	by bsmtp.bon.at (Postfix) with ESMTP id BD8CAA7EBB;
	Thu,  4 Mar 2010 20:41:25 +0100 (CET)
Received: from darc.lan (localhost [127.0.0.1])
	by proxy.surfnet.iacbox (Postfix) with ESMTP id C040D125A61;
	Thu,  4 Mar 2010 20:41:21 +0100 (CET)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@darc.dnsalias.org>)
	id 1NnHoB-0001Xt-6C; Thu, 04 Mar 2010 21:38:11 +0100
Content-Disposition: inline
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141541>

On Tue, Mar 02, 2010 at 06:49:24PM +0800, Tay Ray Chuan wrote:

> Changes from v1 (based on comments from Clemens):
>   - patch 3: don't say "remove condition", since we're actually enabling
>     it.
>   - patch 5: in keeping with separating http and http-walker, removed
>     http_cleanup() from http-walker->cleanup().
>   - patch 5: move http_cleanup() call after http-walker->cleanup(). This
>     isn't really needed, but do this just in case http-walker->cleanup()
>     does any http operations.

Thanks.

> [PATCH v2 1/7] t5541-http-push: check that ref is unchanged for non-ff test
> [PATCH v2 2/7] t554[01]-http-push: refactor, add non-ff tests
> [PATCH v2 3/7] http-push: remove "|| 1" to enable verbose check
> [PATCH v2 4/7] http-walker: cleanup more thoroughly
> [PATCH v2 5/7] http: init and cleanup separately from http-walker
> [PATCH v2 6/7] remote-curl: use http_fetch_ref() instead of walker wrapper
> [PATCH v2 7/7] remote-curl: init walker only when needed

Acked-by: Clemens Buchacher <drizzd@aon.at>
