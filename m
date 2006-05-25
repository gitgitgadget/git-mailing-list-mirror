From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't write directly to a make target ($@).
Date: Thu, 25 May 2006 18:42:04 +0200
Message-ID: <874pze5a5f.fsf@rho.meyering.net>
References: <87hd3e5ixw.fsf@rho.meyering.net>
	<7vejyixe5g.fsf@assigned-by-dhcp.cox.net>
	<20060525194125.9380842a.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 18:42:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjIud-0004dp-Qb
	for gcvg-git@gmane.org; Thu, 25 May 2006 18:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWEYQmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWEYQmH
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 12:42:07 -0400
Received: from mx.meyering.net ([82.230.74.64]:41701 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1030261AbWEYQmG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 12:42:06 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 955406A54; Thu, 25 May 2006 18:42:04 +0200 (CEST)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060525194125.9380842a.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Thu, 25 May 2006 19:41:25 +0300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20745>

Timo Hirvonen <tihirvon@gmail.com> wrote:
> Or just use one tmp file, i.e. ".tmp" instead of t$@.

Argh, no.
That'd fail big time with parallel builds.
