From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v17 1/7] bisect: move argument parsing before state modification.
Date: Thu, 8 Sep 2011 11:23:25 +1000
Message-ID: <CAH3AnrpNSNsz77kBsGQxprXh3bdNUzrWyFwtq_up0hetwikhMA@mail.gmail.com>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
	<1312459263-16911-2-git-send-email-jon.seymour@gmail.com>
	<201109070816.16655.chriscool@tuxfamily.org>
	<4E67B2F2.9070806@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	gitster@pobox.com, jnareb@gmail.com, jrnieder@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 03:23:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1TL2-0005oV-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 03:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762Ab1IHBX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 21:23:27 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:41136 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757722Ab1IHBX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 21:23:26 -0400
Received: by vws10 with SMTP id 10so395103vws.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jq+qAYQ8kNfBJgmKPSxgAxgNtHAYayY6p5mx55aQJro=;
        b=p2IHrAx5d8DIpxxr6J2ohgZxAEATgTSOkVMGK+kO8ObyOdT43EA13RMfgKpNUICBq9
         4bLS6GGdsI8Gic8dN5xRnExUYqlOJH/zf3JwNREAuu68blH1bNzITi4y9LF5qYOcqJmv
         6UvQlS9m5ZsenT0OUfeqEopFpNQZ7+GEcbARg=
Received: by 10.52.75.230 with SMTP id f6mr75782vdw.276.1315445005363; Wed, 07
 Sep 2011 18:23:25 -0700 (PDT)
Received: by 10.52.106.137 with HTTP; Wed, 7 Sep 2011 18:23:25 -0700 (PDT)
In-Reply-To: <4E67B2F2.9070806@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180931>

On Thu, Sep 8, 2011 at 4:07 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 07.09.2011 08:16, schrieb Christian Couder:

> IOW, I think the new behavior is *much* better than the old behavior.
>

There is perhaps no surprise that I agree with Hannes. Certainly, it
seemed saner to me to do argument validation before state update. [
Also, the earlier iterations of the --no-checkout series needed the
new behaviour. Not sure if that is still true, but I suspect it is ].

jon.
