From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Omit patches that have already been merged from format-patch output.
Date: Mon, 12 Sep 2005 19:24:30 +1200
Message-ID: <46a038f905091200245f6330d9@mail.gmail.com>
References: <46a038f905091101529e045af@mail.gmail.com>
	 <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 12 09:26:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEig6-0005p8-Ic
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 09:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVILHYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 03:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVILHYc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 03:24:32 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:44199 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751197AbVILHYb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 03:24:31 -0400
Received: by rproxy.gmail.com with SMTP id i8so316891rne
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 00:24:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HR4i3l6J36w6Ar0ms6C9dJTtFsIL5jziBKvvjgeR33eNwxzxK+NxZJCK5mk/gGpHBoQwo17eshENebbjx3ZxHmHoSJ8wJOmPHQhQ29qWSvK4i+GCIQ2Szs60TUd76uFH3INzUzR+doV7K6sLoF59w8E0IPfyeAzNbVP6p38RfOc=
Received: by 10.38.101.51 with SMTP id y51mr262644rnb;
        Mon, 12 Sep 2005 00:24:30 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Mon, 12 Sep 2005 00:24:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8371>

On 9/12/05, Junio C Hamano <junkio@cox.net> wrote:
> This switches the logic to pick which commits to include in the output
> from git-rev-list to git-cherry; as a side effect, 'format-patch ^up mine'
> would stop working, although up..mine would continue to work.
> 

Hmmm - git-format-patch is now broken. Not sure if it's been this
particular commit or a change in git-rev-list. The bottom line is that
it will only create patches for my commits since the last merge.

This is broken when I work for a few days, merging often from my
upstream. At the end of the dev cycle, I want to generate the
patchbomb for upstream, and it only gives me the commits since the
last merge-in of upstream.

OTOH, git-log-script is doing the same since I've updated today.
Yesterday, both commands were behaving themselves...

cheers,

martin
