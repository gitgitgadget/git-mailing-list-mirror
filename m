From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 0/4] Colouring whitespace errors in diff -B output
Date: Tue, 15 Sep 2009 15:52:09 +0900
Message-ID: <20090915155209.6117@nanako3.lavabit.com>
References: <1252995306-32329-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 08:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnRub-0005qr-S4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 08:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111AbZIOGw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 02:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757664AbZIOGw6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 02:52:58 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49174 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756898AbZIOGw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 02:52:57 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 5A62611B877;
	Tue, 15 Sep 2009 01:53:01 -0500 (CDT)
Received: from 8314.lavabit.com (delhi-202.54.61-99.vsnl.net.in [202.54.61.99])
	by lavabit.com with ESMTP id OP6FDFEDBTVI; Tue, 15 Sep 2009 01:53:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=G3ky9qaKN2gMPZD3lYUXU7uQ5IlXQbFpkjUQhC9z4byf0jGWJHAZzWREtCiVJ0wZqSmjCiHUWxGArpLacwgy+UkR3m7xeBHE9kC+t1F8OMVb+OmXxUioTezCgliSVx7G369Z2ev7iCxT23ue3r/Mos5rZpGSdnBCsVtcvcMcJFQ=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1252995306-32329-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128519>

Quoting Junio C Hamano <gitster@pobox.com>

> Here is a 4-patch miniseries to teach "diff -B" output routines to detect
> and colour whitespace errors like we do for normal patches.
>
> The first three patches are only about moving code around without changing
> anything.
>
> The last one hooks "diff -B" logic to the per-line output routines in a
> way that mimicks how the normal patches are fed to them better, in order
> to take advantage of all the existing whitespace error detection and
> colouring logic.
>
> Junio C Hamano (4):
>       diff.c: shuffling code around
>       diff.c: split emit_line() from the first char and the rest of the line
>       diff.c: emit_add_line() takes only the rest of the line
>       diff -B: colour whitespace errors
>
>  diff.c |  327 +++++++++++++++++++++++++++++++++++-----------------------------
>  1 files changed, 180 insertions(+), 147 deletions(-)

Sorry, but I don't seem to be able to apply these patches anywhere.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
