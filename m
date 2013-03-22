From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Fri, 22 Mar 2013 14:14:15 -0700
Message-ID: <20130322211415.GI12223@google.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-4-git-send-email-artagnon@gmail.com>
 <20130322144454.GA3083@sigill.intra.peff.net>
 <7vmwtv8p1c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:14:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9IY-0006db-94
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423144Ab3CVVOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:14:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44063 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423169Ab3CVVOV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:14:21 -0400
Received: by mail-pa0-f43.google.com with SMTP id rl6so58444pac.16
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yVP54n4Z6cfUUkXQDal3gL2jiDSsZyjx2efMtUeeiGM=;
        b=pnltnvZKE6FhLzBZwOTw1euhzsPfZFjPXbQ+8Bq79/QPkTHHL1PRTeAxtsECSDkQmB
         keq7XJTsM6z53m74YLnHAKce9j9/IM0fYUgKs7pMhaY9Nq3ing7mAr228ePg22MuLxwY
         Bgrlx08n0YSkLHrz8JeAT0jHczqzv5QX61srp3bJYT0naGndsKQM0JD1xA57eOUnnl/W
         v9XR8vM4peiyH+BvXk9NAGafblXTT6HLr3D63P2geiQsH1OtBwiFyJgi7TOKDJnwcsSv
         q/fsV6QeV/rEZFk106eX9xSNabCrwOBRXc/iomOp1yUIsaLoJUN+xk4KWYOIWfdyj/l2
         L1jA==
X-Received: by 10.66.13.35 with SMTP id e3mr5513124pac.186.1363986860646;
        Fri, 22 Mar 2013 14:14:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id 4sm3600414pbn.23.2013.03.22.14.14.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 14:14:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmwtv8p1c.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218847>

Junio C Hamano wrote:

> I would prefer to see a preparatory patch to teach mk_test/mk_empty
> to _always_ take the new name (i.e. the result of your patch) and
> then do whatever new things on top.

Yes, that sounds like a good way to go.

> By the way, I am planning to _not_ look at new stuff today. I'd
> rather see known recent regressions addressed (and unknown ones
> discovered and squashed) before we move forward, and I would
> appreciate if regular contributors did the same.

I've been flushing out my thoughts to avoid forgetting them. ;-)
Agreed, though.  Thanks.
