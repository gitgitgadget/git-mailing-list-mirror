From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 18/18] revert: Introduce --continue to continue the
 operation
Date: Wed, 27 Jul 2011 07:22:11 +0200
Message-ID: <20110727052211.GM18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-19-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 07:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlwZf-0007p2-4L
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 07:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab1G0FWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 01:22:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34883 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1G0FWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 01:22:22 -0400
Received: by ewy4 with SMTP id 4so1046998ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=10pqeqUQVocsD+LELU0PU5uDb4pxypJCMN7fooHt44Q=;
        b=uZdbWLkv2BSgNDtGBwXsfP9egooHTephvIMs/j4r7mbVv4eooYa56yoWaVlgvdgO9M
         LU2RIWa1P7lrPwmHbjcxz8wpf8K2CtlERfBe/lOIj1RhQZMO60rztpoDnRT4b+ccsx4a
         y1OUSUpldOPxajdmwwgW6bvBvSi3x8Y7KuF30=
Received: by 10.213.8.135 with SMTP id h7mr1315291ebh.108.1311744141286;
        Tue, 26 Jul 2011 22:22:21 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id h15sm834666eea.28.2011.07.26.22.22.19
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 22:22:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-19-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177935>

Ramkumar Ramachandra wrote:

> during commit time.  One glitch to note is that the "--signoff" option
> specified at cherry-pick invocation time is not reflected in the
> commit message provided by CHERRY_PICK_HEAD; the user must take care
> to add "--signoff" during the "git commit" invocation.

Does this reflect the previous discussion of whether this is a glitch
or an intentional behavior?
