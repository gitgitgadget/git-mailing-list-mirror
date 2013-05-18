From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: .gitignore behavior on Mac
Date: Sat, 18 May 2013 23:01:13 +0200
Message-ID: <5197EC19.8080806@kdbg.org>
References: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com> <20130518184136.GH27005@serenity.lan> <CAEe6bfB30aD0LcgR4fzLy=xJGwzASJpgfvvtoTmFmJ1_2HZ4Jg@mail.gmail.com> <20130518185507.GI27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Lauri <peterlauri@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat May 18 23:01:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdoFm-0000e5-1M
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 23:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab3ERVBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 17:01:18 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:30377 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751268Ab3ERVBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 17:01:17 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6290CCDF84;
	Sat, 18 May 2013 23:01:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2E1C019F33F;
	Sat, 18 May 2013 23:01:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130518185507.GI27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224808>

Am 18.05.2013 20:55, schrieb John Keeping:
> On Sat, May 18, 2013 at 08:43:57PM +0200, Peter Lauri wrote:
>> But I just don't want to see that darn file. It is a config file that
>> I have changed, and I don't want to need to stash it for each "git
>> svn" action I want to perform... Any solution for that?
> 
> Read about --assume-unchanged in git-update-index(1).

Beware!! --assume-unchanged is a promise not to modify a file, but that
is not true in this case, because it *was* modified. It might hide the
file from the git-status output, but then git might do something
unexpected sometimes, because a promise was not kept.

See last paragraph of
http://article.gmane.org/gmane.comp.version-control.git/146353

-- Hannes
