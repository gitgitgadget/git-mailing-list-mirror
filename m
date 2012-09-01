From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Sat, 01 Sep 2012 23:09:39 +0200
Message-ID: <m2627xwiuk.fsf@igel.home>
References: <1679275990.100371.1346175639379.JavaMail.root@genarts.com>
	<fab86cd5-e3cf-4ddf-aa00-aafe44e8ce8c@zcs>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sat Sep 01 23:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7uxr-0007hs-Do
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 23:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab2IAVJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 17:09:47 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59191 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab2IAVJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 17:09:47 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3X8VST1N5jz3hhfT;
	Sat,  1 Sep 2012 23:09:40 +0200 (CEST)
X-Auth-Info: 3Fh8tcJIpQxph66K8uJlf00ItR7Ht7Ea/orkgEhASc8=
Received: from igel.home (ppp-88-217-112-52.dynamic.mnet-online.de [88.217.112.52])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3X8VSN6fRPzbbgB;
	Sat,  1 Sep 2012 23:09:40 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5E6EACA2A2; Sat,  1 Sep 2012 23:09:39 +0200 (CEST)
X-Yow: I was born in a Hostess Cupcake factory before the sexual revolution!
In-Reply-To: <fab86cd5-e3cf-4ddf-aa00-aafe44e8ce8c@zcs> (Enrico Weigelt's
	message of "Sat, 01 Sep 2012 22:11:13 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204651>

Enrico Weigelt <enrico.weigelt@vnc.biz> writes:

> * git-diff or git-format-patch or tig should not show differences
>   that are only whitespace changes (eg. differing linefeeds or
>   tabs vs. spaces, changed indentions, etc)

--ignore-all-space

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
