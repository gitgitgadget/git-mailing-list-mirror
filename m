From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Keeping two repos in sync
Date: Sun, 09 Sep 2012 11:03:09 +0200
Message-ID: <m2fw6rlgaa.fsf@igel.home>
References: <CACffvTqt9UHw1wLVDZ=PDqJuktcD8M7uUfnnuDZ5cf9gwxsSqA@mail.gmail.com>
	<m2k3w3lhjc.fsf@igel.home>
	<CACffvTryOcefmqNdJ00TuDPov+TpRZRvZ46UDV-8F_cdp80SgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 11:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAdQE-0008I0-Vz
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 11:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab2IIJDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 05:03:12 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40971 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2IIJDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 05:03:11 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XF5yQ13YHz3hhZ3;
	Sun,  9 Sep 2012 11:03:10 +0200 (CEST)
X-Auth-Info: Ri8VXLFICC1Xb+cXGjW54uTluNtjVomIuSI49+lLPXI=
Received: from igel.home (ppp-93-104-149-132.dynamic.mnet-online.de [93.104.149.132])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XF5yQ0kmFzbbhK;
	Sun,  9 Sep 2012 11:03:10 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BEC72CA2A5; Sun,  9 Sep 2012 11:03:09 +0200 (CEST)
X-Yow: Why are these athletic shoe salesmen following me??
In-Reply-To: <CACffvTryOcefmqNdJ00TuDPov+TpRZRvZ46UDV-8F_cdp80SgA@mail.gmail.com>
	(David Chanters's message of "Sun, 9 Sep 2012 09:44:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205069>

David Chanters <david.chanters@googlemail.com> writes:

> 2.  At this point I scan the two branches looking for a point to
> graft; I might have done this already in the past, but the point is
> since grafting is a local operation and I am not working in that
> repository, I might need to do it again anyway -- that graft
> represents a way of tieing the branches together at a point I can then
> "git merge".

You can "git merge -s ours" that grafting point, assuming "portable"
completely subsumes "bsd" at that point.  Future merges should then be
working normally.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
