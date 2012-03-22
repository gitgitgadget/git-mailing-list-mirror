From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Locate git helpers with type -P, for when git --exec-path is multivalued
Date: Thu, 22 Mar 2012 10:46:57 +0100
Message-ID: <m262dxrmr2.fsf@igel.home>
References: <1332407219-7774-1-git-send-email-domq@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 10:47:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAecL-0002be-KL
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 10:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab2CVJr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 05:47:27 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55550 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030509Ab2CVJrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 05:47:17 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VD3294qytz3hhbF;
	Thu, 22 Mar 2012 10:47:13 +0100 (CET)
Received: from igel.home (ppp-88-217-115-54.dynamic.mnet-online.de [88.217.115.54])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VD31s4zKpz4Ks7M;
	Thu, 22 Mar 2012 10:46:57 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 478A3CA2AA; Thu, 22 Mar 2012 10:46:57 +0100 (CET)
X-Yow: I'm protected by a ROLL-ON I rented from AVIS..
In-Reply-To: <1332407219-7774-1-git-send-email-domq@google.com> (Dominique
	Quatravaux's message of "Thu, 22 Mar 2012 10:06:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193639>

Dominique Quatravaux <domq@google.com> writes:

> Under a setting of (eg) GIT_EXEC_PATH=/home/joe/bin:/usr/lib/git-core,
> constructs such as
>
>   . "$(git --exec-path)"/git-sh-setup
>
> do not work. The proper way is
>
>   . "$(PATH="$(git --exec-path)" type -p git-sh-setup)"

type doesn't take any options in POSIX, and -P is bash-only.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
