From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH/RFC 0/4] Add option to enable filters in git-svn
Date: Tue, 31 May 2016 18:12:41 +0000
Message-ID: <20160531181241.GA28818@dcvr.yhbt.net>
References: <20160531150749.24840-1-naufraghi@develer.com>
 <33130d8be1ad6edaa75a75c43901a2fa@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matteo Bertini <naufraghi@develer.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:12:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7o9n-0000Yb-OB
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbcEaSMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 14:12:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54902 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804AbcEaSMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 14:12:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7791F992;
	Tue, 31 May 2016 18:12:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <33130d8be1ad6edaa75a75c43901a2fa@develer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296003>

Matteo Bertini <naufraghi@develer.com> wrote:
> Sorry to all, but I missed a Checksum mismatch error, I'll have a
> look and submit an update.

Sure, when you reroll can you also ensure lines are wrapped at
80 cols or less? (at least for the git-svn code, but probably
for the rest of it, too).

As for the option name, the "enable" prefix doesn't seem
right.  We already have some "use" prefixes (use-svm-props),
so maybe "--use-filters" is better.

I haven't looked into filters at all, yet, but you can probably
use the existing rot13 filter in t0021 for writing tests.

Thanks.
