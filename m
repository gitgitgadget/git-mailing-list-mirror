From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Mon, 15 Apr 2013 17:56:58 -0700
Message-ID: <20130416005658.GA3262@elie.Belkin>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
 <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
 <20130411043346.GE14551@sigill.intra.peff.net>
 <CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
 <20130411050509.GC27795@sigill.intra.peff.net>
 <CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
 <CAMP44s3+eaRbeXP0bPXMSE8Z1K_Lqyu8e1XCvudkapkTJFBWnA@mail.gmail.com>
 <7v8v4l7ils.fsf@alter.siamese.dyndns.org>
 <CAMP44s22N9_E4oBG0UztXE0yAkX8TmQaE9-x1_wDHqv3bvZ0EQ@mail.gmail.com>
 <7vobdh54uh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 02:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URuCv-0001Ya-LP
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 02:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934897Ab3DPA5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 20:57:08 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:40208 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934340Ab3DPA5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 20:57:07 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro12so2800732pbb.18
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 17:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JynKwKvqrqGZzKNiLfAdZVz2pDLCjKTyi0ZbRs7q3mE=;
        b=DNxA3kr6SiT/aIUqdm/mL9MJTsQjARFoebgmlpsfiktHz/kRyZxcJYmmdBTVCaM7vC
         d+UdQJzZPgw9BhFARx1eMSwXvrsm+d1CLbRRBEtDpt1Rscu1EnaMXo0GXk09gI8OB9wT
         lBSkUEGosTZ6oN6cZDLRHYv0tdldrKXtOOBAQvIQ3M5ML1FahQNFwW5hQr6Y3uww3KOq
         smkE9iQ9XScvh3nZzAFYELjm1oW2buR9E4r6Op1iUN7LehjzHcdVaJQc8ZF0tXCGMgAu
         AGyn+RFqChMzIDcP6n3JM7X5ZN6hVbXE6wN2M91VrItFSJNTCyXlI2WpKnw0cM2G1sNP
         x20w==
X-Received: by 10.66.20.230 with SMTP id q6mr573806pae.210.1366073826839;
        Mon, 15 Apr 2013 17:57:06 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qr7sm22251300pbc.16.2013.04.15.17.57.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 17:57:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobdh54uh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221339>

Junio C Hamano wrote:

> Just rerolling with what _you_ think is an appropriate level of
> explanation (either or both in log and in-code) and see what happens
> would probably be the best way to proceed, I think, at this
> point. Either you hear "It still is wrong and too sketchy", "Yeah,
> thinking about it again, this is sufficient" from others.  Or a
> silent, which I am inclined to take as much closer to the latter
> after all the discussion.

For future reference, sometimes when I am silent it does not mean
agreement but means "I am fed up and don't consider it to be worth the
drain on my energy to deal with this mess."  Which is pretty close to
"let's move on; this is sufficient", yes.

Thanks,
Jonathan
