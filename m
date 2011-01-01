From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] msvc: Fix compilation error due to missing mktemp() declaration
Date: Sat, 01 Jan 2011 20:26:02 +0000
Message-ID: <4D1F8DDA.1030303@ramsay1.demon.co.uk>
References: <4D139D91.8080503@ramsay1.demon.co.uk> <AANLkTineKS2e8PJs76PLZP4L4APwX2kAiFPg4pz3esae@mail.gmail.com> <4D1CDE84.7090402@ramsay1.demon.co.uk> <AANLkTinAAGWeFDomo-NQrVtrdf9ue1xVxufy+bkWz1Fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 01 21:32:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZ88A-0001si-R7
	for gcvg-git-2@lo.gmane.org; Sat, 01 Jan 2011 21:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab1AAUcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jan 2011 15:32:41 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:33441 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752923Ab1AAUci (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jan 2011 15:32:38 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PZ87w-0004C8-YW; Sat, 01 Jan 2011 20:32:37 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTinAAGWeFDomo-NQrVtrdf9ue1xVxufy+bkWz1Fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164402>

Erik Faye-Lund wrote:
> Actually, I suspect that you know exactly what my concern is (based on
> the above), and that it's not with your patch.

Actually no, which is why I asked! :-D

> I have a patch in my MSVC-tree that includes io.h in mingw.h, because
> mingw.h already depends on facilities from io.h on MSVC. My point was
> simply that this dependency was already present, and as such I think
> mingw.h is the appropriate place to include it.

OK, v2 of patch on the way...

ATB,
Ramsay Jones
