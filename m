From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] git-p4: add config git-p4.pathEncoding
Date: Mon, 14 Sep 2015 11:25:52 -0700
Message-ID: <xmqqfv2gx3gv.fsf@gitster.mtv.corp.google.com>
References: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 14 20:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbYRz-0001th-Fw
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 20:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbbINSZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 14:25:55 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34118 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbINSZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 14:25:54 -0400
Received: by padhy16 with SMTP id hy16so150629178pad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zOSaNXDFuR2LJA8OdaWMBYeRMhpUjibRVd/JEKADkbI=;
        b=xw3poVOvN6aSHwWb7oLKqE+GiAFxhtCFqQHXg+WH1H7DEZ1dDjYoejMyFRRRPn2EHe
         MoVFLqRDW4SL2NmJ6fQKqczJsEQjhdB62D5uj+Q5P+S2AjKDf156Bh+E5D3o+6wyLux9
         aXCdKcpMuLy93jIP6LERzinaM+721MMR5fgHXaALJ0PptFKDHg8iNOMoGSyGXARz7qUK
         GADj8erZDklswHmIkdGpxWVdFwrqvrPbRuIrjG8dThpgOFKHkIhzEEJVoD7Pq7+FQGnl
         Fi3jGwCiLJo5lAEe78jBvme+XWQJrbpZdxLWroL19epK6NMMhcPgpLXuI0Ld3j5+vfcx
         cHsw==
X-Received: by 10.68.227.8 with SMTP id rw8mr37715264pbc.74.1442255153939;
        Mon, 14 Sep 2015 11:25:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id xf6sm17483121pbc.70.2015.09.14.11.25.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 11:25:53 -0700 (PDT)
In-Reply-To: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 14 Sep 2015 19:10:39
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277858>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v6:
> * Always print the encoded path in verbose mode.
>
> v6 is already on next (a9e383). This patch must be applied on next.
> Is this the right way to handle this situation?

Yes, I thought that the reviewers found v6 was solid enough, and it
is now in 'next'.  It is best to do further polishing on the tip of
the topic that is in 'next', i.e. a9e38359 (git-p4: add config
git-p4.pathEncoding, 2015-09-03).

Labeling the patch as v7 is misleading, but from the context (like
your cover letter description) it was clear that the patch is a
follow-up, so everything looks good from procedural point of view.

Thanks for making reviewer's life easier.
