From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Problems reverting (includes reverting a merge)
Date: Mon, 09 Jun 2008 10:00:19 +0100
Message-ID: <1213002019.26678.2.camel@pitcairn.cambridgebroadband.com>
References: <b1d95faa0806051045t67ea0f46r55cdaeb794dc2f5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jenny w <veganjenny@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 11:01:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5dFN-0005Ft-S9
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 11:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbYFIJAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757411AbYFIJAH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 05:00:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:60171 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432AbYFIJAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 05:00:06 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1081713ugf.16
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 02:00:03 -0700 (PDT)
Received: by 10.67.20.3 with SMTP id x3mr1536295ugi.62.1213002001796;
        Mon, 09 Jun 2008 02:00:01 -0700 (PDT)
Received: from ?10.0.0.166? ( [212.44.17.78])
        by mx.google.com with ESMTPS id q40sm6255744ugc.6.2008.06.09.01.59.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 02:00:00 -0700 (PDT)
In-Reply-To: <b1d95faa0806051045t67ea0f46r55cdaeb794dc2f5c@mail.gmail.com>
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84374>

On Thu, 2008-06-05 at 10:45 -0700, jenny w wrote:

> What I'd really like to do is just zap the last 3 commits ... is there
> another way to just make things the way they were before these patches
> were applied?

Wouldn't git-reset --hard HEAD^^^ do what you want. It will rewind your
tree to 3 commits bellow the current head, the --hard ensure your
working tree is cleared out as well.

> 
> Any help with any of the above would be greatly appreciated!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Alex, homepage: http://www.bennee.com/~alex/
Envy is a pain of mind that successful men cause their neighbors. --
Onasander
