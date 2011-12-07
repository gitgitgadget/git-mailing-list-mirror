From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] Re-roll rr/revert-cherry-pick
Date: Wed, 7 Dec 2011 02:28:22 -0600
Message-ID: <20111207082822.GH11737@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <20111207081734.GG11737@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:28:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCrg-0005On-0W
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab1LGI21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 03:28:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40967 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1LGI21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 03:28:27 -0500
Received: by iakc1 with SMTP id c1so577639iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 00:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fiB1eKPAtX6kR5+rcDoUAcO78qNeQS3APWCeO7R1i5c=;
        b=wDR6zwvO24kT8BmmBNR2xR8gob+sMXh9SB4DpIF+VVlEB6+XDZ5owdTY+boO8PXGMD
         HfjC3qTBTDhjNsK7zrXYMasPv0Bqa0o3419Y0l4OMKaSfa362wL3d8YkJnl+c7GvAnDT
         eM43vVoj2PxYDxnashl7A2ftKApaVxgd325rg=
Received: by 10.42.153.5 with SMTP id k5mr17527022icw.46.1323246506809;
        Wed, 07 Dec 2011 00:28:26 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id jm11sm4166851ibb.1.2011.12.07.00.28.26
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 00:28:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111207081734.GG11737@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186446>

Jonathan Nieder wrote:

> Fine.  But I would like to know which case they fell into, so I can
> learn in order to do a better job reviewing the future and know my
                                             ^in
> time is well spent.

Sorry for the nonsense. :)  And now that I look back over previous
revisions of the patches, I see that I _hadn't_ clearly complained
about the same aspects of these particular commit messages before.
So what am I talking about here?

I guess it is just a pattern: commit messages I have looked at in the
sequencer series lately seem to focus too much on implementation
details and not enough on the "big picture" of what the user or
internal API user will experience.  One symptom is that I get lost in
reading the commit message without looking at the patch.  Another
symptom is that the commit messages tend to mention the particular
(private) functions that were changed, instead of the more prominent
(often public) callers that the reader might have cause to call.

Hoping that clarifies a little,
Jonathan
