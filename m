From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/2] git notes show: handle empty notes gracefully
Date: Fri, 06 Feb 2009 16:37:07 +0100
Message-ID: <498C5923.8070009@drmicha.warpmail.net>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Feb 06 16:38:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSmw-0000MX-Lj
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbZBFPhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZBFPhO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:37:14 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39061 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753332AbZBFPhN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:37:13 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4B2C3285EFA;
	Fri,  6 Feb 2009 10:37:12 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 06 Feb 2009 10:37:12 -0500
X-Sasl-enc: XVh+B22rYmGNYAup1ryZ//LOEAsGuGbhJSmaF4MORnoU 1233934631
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 182DC25945;
	Fri,  6 Feb 2009 10:37:10 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108737>

Michael J Gruber venit, vidit, dixit 06.02.2009 16:19:
> "git notes show" barfs when there is no note to show. This introduces a
> test (yes, a test!) and, in a second round, reacts more gracefully to
> empty notes and adjust the expected test output accordingly.
> 
> Note that in both cases (before/after the patch) the return code is
> non-zero: It's 128 in the ungraceful case, 1 when "dieing gracefully",
> uhm...
> 
> Michael J Gruber (2):
>   git notes show: test empty notes
>   handle empty notes gracefully
> 
>  git-notes.sh     |    2 ++
>  t/t3301-notes.sh |    5 +++++
>  2 files changed, 7 insertions(+), 0 deletions(-)

Uhm, I'm about 1 hour late with my afternoon coffee, and I'm afraid that
shows:

1) I meant "bark", not "barf", although both make sense here.

2) When did "format.signoff = true" in config stop working? OK, it never
did. So please consider this (anyway trivial series):

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
