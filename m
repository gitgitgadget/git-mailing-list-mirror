From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH 8/5] srv: tolerate broken DNS replies
Date: Thu, 8 Mar 2012 23:28:21 +0100
Message-ID: <CAD77+gT_1O2kjvob9Csa2C6vZZYyGrssrdBz8PxNU00wO+6UDQ@mail.gmail.com>
References: <20120308124857.GA7666@burratino> <20120308132339.GH9426@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 23:28:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5lpI-0007F8-6y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 23:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758871Ab2CHW2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 17:28:43 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65017 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758752Ab2CHW2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 17:28:42 -0500
Received: by wgbdr13 with SMTP id dr13so996890wgb.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 14:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=13yM2sRIklkp2oFPz48UUszITMY/OOZnExyESzC4cpA=;
        b=WCUZ16LEsqYkWDzEpay8hoeYDcTHtdKXmLXaiBV6aytAsSDmmfD5L/rP+lKHFD8sEY
         NDs5sIIoG6WEi5pVDf7eYVonpMJbkRM9rBD0AwOkDvLkw7NO5J3n/SxzY37U6DyXb6ni
         UbYTBMyxgxsdjk1/RLjrRrhr7LYqH8uh6JS7ybtNZosQ1l5HiYPo9aKsk76+qS5Xj/q9
         6dVl5w3XX2AMbSSy5ZSk3GszZYQjXC3x+bKghqhcfwgyMuXLx8faiSAIhow4OKKeVM3E
         ktIRDiMBR9IogzI2lE/gHy7FTUIJ98dS1exc2Uqq0QEKeBXG+2dBLBUMinsdfgobrLbV
         8pPg==
Received: by 10.216.137.97 with SMTP id x75mr4385202wei.25.1331245721409; Thu,
 08 Mar 2012 14:28:41 -0800 (PST)
Received: by 10.216.173.21 with HTTP; Thu, 8 Mar 2012 14:28:21 -0800 (PST)
In-Reply-To: <20120308132339.GH9426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192660>

On Thu, Mar 8, 2012 at 14:23, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Other programs gave some warnings but otherwise worked fine.

Just ftr, Chrome/Chromium ignores this quickly and loads pages while
Konqueror takes ages to get around this. Not related to git, but maybe
an interesting data point in the future. If not, disregard.


Thanks for hunting and killing this one.


Richard
