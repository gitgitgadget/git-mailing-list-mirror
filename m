From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep for fixed-strings
Date: Mon, 16 Nov 2009 19:50:50 +0900
Message-ID: <20091116195050.6117@nanako3.lavabit.com>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Brian Collins <bricollins@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 11:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9zAy-0002aX-Bf
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 11:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZKPKuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 05:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbZKPKuw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 05:50:52 -0500
Received: from karen.lavabit.com ([72.249.41.33]:48139 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbZKPKut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 05:50:49 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 9FEA211B94F;
	Mon, 16 Nov 2009 04:50:53 -0600 (CST)
Received: from 6910.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id D1VMT5LY8CG3; Mon, 16 Nov 2009 04:50:53 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=LQeeA0DePUMdXrODvr3MAF6MVPVyRIp8rZ5oTo1i3cT9W+gZo41VcTEUdl4wLwylL+4ieiFV7P6BbVKOvu3XRu5CGeurlFKjqSiz2AD+kReBa+Xdsnkbb4RHGe5bu80g+h48tfnhivtgCLJplEZkwZ0RxuIxyG3zzipwiPT66RE=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132998>

Quoting Brian Collins <bricollins@gmail.com>

> You will have to excuse me, this is my first patch and I don't know if
> this is the right place to post this. Apologies in advance if I'm in
> the wrong place.
>
> git-grep currently throws an error when you combine the -F and -i
> flags. This isn't in line with how GNU grep handles it. This patch
> allows the simultaneous use of those flags.

Junio, may I ask what happened to this patch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
