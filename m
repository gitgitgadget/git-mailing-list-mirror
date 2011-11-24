From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Revisiting metadata storage
Date: Wed, 23 Nov 2011 19:10:23 -0600
Message-ID: <20111124011022.GA14842@elie.hsd1.il.comcast.net>
References: <CAD77+gQB+0zJG62jrtPn_MwLLR7zgH=5gBtkvPxrKgiLPZsbsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Joey Hess <joey@kitenet.net>,
	David Barr <davidbarr@google.com>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 02:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTNpm-0004Q7-FZ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 02:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab1KXBKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 20:10:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59481 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab1KXBKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 20:10:32 -0500
Received: by yenq3 with SMTP id q3so2025577yen.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 17:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i+L27mnoVWaVKsYSvet8HAFfCvfgdJ0BeKzbPRo8q2I=;
        b=lbIJZxkqP2CKAELsairq0juGSkziEc0DfGjyVGG/zDLislABbSM8w6v1Byj1fKMxqz
         rEQyEKFucXB62tkl4wTcZNn6QQAl7VLpcCAJfeNNmthVA7iYEOQzPkD3Fv7Zlon89Zjf
         bGVXANaj3zzAFLlFm6rc9fCaW3xfnIxDHRS9o=
Received: by 10.236.190.40 with SMTP id d28mr38823232yhn.92.1322097032291;
        Wed, 23 Nov 2011 17:10:32 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c10sm27938468yhj.2.2011.11.23.17.10.31
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 17:10:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAD77+gQB+0zJG62jrtPn_MwLLR7zgH=5gBtkvPxrKgiLPZsbsw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185886>

Richard Hartmann wrote:

> To make a long story short: Does anyone have a working solution,
> today?

Sure.  etckeeper handles metadata such as owner and permissions
reasonably well.
