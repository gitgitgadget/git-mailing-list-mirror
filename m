From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Fri, 17 May 2013 07:48:33 +0200
Message-ID: <5195C4B1.3010201@viscovery.net>
References: <cover.1368736093.git.trast@inf.ethz.ch> <9b7e6a882a21b7e1734ec6fd90d3cf0208bb68f1.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 17 07:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdDX4-0007Fh-S6
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 07:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab3EQFsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 01:48:43 -0400
Received: from so.liwest.at ([212.33.55.13]:26240 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab3EQFsm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 01:48:42 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UdDWr-0000uO-TI; Fri, 17 May 2013 07:48:34 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 911AF1660F;
	Fri, 17 May 2013 07:48:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <9b7e6a882a21b7e1734ec6fd90d3cf0208bb68f1.1368736093.git.trast@inf.ethz.ch>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224650>

Am 5/16/2013 22:50, schrieb Thomas Rast:
> +match_pattern_list () {
> +	arg="$1"
> +	shift
> +	test -z "$*" && return 1
> +	for pat in $@

You should have double-quotes around $@ here, but then you can just as
well abbreviate to

	for pat

and you don't need the 'test -z "$*' check anymore.

-- Hannes
