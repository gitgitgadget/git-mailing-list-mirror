From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] custom log formats for "diff --submodule=log"
Date: Sun, 11 Nov 2012 16:56:12 +0530
Message-ID: <CALkWK0mYs7Q1256gY7ZH3Ng3xbYv2+XVHCZ7XYWgWUp2O-VzqQ@mail.gmail.com>
References: <20121108202940.GA7982@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXVgh-00050b-79
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 12:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab2KKL0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 06:26:36 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49860 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab2KKL0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 06:26:35 -0500
Received: by mail-wi0-f172.google.com with SMTP id hm6so1701670wib.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 03:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CHFrZZN24GoUJOKYvGKjlPPxX0W1WfR6mswhk6EUdeU=;
        b=dBly7xRdtbuRD5QoQSgsiz4QEJa4OCUnp0TFtWwJfmSPb+q/hOKY1gu2pyJT8BaNbz
         LOJ70gxTAk7GemUvajPMgyuo6qWQg5qf0vbJOJVg2ORdZvchNgUXGpDVSzyfC6mn6M8c
         NHqA9KKzFa77knu9eLKfoiJFfTNO2JflJvYIr6U4n+X7O7SMUH+E530qNOAzSyto0g0v
         5gnGaDhL+OywqWTPnBBwgrwt/40dFJQO/M95NZ4MHnd5Me0tKoU/u7j4YuFP1HJ0X7/A
         Goz3XGmY4v2K7KsJywCY+3oWVS1EcuWdLoGBXBFVC9sG/dQ+mACynFKj+pyeLW94sS8a
         aWrA==
Received: by 10.180.84.41 with SMTP id v9mr10466314wiy.8.1352633194163; Sun,
 11 Nov 2012 03:26:34 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 03:26:12 -0800 (PST)
In-Reply-To: <20121108202940.GA7982@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209339>

Hi Peff,

Jeff King wrote:
> An off-list discussion made me wonder if something like this would be
> useful:
>
>   git log -p --submodule=log:'  %m %an <%ae>: %s'
>
> where the format could be whatever you find useful.

Interesting.  Don't you mean `git diff` in place of `git log -p`
though?  I don't think `git log --submodule` does anything differently
from `git log`.  Should this respect format.pretty?  Does it?

Ram
