From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] [submodule] Remove duplicate call to set_rev_name
Date: Thu, 20 Jun 2013 23:58:12 +0200
Message-ID: <20130620215812.GA2687@sandbox-ub>
References: <1371462936-9672-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upmxy-0001BD-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758375Ab3FTWE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:04:26 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:36479 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758370Ab3FTWE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:04:26 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jun 2013 18:04:26 EDT
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Upmrx-0001eT-LY; Thu, 20 Jun 2013 23:58:17 +0200
Content-Disposition: inline
In-Reply-To: <1371462936-9672-1-git-send-email-iveqy@iveqy.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228547>

Hi,

On Mon, Jun 17, 2013 at 11:55:36AM +0200, Fredrik Gustafsson wrote:
> set_rev_name is a possible expensive operation. If a submodule has
> changes in it, set_rev_name was called twice.
> 
> Solution is to move set_rev_name so it's only called once, no matter the
> codepath taken.

Looks good to me.

Cheers Heiko
