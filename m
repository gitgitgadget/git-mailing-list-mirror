From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 25 Jun 2008 12:08:32 +0900
Message-ID: <20080625120832.6117@nanako3.lavabit.com>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
	<20080621121429.GI29404@genesis.frugalware.org>
	<7vwskfclfs.fsf@gitster.siamese.dyndns.org>
	<9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
	<20080624160224.GA29404@genesis.frugalware.org>
	<alpine.DEB.1.00.0806241709330.9925@racer>
	<20080624185403.GB29404@genesis.frugalware.org>
	<alpine.DEB.1.00.0806242007150.9925@racer>
	<7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
	<20080624221049.GE29404@genesis.frugalware.org>
	<7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
	<20080624233236.GI29404@genesis.frugalware.org>
	<7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLQB-0000aD-8e
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbYFYDKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445AbYFYDKt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:10:49 -0400
Received: from karen.lavabit.com ([72.249.41.33]:48198 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbYFYDKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:10:48 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 5E861C843F;
	Tue, 24 Jun 2008 22:10:39 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 8JMJFFOXIO5H; Tue, 24 Jun 2008 22:10:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=nGUgBA6E0h6qh5GgQSFqCqNvPe21MJPkH33SUOxMId/93Q0PhtqSFR/C3Q8XA7EBhAq/m1wTig2HpIMmhm/C6e37ZDruLx+MTi6K6K69Hm5Nd2cmELAqXXETO/cDQK5wGfgeln8BYnKk0AW9ULVkN1egzDVcX3nI3uuYBNOoG8M=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86200>

Quoting Junio C Hamano <gitster@pobox.com>:

> Miklos Vajna <vmiklos@frugalware.org> writes:
>
>> On Tue, Jun 24, 2008 at 04:16:36PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>>> It most likely makes sense to do (3) anyway.  upload-pack, receive-pack,
>>> anything else?
>>
>> I think that's all.
>
> Then that would be this patch on top of nd/dashless topic.
>
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 929136b..babf16b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1268,7 +1268,7 @@ install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> -	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_TCLTK

Doesn't "git archive --remote=<repo>" also execute git program on a remote machine?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
