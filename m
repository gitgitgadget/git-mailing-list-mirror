From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/8] rebase: prepare to do generic housekeeping
Date: Fri, 10 May 2013 22:09:29 +0530
Message-ID: <CALkWK0=hK4Nj24xEYtfnAmrLsKLz+iJXvM4PKL9NHEJDS35mfQ@mail.gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
 <1368196005-5354-5-git-send-email-artagnon@gmail.com> <7vvc6q3l6t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 18:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaqMm-0008CW-3A
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 18:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab3EJQkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 12:40:12 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35430 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab3EJQkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 12:40:10 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so8619463iee.9
        for <git@vger.kernel.org>; Fri, 10 May 2013 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HR7TMHeR0exfkzeH+GqKX99dnB7L7SC187LIYANgpb4=;
        b=0kowrecLiQkmZ2HRjz7ksUX1Hx68b4wwTcb06bA+rOhC+is3dLYOAsYk+jUSzUmzuL
         Y02bJ8n/ecotAm3UcTnrDtEtRVulirPL27UUrJfyabZzsP/MGq8CCJckWzqdRUe5RSOy
         dDg6IgaOiFskUAlGR7qJZbm/+GvXiWaJ9xN7XrDiPcfq0Z2RW7+M20C+1MNxPJaoPPb0
         NHrM/LZJJEk3Osb1DxQGgEhfW0mq4ESelnJC0o067K4Qmx0I5z2tjozisuIYqJ6fOPYO
         jOwiB1PI/AKpt7EnsUn9eXckwBQQlmE6duQQ6EysGJWY/AuPG4kbWDfCafO5rK+6CyCR
         /R4Q==
X-Received: by 10.42.27.146 with SMTP id j18mr7907314icc.54.1368204010001;
 Fri, 10 May 2013 09:40:10 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 09:39:29 -0700 (PDT)
In-Reply-To: <7vvc6q3l6t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223879>

Junio C Hamano wrote:
> So it is either (1) the added code is unreachable and unexercised at
> this point in the series, or

Yeah, it's (1).

> Perhaps this should come a bit later in the series?

When exactly?  I picked up on your suggestion to separate out the
preparation-for-$backend-to-return step.  The next three patches
convert each of the $backend scripts to return.

> At least the log message should mention that this is adding an
> unreachable cruft at this step, if the order is to be kept.

Okay, I can update the commit message.
