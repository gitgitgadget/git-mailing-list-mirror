From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Letting remote repositories override local configuration
Date: Mon, 19 Mar 2012 04:35:05 -0500
Message-ID: <20120319093505.GA10017@burratino>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1203190945560.15290@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:35:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Z03-00069p-SM
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 10:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806Ab2CSJfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 05:35:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32843 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964982Ab2CSJfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 05:35:22 -0400
Received: by iagz16 with SMTP id z16so9209569iag.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8hq1zbSy57lI4gfiaC9eI32WjDCpzbHVLWcz7uezpQY=;
        b=xiPjaBWibQlD5Cyy4R0aG0HKuNaoeb3DOC+fHTQRqRIOL+pFR6QO3q9YnR81l+oi7x
         NlmJ8tjG1OGAEsSiE9blrOmoe1ITaSOM8iDSPeyxnPwbnjFjcQipMMzxYPEw86DpibmC
         EvNBI+o2Stb20RU9WOjwcaivXG/74trgUxKoCurfbFrdgbMIrBMOW08tnfguDnl5XYOe
         l5cxjaLV8amsmP5bPT1JAIGcUNghcY/UpNz5KkI/X7fsRASI+KjcjfOJyTMkXAVQUAYe
         tqyDy1CtOq2ZbzkM6kYgCVPPG/DtPFxhaxrNIFpeQrZxDgAuR1BVawybzggZJxEAFKco
         aKiw==
Received: by 10.50.192.134 with SMTP id hg6mr5508932igc.59.1332149722469;
        Mon, 19 Mar 2012 02:35:22 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vr4sm15793502igb.1.2012.03.19.02.35.21
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 02:35:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1203190945560.15290@ds9.cixit.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193419>

Peter Krefting wrote:

> I know the policy in Git is to not allow the remote repository
> dictate anything about the configuration in the local repository,
> but as an alternative to changing the "push.default" value, perhaps
> we should allow setting some configuration option on the remote
> repository that blocks it from being the target of a "push.default =
> matching" push?

If I work for your company and always keep all my local topic branches
in good order, I would expect to be permitted to use "push.default =
matching" to easily push them all at once after I have finished
preparing them, provided I have set up my local copy of git that way
explicitly, regardless of what the person setting up the
infrastructure thought.

What would I be missing?

Curious,
Jonathan
