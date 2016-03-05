From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Git clone sends first an empty authorization header
Date: Sat, 05 Mar 2016 09:47:52 +0100
Message-ID: <m2r3fpgvk7.fsf@linux-m68k.org>
References: <CAMDzUty+O2Gu7o4bFib71AaNZn647WQ1v7ceiznHOs7-xwZGUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 09:48:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac7sX-0004SZ-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 09:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbcCEIr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 03:47:57 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:48351 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcCEIr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 03:47:56 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3qHKMG2CrWz3hjBH;
	Sat,  5 Mar 2016 09:47:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3qHKMG1Pjgzvh1j;
	Sat,  5 Mar 2016 09:47:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ArhHZT6xJHqO; Sat,  5 Mar 2016 09:47:53 +0100 (CET)
X-Auth-Info: nx30mRe23emjpYWQ+5cdtsJofTGw4r0/KcB+kZzqG7So7Xgz4uiZklQJVVFejlp8
Received: from linux.local (ppp-88-217-5-227.dynamic.mnet-online.de [88.217.5.227])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  5 Mar 2016 09:47:53 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id C698E1E53A8; Sat,  5 Mar 2016 09:47:52 +0100 (CET)
X-Yow: Are BOTH T.V.S on??
In-Reply-To: <CAMDzUty+O2Gu7o4bFib71AaNZn647WQ1v7ceiznHOs7-xwZGUg@mail.gmail.com>
	(Guilherme's message of "Sat, 5 Mar 2016 10:21:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288305>

Guilherme <guibufolo@gmail.com> writes:

> When doing basic authentication using git clone by passing the
> username and password in the url git clone will first send a GET
> request without the authorization header set.
>
> Am i seeing this right?

Yes, that is the correct way to implement HTTP authentication.  The
client won't know which authentication method to use until the server
tells it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
