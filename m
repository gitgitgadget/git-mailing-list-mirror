From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Tue, 17 Nov 2015 17:47:01 -0600
Message-ID: <CAOc6etY9cXm04KdqUdRE11xtG+7Yj3ihkB4-OTweyWyGF8gs0g@mail.gmail.com>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
	<CAOc6etbjCYRp4gbSNRtcngwbh93R67JYZHJn0=D=FeiBm5=FNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:47:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZypyA-0000rQ-Hv
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 00:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbbKQXrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 18:47:03 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34378 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbbKQXrC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 18:47:02 -0500
Received: by padhx2 with SMTP id hx2so23779071pad.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 15:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FyDi0ScojG3TEDMlBto6emPTyy1UAX6Qe/TrAfyQMfM=;
        b=ha0jDGx8zxx/9t8E95N5//vDXAae5ZLX0m67XA/6T/BVi4Elt6PZ88y1JBelbVV3It
         hS3umSFbNhUooXnlTR8uVtt/1W5E4sm/gKHKh6ojVvg3128gRTU5bCbw1A80kALg5RFI
         dJoYjpxKwwMZzxztU8yvKUXtQJsHfLTvSF7CDNpWmJbirrVYj/+VGzw+61cR7pFW+dyH
         UbUHkCheINP0Cj8HNBcxXfzOYLCCqZpO4nqOOSeLxaao9mZINjQ0ZdK/wNVEAK5x/x4U
         EjUM1LnDDBPo7rj0gM9nPGSuVxFEb1QT6Jv4fc4dK5eHqobtccQflJNTzcValLH5stpv
         c9uw==
X-Received: by 10.66.190.66 with SMTP id go2mr66318029pac.114.1447804021738;
 Tue, 17 Nov 2015 15:47:01 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Tue, 17 Nov 2015 15:47:01 -0800 (PST)
In-Reply-To: <CAOc6etbjCYRp4gbSNRtcngwbh93R67JYZHJn0=D=FeiBm5=FNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281432>

On Tue, Nov 17, 2015 at 5:37 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> So, do I forget about the blame patch (given that I'm not fixing an
> advertised syntax, even if it's supported) and fix annotate instead or
> do I fix both? And if I should swing for both, do I create a single
> patch or a chain of two patches, one for each builtin?

Actually, cmd_annotate will call cmd_blame so this patch actually
fixes annotate as well (nice unintended consequence).

So I guess it will be a single patch. Let me work on the tests and
then I'll send a patch that will hopefully cover all raised points.

Cheers!
