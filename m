From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 21:31:42 -0700
Message-ID: <20130419043142.GA5055@elie.Belkin>
References: <20130417201056.GA2914@sigill.intra.peff.net>
 <7va9owd3d1.fsf@alter.siamese.dyndns.org>
 <20130418172714.GA24690@sigill.intra.peff.net>
 <7vd2tr6833.fsf@alter.siamese.dyndns.org>
 <20130418180017.GA5714@sigill.intra.peff.net>
 <7v61zj66wu.fsf@alter.siamese.dyndns.org>
 <20130418203035.GB24690@sigill.intra.peff.net>
 <7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
 <20130418214427.GA10119@sigill.intra.peff.net>
 <7vobdb4hii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 06:31:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT2zO-000761-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 06:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088Ab3DSEby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 00:31:54 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:52505 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3DSEbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 00:31:53 -0400
Received: by mail-da0-f48.google.com with SMTP id f10so120619dak.35
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 21:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QAa3uvEQAHmGDg6HHKtThriajFzjEBUJhtrDZMIKxDY=;
        b=XTonpN25WzyfAjIwYry6N4xLC8GDzyizgsglDBmLinaIR3ywtYrTJkwHxFwXARB7a4
         P6nKRAOAR9eoDlJUsXbPUIC+++wz9UXOBnZBBrpv+ACamDVxof7gXWT32C9cqmd5cw4/
         IioKqZ0fywt8UkhI6Q4wEBh04uaEUzy+zteWgZO0ssET6iwakE+5xqRWRzwNYnIVH+JP
         VH9h9Fk3LYHofbGBpTLv/OzcTb7ARz5JeTtme6jLfGVNhryk3EJM5hbNu7ZLfcxCwsd1
         h9VpAp1hd+Ux5/M9WtMnIPjHaZWem8IUi1jfcUiY3bugYU/cmFzccEVB97cF793vU2mi
         YIFA==
X-Received: by 10.68.35.166 with SMTP id i6mr16518835pbj.221.1366345913257;
        Thu, 18 Apr 2013 21:31:53 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ak5sm13221421pac.4.2013.04.18.21.31.50
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 21:31:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobdb4hii.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221727>

Junio C Hamano wrote:

>     You ran 'git add' with neither '-A (--all)' or '--no-all', whose
>     behaviour will change in Git 2.0 with respect to paths you
>     removed from your working tree.
>
>     * 'git add --no-all <pathspec>', which is the current default,
>       ignores paths you removed from your working tree.
>
>     * 'git add --all <pathspec>' will let you also record the
>       removals.
>
>     The removed paths (e.g. '%s') are ignored with this version of Git.
>     Run 'git status' to remind yourself what paths you have removed
>     from your working tree.
>
> or something?

That looks good. :)
