From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 7 Oct 2011 14:50:23 -0500
Message-ID: <20111007195023.GA29712@elie.hsd1.il.comcast.net>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
 <4E8EBDA7.2040007@drmicha.warpmail.net>
 <20111007091636.GA22822@elie.hsd1.il.comcast.net>
 <4E8ECA25.205@drmicha.warpmail.net>
 <20111007100646.GA23193@elie.hsd1.il.comcast.net>
 <4E8EED39.1060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCGRN-0007Jb-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 21:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab1JGTuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 15:50:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36258 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab1JGTug (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 15:50:36 -0400
Received: by ywb5 with SMTP id 5so3956223ywb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y3WiQHouduwTZekLshkLCH8KDr9HgOrIbxqHlX/sQZ0=;
        b=hSLY/dt79C2e7jlfKvFpVPhQC3OWR7a90rjrasuKXQyc7cvkVwHXLC8Rb5WRbRAOZY
         lrUNZ9mme74XY0v9BMsPtCo+Kg0lCgqAvc+dWvtkrZFTGwcM/g0uWCkWInSkq2iePKWe
         5zAfKFpb9bxqTp1J3Ea/3CWUE0Pg2437wJxrA=
Received: by 10.100.129.7 with SMTP id b7mr1821185and.152.1318017036187;
        Fri, 07 Oct 2011 12:50:36 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j13sm27390831ani.19.2011.10.07.12.50.33
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 12:50:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8EED39.1060607@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183101>

Michael J Gruber wrote:
> Jonathan Nieder venit, vidit, dixit 07.10.2011 12:06:

>> [1] http://thread.gmane.org/gmane.comp.version-control.git/181953/focus=182000
>
> Funny to point me at a thread I participated in, when I'm saying this
> thread should have continued there ;)

Ah, sorry, I wasn't trying to initiate a debate.  I provided the
pointer to save time for others who haven't looked up the thread
you were referring to yet.

I am surprised that you seem to have missed what I meant by "branch
names are local".  I meant that what I call "master" is likely to be
very different from what you call "master".  Yes, we share commits and
fetch them from each other, and I might even _decide_ that what I call
"master" will be similar to what you call "master".  Luckily, in
practice people don't seem to feel constrained to decide so, and there
are many workflows where my "master" is not your "master" and does not
even contain commits that would be acceptable for your "master".

This matters, a lot, because there is no easy way to partition a
namespace of names descriptive for humans without a central authority
to negotiate conflicts.
