From: "Tom Clarke" <tom@u2i.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Thu, 30 Aug 2007 21:36:14 +0200
Message-ID: <550f9510708301236y65a9952dofbd69417dc1310ee@mail.gmail.com>
References: <11885023904126-git-send-email-tom@u2i.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tom Clarke" <tom@u2i.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 21:36:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQpoT-0006rU-IN
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 21:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760304AbXH3TgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760170AbXH3TgQ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 15:36:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:15631 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759944AbXH3TgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 15:36:15 -0400
Received: by wr-out-0506.google.com with SMTP id 36so491458wra
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 12:36:15 -0700 (PDT)
Received: by 10.90.95.11 with SMTP id s11mr1089298agb.1188502574667;
        Thu, 30 Aug 2007 12:36:14 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Thu, 30 Aug 2007 12:36:14 -0700 (PDT)
In-Reply-To: <11885023904126-git-send-email-tom@u2i.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57059>

On 8/30/07, Tom Clarke <tom@u2i.com> wrote:
> +               ( git log --pretty=format:"%s" ) >actual &&
> +       (
> +               echo "onbranch"
> +               echo "update"
> +               echo -n "initial"
> +       ) >expected &&
> +       git diff -w -u expected actual

One issue that I'm curious about. Is it expected that the git log
format above doesn't finish with a new line? I couldn't get this test
to work otherwise.

-Tom
