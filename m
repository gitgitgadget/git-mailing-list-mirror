From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v3.1 3/5] Introduce new pretty formats %g[sdD] for reflog information
Date: Sun, 18 Oct 2009 19:34:43 +0900
Message-ID: <20091018193443.6117@nanako3.lavabit.com>
References: <8a5b3a586d437f02e2a75edd2786636b605522a7.1255701207.git.trast@student.ethz.ch>
	<e0ab6923eb4057bcbc8e97980dad5e4a37e53067.1255790816.git.trast@student.ethz.ch>
	<20091018071829.GA7748@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 18 12:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzT6R-0007Jg-Np
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 12:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbZJRKew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 06:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZJRKew
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 06:34:52 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44744 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbZJRKev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 06:34:51 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id DFD6111B8D0;
	Sun, 18 Oct 2009 05:34:55 -0500 (CDT)
Received: from 7574.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 2HC45C4ED4VT; Sun, 18 Oct 2009 05:34:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Tql9Ta1LmuQJ2buTrRKn6KViRelBLi28ZG1G7tkOF2g5Pq0yK/bVjWZvE9kKhuMUVEJMIzAYZ/kz2yX4VpFkhr8i0otvHxyEsjaGJ7BfRRvQ1o+qjZuVrlSw5IB0hdTt47cHCERRxpkpKbABlwRV/v4D/WfCd2DeD3NlMg43Pig=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091018071829.GA7748@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130591>

Quoting Jeff King <peff@peff.net>

> On Sat, Oct 17, 2009 at 04:48:11PM +0200, Thomas Rast wrote:
>
>> > +NOTE: Some placeholders may depend on other options given to the
>> > +revision traversal engine. For example, the `%g*` reflog options will
>> > +insert an empty string unless we are traversing reflog entries (e.g., by
>> > +`git log -g`). The `%d` placeholder will use the "short" decoration
>> > +format if `--decorate` was not already provided on the command line.
>> 
>> Sure.  I figured it was obvious enough, but since you already went to
>> the lengths of documenting the exact behaviour of %d, I squashed it
>> and adjusted the acknowledgement in the commit message accordingly.
>
> If the consensus (or Junio's decision when applying) is that we don't
> need it, I don't mind if my suggestion is scrapped (or reworded).

I think your clarification is a good addition.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
