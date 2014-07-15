From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] refs.c: add a public is_branch function
Date: Tue, 15 Jul 2014 16:20:51 -0700
Message-ID: <20140715232051.GL12427@google.com>
References: <1405465358-27054-1-git-send-email-sahlberg@google.com>
 <1405465358-27054-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:21:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7C1w-0007HC-Et
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759266AbaGOXU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:20:59 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57334 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099AbaGOXU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:20:56 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so136109pdj.7
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u3IUCZ2GgYb0+xdrNTclv5L2oBksy2YkIR4uNOUJajo=;
        b=kbqPcSBmh+G3JjIXXgGOUaxIo8gFJ4NWWHVke7TberSIPkTItuf3HTTck9/vzuuZRW
         /F4CdS4taMmXhEVTvrFoCU8rNAua96PQPh4XX6Up8YfvJ+wdjToQXa7jq56lfLQITd+w
         lOVrk9iE1uNU2xdw+frqPSo//hrkAgerNYJy795W0rk8CKts2XObU5JAxfdZwzRqgxqb
         8H312lmGJmEzQjfD1vMGjWeiLd4KuwbGNwzyUtBbaXrU+MVWySg6LnPsrds8uImHVS4D
         r59736CpVGu+l6G1vdvRELjzDLpa+CGf5pB/i1FUBm736atDKkEg1qeblukU4bYsbPiV
         mV0A==
X-Received: by 10.66.188.5 with SMTP id fw5mr25324911pac.63.1405466454396;
        Tue, 15 Jul 2014 16:20:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:888a:1e2f:d307:1d55])
        by mx.google.com with ESMTPSA id z4sm2219486pda.84.2014.07.15.16.20.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 16:20:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405465358-27054-2-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253618>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/fsck.c | 5 -----
>  refs.c         | 2 +-
>  refs.h         | 2 ++
>  3 files changed, 3 insertions(+), 6 deletions(-)

Makes sense -- thanks.  (This is an old one: v1.5.4-rc4~27
(2008-01-15), v1.5.4-rc4~30 (2008-01-15).  Most of the running time of
fsck is per-object, not per-ref, so maintainability here seems worth
the performance cost.)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
