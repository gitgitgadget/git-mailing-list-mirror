From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Mon, 16 Apr 2012 11:08:50 -0500
Message-ID: <20120416160850.GN5813@burratino>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
 <20120413211350.GD7919@sigill.intra.peff.net>
 <20120413215316.GA19826@burratino>
 <7vy5pz1cjk.fsf@alter.siamese.dyndns.org>
 <4F8C338D.1050805@xiplink.com>
 <20120416150036.GA15009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoUE-0002aF-Dn
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab2DPQI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:08:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41061 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab2DPQI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:08:59 -0400
Received: by yenl12 with SMTP id l12so2544211yen.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=flflh7uAuwXuDL+QgVS4sJ7eddyCzTa285yqXDUOrLg=;
        b=OMIEHHhFwFuJob+aS0dDIsQ54DJsko2X1xU9U4cAfIWJi52oBzi8RC+sJpnsf7Jrhp
         V5auIb8CGHCFWGmLxxkWxQzlKETMi6CH4x/v/dn2IDyTqkccJ8yRlkiNx8EmZ3tl7QXa
         NjZl9NARBHl4HCP+UDyc8fNWJYDBUvZChRseouRYCov8C1Xhe7cg+PEUFKqoCJ41ncnj
         wDEeveVjKRTltk/0Wzr7Idl9lKTqkobN9Zs/5fR6uesxuxlbpAgi3kJaQWCrcGhhV4P3
         +Tn9gsRwqWzvFAnefXl8c7NLCoH91zQLyX+NPkFB9n8qyiTLKCjS1ozZbT11wwYxwjIQ
         Zhxw==
Received: by 10.60.20.38 with SMTP id k6mr17120951oee.26.1334592538342;
        Mon, 16 Apr 2012 09:08:58 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yv3sm19807863obb.3.2012.04.16.09.08.57
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 09:08:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120416150036.GA15009@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195658>

Jeff King wrote:
> On Mon, Apr 16, 2012 at 10:58:21AM -0400, Marc Branchaud wrote:

>> Git is better off describing what's appeared in the remote repo, and not
>> worrying about describing how the user might've mapped those things to local
>> refs.
>
> That's my preference, as well, so it sounds like you, Junio, and I are
> all in agreement.

My preference after reading Junio's message was "[new] ", for what it's worth.
