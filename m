From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Thu, 07 Jun 2012 19:07:27 +0200
Message-ID: <m23967vynk.fsf@igel.home>
References: <m24nqoohss.fsf@gmail.com>
	<CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
	<4FD05B45.2090006@alum.mit.edu>
	<7vd35bjcd6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Adam <thomas@xteddy.org>,
	John Wiegley <jwiegley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:07:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScgBb-0003Ln-1G
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760819Ab2FGRHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:07:40 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49099 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760754Ab2FGRHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:07:33 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3W7Y8d59SDz4LDfR;
	Thu,  7 Jun 2012 19:07:28 +0200 (CEST)
Received: from igel.home (ppp-88-217-110-237.dynamic.mnet-online.de [88.217.110.237])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3W7Y8c0kbxz4KK7b;
	Thu,  7 Jun 2012 19:07:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 94E16CA2A4; Thu,  7 Jun 2012 19:07:27 +0200 (CEST)
X-Yow: I'm meditating on the FORMALDEHYDE and the ASBESTOS leaking into my
 PERSONAL SPACE!!
In-Reply-To: <7vd35bjcd6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 07 Jun 2012 09:49:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199419>

Junio C Hamano <gitster@pobox.com> writes:

> The way I read the log message of e371046b64 is that the repository
> resulting from the conversion without this patch will be different
> for repositories that were originally converted by the older
> cvs2git.  So my impression is that it does not matter if the older
> tool died long time ago.  As long as repositories converted by it
> still lives in the field, reverting the patch will start producing
> different (and arguably more correct) results for people who are
> using such a repository that started its life long time ago.

Only if the conversion is restarted from scratch.  Otherwise, any
existing converted commits are preserved due to the incremental nature
of git cvsimport.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
