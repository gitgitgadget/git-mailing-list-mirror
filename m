From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] Use warning function instead of fprintf(stderr, "Warning: ...").
Date: Mon, 04 Jan 2010 09:18:47 +0900
Message-ID: <20100104091847.6117@nanako3.lavabit.com>
References: <1262535630-3918-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 01:19:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRafX-0002mp-P1
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 01:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab0ADATa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 19:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859Ab0ADATa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 19:19:30 -0500
Received: from karen.lavabit.com ([72.249.41.33]:45315 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab0ADATa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 19:19:30 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 5D52416F481;
	Sun,  3 Jan 2010 18:19:27 -0600 (CST)
Received: from 7464.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id A2OTCLAMR0DT; Sun, 03 Jan 2010 18:19:27 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=qYiNjFjdN4xr1PqDDT9wgt7b2Yl1fHtu+pxEwJ10GtAGg3Vj1sNqS5gz9ySDZwJkF9afpzJwXV6B95Rti7wjlGj6ujTEFWGVQVK2RHD/ojsFRwPfq6YqM4OftkqbQk26O7oGtDb8cE9pZuBPQHz6GDbDJ4bY8AzPEAiBuIV8jYo=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <1262535630-3918-1-git-send-email-tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136086>

Quoting Thiago Farina <tfransosi@gmail.com>

> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---
> Removed the LF from the end of the strings.

Trying this patch makes t6030-bisect-porcelain.sh fail for me. Was this tested at all?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
