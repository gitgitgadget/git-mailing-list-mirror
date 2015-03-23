From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 26/27] t/*svn*: fix moderate &&-chain breakage
Date: Mon, 23 Mar 2015 10:36:54 +0100
Message-ID: <550FDEB6.8050809@drmicha.warpmail.net>
References: <550C2E7B.3030203@drmicha.warpmail.net> <317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net> <xmqqy4mree9x.fsf@gitster.dls.corp.google.com> <xmqqh9tfea1v.fsf@gitster.dls.corp.google.com> <20150320200239.GA25506@peff.net> <20150320201321.GA21945@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 10:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZynU-0005eg-TL
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 10:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbbCWJhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 05:37:19 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38359 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019AbbCWJhS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 05:37:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 0E7FD20AC0
	for <git@vger.kernel.org>; Mon, 23 Mar 2015 05:37:13 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 23 Mar 2015 05:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	 s=mesmtp; bh=g3xIguHtD97GqD2xglyuJqB3Qfo=; b=DlSJszLH+Zy+K6UZ4U
	fblWVIkYO23cGPhbQIYGhN6w/a5OGerI4TtgiPTa4XpULBnHVnK6apglDSVbcQZw
	IosgfU6Ff8nbjqEpzIjogSYiYcCF1aR7/KEHDD6sCsrgOdDk6KuqzWqTqqciwWYc
	3DjaGYHVJG474qOb9XeDbSN8I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=g3xIguHtD97GqD2xglyuJq
	B3Qfo=; b=K2bGTyn08CaqpMaHglkC8t1jioIaoQRYToouLmBQmWxO0aP0HKLbpm
	cBw1DYC/VVc7+QSJuSCH3SvkzxxVeTQ+J+xZxFCOe9N4iiFKbNAJtAEe83KZUgaQ
	Nxu2EdYCAmMlTRz4jlRAZ0GR+CZXwOgExRAaC0tehjDm1kdo6Pdew=
X-Sasl-enc: a+GmNVg53MIENtSEgvGrVGC5CrtpxLhjKzeX3Dqzp+vK 1427103415
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7E482C00027;
	Mon, 23 Mar 2015 05:36:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150320201321.GA21945@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266129>

Jeff King venit, vidit, dixit 20.03.2015 21:13:
> On Fri, Mar 20, 2015 at 04:02:39PM -0400, Jeff King wrote:
> 
>> Yeah, that was my impression, too. I don't have svn installed on my
>> system, so I missed those ones. I don't have CVS either. That might be
>> worth following up on.
> 
> Hmm, that turned out rather easy. No breakages at all in the cvs tests.
> It almost makes me think I ran the tests wrong. ;)
> 
> -Peff
> 

Yes, sorry, just catching up.

I applied to Jeff's series to next at 9c5cf4d, and I run with svn and
cvs tests. Full suite except for:

expensive, ext. cred. helper, mac fs, svnserve, svn-info, git-cvsserver, p4.

I guess I should recheck some prerequisites and adjust the svn-info test
to newer svn...

Michael
