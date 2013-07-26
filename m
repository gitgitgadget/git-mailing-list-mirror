From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 14:37:05 -0700
Message-ID: <20130726213705.GJ14690@google.com>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net>
 <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:37:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2phQ-0007Wt-Dd
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760690Ab3GZVhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 17:37:13 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:64007 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759987Ab3GZVhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 17:37:09 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so1816480pbc.26
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MV99CmTBb13AHl8ZslFOwJi3U5rQv8OHHyZ4RqwN6pM=;
        b=K10gviFW+dhvIeFbNjos2FPiDAvJbOsv7rk8I6OEDLyMeuAqA1XialWKw3DfBlCwjR
         USP9So8GE76TS73Kl9WHKN9cr2BH+h/VyH+z4XAaZwGfOMJlcIQ9lByoRFjIU++38+mi
         6c+DehQ2jismZUOpTRnYgMACGHF8YUDW8HOUXM9BLynHIvsrfkf82B52cqYBrK0eUBEL
         NvOqudOj3bpy9rW8Ya6Mx6iqUcytIwmZsajCIlMTSwZBZzD4vRsDjZM/dRX9hqc7Vgkl
         5ge052BuI3iWcyvX02M8rb6QmHb/6FGSRqsOcd021Czk9mCe66KUHF7u9CGr5NPAgZK3
         tH9Q==
X-Received: by 10.68.244.73 with SMTP id xe9mr55579103pbc.119.1374874629124;
        Fri, 26 Jul 2013 14:37:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wf7sm5595130pac.20.2013.07.26.14.37.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 14:37:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130726212438.GA1388@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231207>

Jeff King wrote:

> Your patch is just swapping out "git reset" for "cherry-pick --abort",
> so I think that is a good improvement in the meantime.

Um, wasn't the idea of the original message that you can run "git
reset" and then "git cherry-pick --continue"?

Confused,
Jonathan
