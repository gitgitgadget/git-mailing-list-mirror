From: "Michal Rokos" <michal@rokos.cz>
Subject: Re: libcrypto core dump in 64bit
Date: Wed, 13 Feb 2008 10:04:23 +0100
Message-ID: <bcfb3e870802130104n46d88964uee3eb3841c38807b@mail.gmail.com>
References: <20080211112822.16b69495@pc09.procura.nl>
	 <alpine.LSU.1.00.0802112240280.3870@racer.site>
	 <20080212150612.4d28c373@pc09.procura.nl>
	 <loom.20080212T152138-849@post.gmane.org>
	 <20080212173842.0a3704b1@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 13 10:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPDYB-0002Ar-0P
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 10:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbYBMJE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 04:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbYBMJE2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 04:04:28 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:39935 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbYBMJEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 04:04:24 -0500
Received: by rn-out-0910.google.com with SMTP id i24so7710826rng.19
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 01:04:23 -0800 (PST)
Received: by 10.151.11.17 with SMTP id o17mr883833ybi.98.1202893463428;
        Wed, 13 Feb 2008 01:04:23 -0800 (PST)
Received: by 10.150.228.20 with HTTP; Wed, 13 Feb 2008 01:04:23 -0800 (PST)
In-Reply-To: <20080212173842.0a3704b1@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73759>

Hello,

On Feb 12, 2008 5:38 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> Did you get the full test suite to pass?

No - vanilla git's master won't pass (since HPUX vsnprintf is broken
(it returns -1 when n is exceeded).

With strbuf workarounds test suite passes up to t4200-rerere.sh.

I did not try to investigate further or continue with the rest of the tests.

MR
