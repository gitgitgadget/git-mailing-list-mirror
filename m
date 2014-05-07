From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 07 May 2014 14:06:16 -0500
Message-ID: <536a842838fbb_76ff7a52ec5d@nysa.notmuch>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
 <vpqy4ydpiog.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 21:17:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi7L6-0008Ex-32
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 21:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbaEGTRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 15:17:09 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60231 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaEGTRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 15:17:06 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so1799437obc.27
        for <git@vger.kernel.org>; Wed, 07 May 2014 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=FBljwLwX4eaMq7uQpaHxfXwYUXXq1raGkglU1geiAew=;
        b=0QI7oV+07oeQlS/fsw4qdKwlFBi5yrG5v0yASZwHcCllegifOdYJIQ83m1WPoeXyOO
         ELD21iQxYtnonQa3Dnk5lOOfxR6bEnfo2sGzJitmUSX5zCQpdLUfWBmtixecO7IqNh+1
         b+aryrKJtM/f+V6+1BCQ9ImUZjbqD1r3iwc+o6V9EW9nlyNF+4N2H8o+7+pucJyQtlPL
         MFFU0HnWmrX+lzvL5Lx6AkKyjDTqj8i1hY8Zl7PTijxP6omw8obdXgknpmaxg0l0h2hX
         adeDfq+Bx6nwwhI7exATh6FiMRSPl1afD2BPD/MDhDI2Q398hmDn6XBLqG2d6Lh+tTsE
         nlmA==
X-Received: by 10.182.72.167 with SMTP id e7mr20546006obv.3.1399490223843;
        Wed, 07 May 2014 12:17:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w4sm69625940oem.8.2014.05.07.12.17.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 12:17:01 -0700 (PDT)
In-Reply-To: <vpqy4ydpiog.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248350>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > It's better if all our scripts use the same '/usr/bin/env python'.
> 
> Why?
> 
> Using python2 for git_multimail.py is a deliberate decision:

If you want to use python2, then use '/usr/bin/env python2'.

> "The git-multimail project itself is currently hosted on GitHub:
> 
>     https://github.com/mhagger/git-multimail
> 
> We use the GitHub issue tracker to keep track of bugs and feature
> requests, and GitHub pull requests to exchange patches (though, if you
> prefer, you can send patches via the Git mailing list with cc to me).
> Please sign off your patches as per the Git project practice."
> )

If you are going to follow practices different than git.git, then
multimail shouldn't live in 'contrib/'. Junio is already thretening to
remove stuff out of contrib even when development behaves as the Git
core does, so it makes more sense for stuff that doesn't.

-- 
Felipe Contreras
