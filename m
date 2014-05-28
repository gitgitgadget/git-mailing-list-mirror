From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Wed, 28 May 2014 14:56:18 +0900
Message-ID: <CAN7MxmU3gcpbdS-Xx3AE=ftUMeJfRvcCfO7Qs=a2W0jgORdx9g@mail.gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
	<1401118436-66090-2-git-send-email-modocache@gmail.com>
	<CAPig+cRE0LUaNLTJARBCmoDn7cR1bbgi8At0ChgSDWBjDPaNjg@mail.gmail.com>
	<CAN7MxmXVDTiQv5J9cU2E8iS=BNROw3q9NVaBuG7aQP-7=Qo_ZQ@mail.gmail.com>
	<CAPig+cTmyBzroDOnqEb_GWqhcbgbK27pT3=3VCVOnj13=C4CfA@mail.gmail.com>
	<20140528051411.GA3095@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 28 07:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpWqd-0000p2-26
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 07:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaE1F4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 01:56:19 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64907 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbaE1F4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 01:56:18 -0400
Received: by mail-ie0-f180.google.com with SMTP id tp5so9909666ieb.11
        for <git@vger.kernel.org>; Tue, 27 May 2014 22:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Vw0FMBFAAXm0BQrP/gQLLG9eAtTjnl8Yn7sDKcxMzLM=;
        b=LTdKow6yWvTsI7kykDFMjyUYfwDmMJhPcE9c8015rio0mu1O6bXozchYiljpFNemDF
         050Lv1LkbFKmN+SjuYou8b6fQFPILl+syjRGcmPoZSlZ2QVq7dRE5iaew0FS2q5OjJdQ
         tykks+1LqnSs4Pdj0QdZsFT/FkinI0Wnnjh17rBrHJF+P43/dAEOtwyDF70kG3bxtbkc
         nqc5guIjWh3Wub5d6soGAX52I1dukEKE3yOjLJ6QLTnGK0IES/4ScVAD1GiIMSf5ezYw
         gXOcBCIN2K5tRJ1SskJ7hZLQU9Os7dFWPUKXDdJQ0ohNclYRiZJJkwqdnWk+Pg80Pv9n
         3AKA==
X-Received: by 10.42.233.12 with SMTP id jw12mr9661213icb.12.1401256578363;
 Tue, 27 May 2014 22:56:18 -0700 (PDT)
Received: by 10.64.55.165 with HTTP; Tue, 27 May 2014 22:56:18 -0700 (PDT)
In-Reply-To: <20140528051411.GA3095@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250261>

On Wed, May 28, 2014 at 7:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I do not think it is worth doing this change starting from maint, so
> I've dropped this one and a few others that did not apply to master
> and queued the remainder to 'pu'.

Thank you! I'll keep this in mind when choosing what to branch off of
in the future.

On Wed, May 28, 2014 at 6:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Etiquette on this list is to avoid top-posting [1].
> ...
> If you do re-roll, perhaps consider simplifying the commit messages.

Thank you for the tips; very much appreciated.

- Brian Gesiak
