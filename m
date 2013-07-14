From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] templates: Reformat pre-commit hook's message
Date: Sun, 14 Jul 2013 11:42:50 -0700
Message-ID: <20130714184250.GA4381@google.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
 <1373818879-1698-3-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 20:43:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyRGT-0006Vr-Rz
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 20:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab3GNSm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 14:42:59 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60008 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab3GNSm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 14:42:59 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so10397328pab.39
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aSHIoKb6zpnVXPCZ6TBqpKdWTg2ZlnI2Wmzj84nIbkM=;
        b=agcXt7QaP6pOU5qchC7+vcRhA/kibllJ/SBS+/zvqQufMnJA6zjeH7mElA3P1pXSg8
         AeCV1rhxw+doOLUaH1uuvQJdwUkGGVBqXhohzaQdtsw2DRdzIFGnpAHkXubCQ8SKAijF
         Hq+KrPmG3rlKrHc2gXndAfjNyRqQj/pA6kmxzVLJgYAHtN7BKixhMQXrXVrs41ua7qdW
         mppmNxHIKQ7R0WnuENAvPAwOVoJXeLXFKxrTbmEkUXSh+wYYsC5u1z3K4XvTAi6i0PqX
         v1kwAl5CT7pl0+Bfa3YmVHrsbdVBGu9CSiKQlV1hV30U4NojmgBMiu11HDV/Qb23ZlYw
         JpOw==
X-Received: by 10.66.25.10 with SMTP id y10mr51499784paf.96.1373827378583;
        Sun, 14 Jul 2013 11:42:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id re16sm60033328pac.16.2013.07.14.11.42.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 11:42:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373818879-1698-3-git-send-email-richih.mailinglist@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230379>

Richard Hartmann wrote:

> Now that we're using heredoc, the message can span the full 80 chars.

The output is going to a console and not an email, so makes sense. :)

> Verbatim copy of 634709b489bb3db79f59127fd6bf79c5fd9b5ddf in original
> patch series from 2013-06-10.

As in patch 1, please drop this.  I'll stop mentioning that for the
later patches, but the same comment applies there.

Thanks,
Jonathan
