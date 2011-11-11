From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Disappearing change on pull rebase
Date: Fri, 11 Nov 2011 10:50:16 +0100
Message-ID: <CAGK7Mr6D6-4aNceTDCYTHabA3vnxh+uvQ=GOeS_3nrL9rjmc9w@mail.gmail.com>
References: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net>
 <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com> <3FF1328CB05DB74898F769F1BA17812C3E49B74699@GVW1348EXA.americas.hpqcorp.net>
 <4EBCC71D.6000505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Pitucha, Stanislaw Izaak" <stanislaw.pitucha@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 10:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROnl9-0001Zn-3k
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 10:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab1KKJut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 04:50:49 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49763 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1KKJur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 04:50:47 -0500
Received: by yenr9 with SMTP id r9so2946108yen.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 01:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bU7wfeV5CdWfpItML9Qq2+gnvV4TyPyu78vEdXX7x6c=;
        b=ba4dbTQLviz9lim9WXZppGaDCRkS8f2fcbfjO9mImBRTHMTldo8t9vYKtM18VMB1mS
         4TzATUwsFJ9EfX77LgQmXiRA3/xbA45c0zKk83zp9TjmRHidlAFOsYt3Rj7vxRDaXJgl
         a4M+cnog5UgmewsmqpHOk2yVgO284RspPDqFw=
Received: by 10.50.17.199 with SMTP id q7mr11673990igd.20.1321005047143; Fri,
 11 Nov 2011 01:50:47 -0800 (PST)
Received: by 10.50.195.199 with HTTP; Fri, 11 Nov 2011 01:50:16 -0800 (PST)
In-Reply-To: <4EBCC71D.6000505@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185258>

> This is by design. Rebase does not rebase merge commits because it is
> assumed that merge commits only do what their name implies - to merge
> branches of a forked history. As such, they do not introduce their own
> changes. Follow this rule, i.e., make your change in a separate non-merge
> commit, and you are fine.

Doesn't this create a problem if you pull, resolve a conflit but do NOT
push, then pull --rebase some more commits later on? As I understand
it, the conflict resolution commit will be a merge commit and will be
thrown away by the git pull --rebase.

Philippe
