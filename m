From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 2/2] Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
Date: Mon, 25 Jul 2011 18:17:22 +0200
Message-ID: <m239hugwrx.fsf@igel.home>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
	<1311519554-16587-3-git-send-email-jon.seymour@gmail.com>
	<CACsJy8Aa_=BvZOt58sM4dknVzvihH9OtHAS1aRxqPwNLxh0fkg@mail.gmail.com>
	<CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Jens.Lehmann@web.de, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 18:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlNqW-000161-S2
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 18:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab1GYQR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 12:17:28 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39351 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1GYQR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 12:17:27 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 4D4F2186DEC5;
	Mon, 25 Jul 2011 18:17:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 82E2F1C00053;
	Mon, 25 Jul 2011 18:17:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id J5OkNkvw5Qfd; Mon, 25 Jul 2011 18:17:22 +0200 (CEST)
Received: from igel.home (ppp-88-217-120-241.dynamic.mnet-online.de [88.217.120.241])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 25 Jul 2011 18:17:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 3A5FBCA293; Mon, 25 Jul 2011 18:17:22 +0200 (CEST)
X-Yow: Yow!  I want my nose in lights!
In-Reply-To: <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
	(Jon Seymour's message of "Mon, 25 Jul 2011 18:45:35 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177798>

Jon Seymour <jon.seymour@gmail.com> writes:

> +       return ret ? 1 : 0;

          return ret != 0;
          return !!ret;

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
