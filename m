From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git-scm.com refresh
Date: Tue, 08 May 2012 19:46:46 +0200
Message-ID: <m262c6h8ft.fsf@igel.home>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
	<7vd36j8lc3.fsf@alter.siamese.dyndns.org>
	<CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
	<7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
	<C0239E9A908644EAB06A52AE4A90F401@PhilipOakley>
	<7vipg77wg1.fsf@alter.siamese.dyndns.org>
	<7vlil2wr8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Scott Chacon" <schacon@gmail.com>,
	"git list" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 19:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoUu-0006ua-Lo
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab2EHRqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 13:46:48 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36031 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2EHRqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:46:47 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Vn7Rp1xFpz3hhf4;
	Tue,  8 May 2012 19:46:46 +0200 (CEST)
Received: from igel.home (ppp-93-104-129-118.dynamic.mnet-online.de [93.104.129.118])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Vn7Rp3RPdz4KK3d;
	Tue,  8 May 2012 19:46:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 2B2E9CA2A9; Tue,  8 May 2012 19:46:46 +0200 (CEST)
X-Yow: ..  over in west Philadelphia a puppy is vomiting..
In-Reply-To: <7vlil2wr8k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 May 2012 09:51:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197411>

Junio C Hamano <gitster@pobox.com> writes:

> I encountered another example yesterday after sending the above message
> [*1*].  I was fixing one small bug, and had a commit that updates code and
> adds a test vector.  It is a single commit on top of the current branch
> tip, which allegedly as a buggy code.
>
> Then I wanted to double check that the bug really existed before the fix.
>
> 	git checkout HEAD^
>         git show @{-1} t/ | git apply

Alternative:
          git checkout @{-1} t/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
