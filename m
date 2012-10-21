From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 5/6] tests: add remote-hg tests
Date: Sun, 21 Oct 2012 14:02:02 -0700
Message-ID: <CAGdFq_hhjvysViU+rceOcX7L48BkxUbDzKiyT7LakFqz1ikT8A@mail.gmail.com>
References: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com> <1350841744-21564-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:03:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ2fi-0007Mn-Oe
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab2JUVCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:02:46 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:48038 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab2JUVCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 17:02:43 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so906410qaa.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SaFyAnbrnFt4j5uDraBKaLaukxCUNLpGYkTT8+Z5PV4=;
        b=P4m6w5E0kYVYhXGl9uZB3/LFA1+2rCDvWyf/rsQP8pa72mq9N2tGyh1Ijr/dI9v1qg
         nAMI8r1Bb3P4WkpKe2gn82B2AKmGi6TB7iD/hrCPWsJFEzXGcPT6Z2aOxNNsrd9uNuON
         eg0QPfCHdpJVS9VcuddSAHBMAcwP0x67lwYa2fZ/FLBSsul6wfH19WCjijLQzYsRBLeC
         CU7cUV2k9a8c7tdJZQRpvKDa0OCktWNTMNuGHDkX6OphTSv2auKxzGqVLm1Nd3iS5ZGu
         2GVpDDvEhqjwHk0f3+WlAU+hJOYRlccE4gyN14WynE+zxiSTtQzUj8EFOZfItCIpQlu0
         B2iA==
Received: by 10.224.208.68 with SMTP id gb4mr2101993qab.99.1350853362275; Sun,
 21 Oct 2012 14:02:42 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Sun, 21 Oct 2012 14:02:02 -0700 (PDT)
In-Reply-To: <1350841744-21564-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208149>

On Sun, Oct 21, 2012 at 10:49 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> From the original remote-hg.
>
> You need git-remote-hg already in your path to run them.
>
> I'm not proposing to include this patch like this, but should make it easier to
> test.

You should also have a look at the tests that were marked as "expected
to fail", since they point out a bug with fast-export. I'd sent a
series to fix that, but didn't follow-up to get it merged:

http://thread.gmane.org/gmane.comp.version-control.git/184874

It'd be great if you want to pick this up (like you did with the tests).

-- 
Cheers,

Sverre Rabbelier
