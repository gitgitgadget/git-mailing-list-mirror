From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Inconsistency in specifying commit & path for git diff
Date: Tue, 09 Oct 2012 22:37:18 +0200
Message-ID: <m2391n8jr5.fsf@igel.home>
References: <50747E48.3060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Arthur Etchells <adetchells@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 22:37:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLgYW-00038y-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 22:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab2JIUhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 16:37:22 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42930 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2JIUhV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 16:37:21 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XbqxV6Nqrz3hhqL;
	Tue,  9 Oct 2012 22:37:18 +0200 (CEST)
X-Auth-Info: HzO8NI1YxXmS2zfS+qE2k8q7jHErBEQoXS1jOoXfxfc=
Received: from igel.home (ppp-88-217-104-135.dynamic.mnet-online.de [88.217.104.135])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XbqxV66KhzbbhF;
	Tue,  9 Oct 2012 22:37:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 8B3D3CA2A4; Tue,  9 Oct 2012 22:37:18 +0200 (CEST)
X-Yow: I wonder if I could ever get started in the credit world?
In-Reply-To: <50747E48.3060203@gmail.com> (Arthur Etchells's message of "Tue,
	09 Oct 2012 15:43:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207343>

Arthur Etchells <adetchells@gmail.com> writes:

> git diff <commit>:<path>..<commit>:<path>

<commit>:<path> represents a tree or blob, but .. requires commits as
its end points.

(You can dereference a commit to get a tree or blob, but not the other
way round.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
