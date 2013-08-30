From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] check-ignore: Add option to ignore index contents
Date: Fri, 30 Aug 2013 08:51:34 +0200
Message-ID: <522040F6.5060602@viscovery.net>
References: <20130829224652.GA13621@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Spiers <git@adamspiers.org>
To: Dave Williams <dave@opensourcesolutions.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 30 08:51:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFIYa-0004NO-HY
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab3H3Gvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:51:40 -0400
Received: from so.liwest.at ([212.33.55.24]:43786 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab3H3Gvk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:51:40 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VFIYR-0005AG-7b; Fri, 30 Aug 2013 08:51:35 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DDFF41660F;
	Fri, 30 Aug 2013 08:51:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130829224652.GA13621@opensourcesolutions.co.uk>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233426>

Am 8/30/2013 0:46, schrieb Dave Williams:
> +-i, --ignore-index::
> +	Don't look in the index when undertaking the checks. This means
> +	the results deviate from those seen by git add and git status
> +	but is useful when understanding why a path became tracked by
> +	e.g. git add . and was not ignored as expected by the rules.

Did you mean to say "was not ignored as expected by the user"? Because the
"the rules" cannot "expect" something, they only "are applied".

-- Hannes
