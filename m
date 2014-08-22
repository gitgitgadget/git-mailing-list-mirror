From: Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 16:27:11 +0000
Message-ID: <20140822162711.GA8598@debian>
References: <20140822151911.GA8531@debian>
 <20140822154445.GA19135@peff.net>
 <xmqqr408plgj.fsf@gitster.dls.corp.google.com>
 <20140822160334.GA20789@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:27:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKrgP-0001Qo-M2
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 18:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbaHVQ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 12:27:17 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:57509 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbaHVQ1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 12:27:17 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so16130135pdb.41
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 09:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Wcdxb7FXZjNExhQcTwKemoHbBOvKHIXNfi2WmbWyC6M=;
        b=QhrrmztwDCZNjNptf8YELzJfCQfULHAWr2t5bZcMBuadIBZXicn3MtlbqOo97aPSu8
         P6bBjVdKwO54LFh3Z4NL55Dmk6iwUukM7gJGnLCt9VOLwp5JQT5wDrz2lDNVhcG48nUx
         Lv+/6Di0kgRK6RTVWdALSa0NH4GSESzWugx2cK0vK6UXE9oo9boTAOJ23rLL5XSC/IHo
         ahK9oBrg01unPAq3B9fq08MIMOIHuieNIAuEfiNhwePXqQprhT3j5OPZR+rQUgD0SzjS
         YFHM3wuGRScO8eSCJvglOc7gyOSQ/Oa/3bxsKff0l1F0DL01IgRkwWgKWfRQY86WCNVG
         acWw==
X-Gm-Message-State: ALoCoQkO7JJFV6KNJRONre9YsUOCJsOX7nY16eKGpeXnE1F5h/FKD9xfgXLwpURbTXamzI0vEoBv
X-Received: by 10.68.57.144 with SMTP id i16mr7922035pbq.48.1408724836794;
        Fri, 22 Aug 2014 09:27:16 -0700 (PDT)
Received: from debian ([2600:3c01::f03c:91ff:fe73:b980])
        by mx.google.com with ESMTPSA id hf4sm4831881pbc.76.2014.08.22.09.27.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Aug 2014 09:27:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140822160334.GA20789@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255684>

On Fri, Aug 22, 2014 at 12:03:34PM -0400, Jeff King wrote:
> 
> Yeah, I wasn't thinking we would get negative values from the user (we
> don't document them at all), but we should probably do something
> sensible. Let's just leave it at Ed's patch.

Thanks, both.  Apologies for the dumb question: is there anything
additional that I need to do (repost with your Acked-by, for example)
or is this adequate as-is?

Thanks-
-ed
