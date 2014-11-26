From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t1402: check to delete broken refs
Date: Tue, 25 Nov 2014 16:35:06 -0800
Message-ID: <20141126003506.GA19239@google.com>
References: <1416956166-20341-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, gitster@pobox.com, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 01:35:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtQZl-0000nA-C5
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 01:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbaKZAfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 19:35:15 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57265 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaKZAfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 19:35:14 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so1715568ieb.3
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 16:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dWN7BPSkEmuFJKSoXNJG9z+S0H5XrxP+caS/OZ31vKQ=;
        b=eKmXeXHlYv9J0ieUva+0Nb84bW+ZOkyIwgAn+nWRLszxENkUjHp99ifbVE84T3702N
         Upuijq4tR/PRgaqYzSsj5mSJHwubyRaW+jhNQ3q+YDpQXoIifwb1IO8dA+m4lTuX4NvC
         aZ/kqvJ3OHTw39xmcM+ksQYdwb0pXIlD21KUgA9aejmHuJEZeWsi/S3QFZjkADVjhyoA
         ylWPm8YVyU+oZOXQ76zAU5BTGLDQH5l0d88roBnu7WmpfKcLWcEgsTHhrTqd8j2hC0Rf
         f71xKYRZrl+SB9+R6XZRbKWxf+0yEK3jquTfK8pWIJy/DScECOJDCWgegBr5tJPrcOi6
         r9HQ==
X-Received: by 10.107.132.78 with SMTP id g75mr26708315iod.21.1416962113788;
        Tue, 25 Nov 2014 16:35:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31d4:43f9:cf9a:f63a])
        by mx.google.com with ESMTPSA id l2sm1122294ioe.34.2014.11.25.16.35.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:35:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416956166-20341-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260254>

Hi,

Stefan Beller wrote:

> This was also part of the ongoing series from Ronnie.
> But I think the patch in this form is rather independant,
> documenting the current state of "git branch -d", so it's
> fine to have it in now.

Is there a patch adding the feature this patch describes that this
could be squashed into?

>  t/t1402-check-ref-format.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)

This doesn't have anything to do with check-ref-format --- it's about
how easy it is to recover from a repository with corrupt files in it.
Would it fit somewhere like t3200-branch.sh?
