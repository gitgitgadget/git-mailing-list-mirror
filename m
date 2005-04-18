From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [PATCH] Pretty-print date in 'git log'
Date: Mon, 18 Apr 2005 12:02:02 -0700
Organization: http://madrabbit.org/
Message-ID: <1113850922.23938.54.camel@orca.madrabbit.org>
References: <1113803220.11910.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 18 21:01:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNbUB-0006X2-JI
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 21:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVDRTDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVDRTDU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 15:03:20 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:46052 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S262164AbVDRTCD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 15:02:03 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id 7C0CB4C1442; Mon, 18 Apr 2005 12:02:02 -0700 (PDT)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113803220.11910.81.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 15:46 +1000, David Woodhouse wrote:
> Add tool to render git's "<utcseconds> <zone>" into an RFC2822-compliant
> string, because I don't think date(1) can do it.

I admit it's not obvious, but date(1) includes gnu's full date parser,
so you can pull stunts like:

ray:~/work/home$ date -ud 'jan 1, 1970 + 1111111111 seconds'
Fri Mar 18 01:58:31 UTC 2005
ray:~/work/home$ date -ud 'jan 1, 1970 + 1111111111 seconds + 0800'
Fri Mar 18 09:58:31 UTC 2005

Ray


