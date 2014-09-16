From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 01/35] unable_to_lock_die(): rename function from
 unable_to_lock_index_die()
Date: Tue, 16 Sep 2014 12:52:41 -0700
Message-ID: <20140916195241.GA29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:53:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyo0-0008Hr-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbaIPTwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:52:49 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41122 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbaIPTws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 15:52:48 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so468773pad.28
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i4nb7dlA/9jXkdhm3mr3YKJfyPXKfVtS7AIA7LO7G94=;
        b=CqPt6UAas8A+FYYjqYfMkB7UmG4WgCGpeComqYDaQpIGc/J5bDtMpY+M2AXBXhz3sl
         nX9MiCllOax2NvDjG1zYGY8M+9PVUUsJDjwW1t4WEA4TFExtdwPsAiMazPwCi3BOXqFm
         moWahkbU7UN1Bk2GNQmoBSBUVfKkgDp7TLGtCm9W4J9T497tryVsKX7cNRKDWAAt1Bli
         tj8titYlzzRz7TH6GEjhF9INWV59AJjo6JqTfL2wf41g+bYRxrR7R15H1RYvrx7m1eGx
         ZDMZ3C5Mfm0UGZXhJGROGQDUd+aDW16BLArVmKdDhnnmWB70ztp5oQBqsivEbM65OL3u
         1qPA==
X-Received: by 10.68.136.100 with SMTP id pz4mr52992198pbb.119.1410897167819;
        Tue, 16 Sep 2014 12:52:47 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id bq17sm15358168pac.47.2014.09.16.12.52.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 12:52:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-2-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257182>

Michael Haggerty wrote:

> This function is used for other things besides the index, so rename it
> accordingly.

Makes sense.

[...]
>  builtin/update-index.c | 2 +-
>  cache.h                | 2 +-
>  lockfile.c             | 6 +++---
>  refs.c                 | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
