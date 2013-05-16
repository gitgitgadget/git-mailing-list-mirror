From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 13:55:24 +0530
Message-ID: <CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com> <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctVr-0007Kn-9c
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab3EPI0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:26:07 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44687 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256Ab3EPI0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:26:05 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so5867823iej.30
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3vY1NZKVS6H46er/Evef+49J4dfKv95rVY9BqKAtZ50=;
        b=MtbsNb5Fmn1tD3sek+lcXN5okIq22bMoW9I5zFGlIXp/jCIQ0000yznmgV+CCtedr9
         1UJmzbm7UowJSk2Y+VOzj+V5l3R3kVNgS4oZpUSWownwGdDToxEZf7f/9yu7KFYet1zc
         d31SdDd7Zb22J0kEFbO6Onrcg7BUfdLwqSZva8FTx/8aKAA5SNfmWmOAaGT+nfmA+CdN
         g5BltNSgGBwAf3ftf8vZhUzTRrJMoeAkxyDq/ML8Q2+Mr6sZwvX7APgIqEat2fw7b6AN
         5NPfeR1TQYeMOOvB5CwgX3O92cPfHcsnMa4LVmFwLFbk6W7ZKwYk48qtI8yT/uLj+3YH
         aS9A==
X-Received: by 10.50.33.19 with SMTP id n19mr8395142igi.44.1368692764466; Thu,
 16 May 2013 01:26:04 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 01:25:24 -0700 (PDT)
In-Reply-To: <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224499>

Felipe Contreras wrote:
> So that it becomes possible to override the behavior when the remote
> tracked is '.'; if it is, we default back to 'origin'.

What is the problem you're trying to solve?  Why do you have
branch.<name>.remote set to '.' in the first place, if you meant
origin?  'git fetch .' currently just updates FETCH_HEAD; while I'm
not sure how that is useful, I still don't understand _why_ you want
to change that behavior.
