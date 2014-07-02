From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] enums: remove trailing ',' after last item in enum
Date: Wed, 2 Jul 2014 12:58:05 -0700
Message-ID: <20140702195805.GD5816@google.com>
References: <1404325445-17914-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2QfW-0003Jy-AQ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 21:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbaGBT6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 15:58:10 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:48368 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbaGBT6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 15:58:09 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so13120645pac.39
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=63UNAPNCPpptkYgd3ZEKInYiCXF71wZXqf3MHTF7jWE=;
        b=dgneeHCxyCaOB/tu3TBftG+qoRT3uM7dzGrYTEk232AhzAQP6jC9hQGTcnu00gmj0Q
         P0Ylc9jvAiawn7vvP0/w6y6/QJeetLsXeTQi70+VA9pX0LaaBggCG06eY1odJJZZJKJe
         j983U38GDwZ5t9/tGz6CeBs4if6/1SdPcWYYj6ccyqnnUvscmcg/WK8Vc6UDvRkIyebv
         SClfoQIWMxVQuawhc8lSoiqSR27LzuedvMb3SkJk6eBiITMgGLIv+jtWTEdr+s43+aXX
         U3/JdMBFkdzIirK9f2dIan9833K13KB7O4zEBcWz38UMKkJ7C3MtL7CAPriGcmppAq3C
         aj3g==
X-Received: by 10.68.139.137 with SMTP id qy9mr37039pbb.11.1404331088572;
        Wed, 02 Jul 2014 12:58:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:9026:10c8:17a1:3751])
        by mx.google.com with ESMTPSA id r1sm2582200pdm.16.2014.07.02.12.58.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 12:58:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404325445-17914-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252835>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/clean.c | 2 +-
>  builtin/tag.c   | 2 +-
>  pretty.c        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Is there some gcc option or other tool that can automatically detect
this kind of problem so the regress/fix cycle doesn't have to repeat
too many times?

Looks like v1.7.2-rc0~32^2~16 (2010-03-14) and v1.7.4.2~34 (2011-03-16)
tried to fix this in the past.

Using the test from v1.7.4.2~34 also finds enums with trailing comma
in

 grep.h
 log-tree.c

Thanks,
Jonathan
