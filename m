From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 00/12] unify appending of sob
Date: Tue, 12 Feb 2013 12:16:13 -0800
Message-ID: <20130212201613.GC12240@google.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MHU-0006XY-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab3BLUQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:16:21 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:33972 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3BLUQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:16:18 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so195102dal.29
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=s1pl4OcdqZxtbpiNcv1stjkXcggiU0zky2niszw0/j8=;
        b=rHWyKOaux2bZcY7QDwncJLJh/UWrsUa3i2T7HmSvKY8bOhjaZKbQY8pAWrlMD27qfI
         pljYvYdWY6GAGRkw7k7jUP5UiTPd+6GnYMKe/xE/zap9oFD+gPqrkxUGxn7xkNVauUjz
         jbd4jSJM4ezanE6XU2LyPppTSbNCmpITOt+u/tgKOqX0r0LuzcKO7QbXG8LRhgAhm0Rf
         mxTLzMrQtXe4c0tlGn1yPouh19vBUMKD7kNLifQwVhP3cSTbqMHhd79yHpFJlm0F40gc
         9kkGuvjZuAK+dAfVdiZsU1fE4gQ4L9wGjfZ2/iV5c5S8J73BD0k9+JhIWwkRbof7fozX
         TGtQ==
X-Received: by 10.66.75.66 with SMTP id a2mr55490680paw.65.1360700178016;
        Tue, 12 Feb 2013 12:16:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id k7sm64124541paz.13.2013.02.12.12.16.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 12:16:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216186>

Brandon Casey wrote:

> Round 4.

Yay.  I think this is cooked now and a good foundation for later
changes on top.

For what it's worth, with or without the two tweaks Junio suggested
(simplifying "(cherry picked from" detection, deferring introduction
of no_dup_sob variable until it is used),
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
