From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v4] submodule: add --no-fetch parameter to update command
Date: Sun, 11 Jan 2009 10:32:08 +0900
Message-ID: <20090111103208.6117@nanako3.lavabit.com>
References: <1231553410-7541-2-git-send-email-git@fabian-franz.de>
 <1231553410-7541-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, j.sixt@viscovery.net, hjemli@gmail.com,
	gitster@pobox.com
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 02:34:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLpDc-0000Ze-An
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 02:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbZAKBc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 20:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754233AbZAKBc6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 20:32:58 -0500
Received: from karen.lavabit.com ([72.249.41.33]:49412 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147AbZAKBc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 20:32:57 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 57D19C7B34;
	Sat, 10 Jan 2009 19:32:57 -0600 (CST)
Received: from 6722.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id EWOS0ERY0Z64; Sat, 10 Jan 2009 19:32:57 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=S2Whf+Vo/UTGg042itz/okZJufPnW98d1bOKi3VLs50pzYI3YiH8z7r85aw3TgKNWm5jsKyQ5frnLgqwY45XdTS5elPmb/FgSRuPsjUqyPNlPSWyMC3EjI54BuVOSnv5ZHXD9EVy0oxC+UoSOaVwNbPvg2bP7qPWUrgezpFIF6g=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1231553410-7541-2-git-send-email-git@fabian-franz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105149>

Quoting Fabian Franz <git@fabian-franz.de> writes:

> When -u|--use-gitmodules is given the update command uses the .gitmodules
> config file instead of the .git/config file to obtain the track parameter.
> This makes it for example possible to change branches for all submodules
> at the same time without having to sync up .git/config first.
>
> Signed-off-by: Fabian Franz <git@fabian-franz.de>

Once you start doing that, doesn't it force you to always bypass .git/config, making the current mechanism even less useful?  If you find that "having to sync up .git/config first" is inconvenient, wouldn't it be more useful for your patch if it made it easier and more convenient the procedure "to sync up .git/config first", instead of bypassing the current setup?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
