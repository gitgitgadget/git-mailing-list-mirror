From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: diffstat witdth with one changed file
Date: Mon, 21 May 2012 19:33:54 +0200
Message-ID: <m2obphcubh.fsf@igel.home>
References: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Zbigniew =?utf-8?Q?J=C4=99drz?= =?utf-8?Q?ejewski-Szmek?= 
	<zbyszek@in.waw.pl>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 19:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWWUe-00019N-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 19:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab2EURd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 13:33:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36363 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808Ab2EURd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 13:33:57 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Vx6Xz52lbz4Kn98;
	Mon, 21 May 2012 19:33:55 +0200 (CEST)
Received: from igel.home (ppp-88-217-114-7.dynamic.mnet-online.de [88.217.114.7])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Vx6Xz4K8Gz4KKJF;
	Mon, 21 May 2012 19:33:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id F352ECA2A4; Mon, 21 May 2012 19:33:54 +0200 (CEST)
X-Yow: I've got a COUSIN who works in the GARMENT DISTRICT...
In-Reply-To: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 21 May 2012 22:52:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.97 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198118>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> With recent git, "git log --stat 90e6ef5", the first commit's diffstat
> uses full terminal width while the next one uses less than 80 chars.
> Both changes one file. Is it intentional?

In commit 0e641b1 the file has only 41 lines of changes, so it looks
intentional.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
