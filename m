From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] submodule: use abbreviated sha1 in 'status' output
Date: Sat, 29 Sep 2012 20:15:42 +0530
Message-ID: <CALkWK0kzZvPv9jFBF=ibMzcNt-jxq4RFjy7pL173+Y4_S0jhWA@mail.gmail.com>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
 <1348926195-4788-2-git-send-email-artagnon@gmail.com> <50670655.3030600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 16:46:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THyJk-0002Jp-Je
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 16:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab2I2OqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 10:46:05 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:58129 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab2I2OqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 10:46:03 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so605594qad.19
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=le655zJdS0uf4zO337g+9RyKioVgq4f0dHcvhS5j83I=;
        b=jxBnyKYRNl0UGBEE4N7TxP93ZlYeE+btchyZPgiOVfRzUM9KLuLDGbYdbQ0XLQwLQ8
         YWKspfBIvKLwizhSEyvlFY3lF+CEnT9pqcQfutz7C6NIFP289mPQgW+mCA2p/ztxHKBE
         osTWDm1yxDWVKvgpWXZuDaDcwT9e/sG6NPX/pIOrfYADg2XSuZOYxHSFJrTIQy0n8KnR
         +Sa9LQ5CKaqix/w8rL5U5dnp3nFh32wdh8u9cPwKeWdr5wvqNHV6Co+bmw2at3ll75KE
         0XGMNWGA1KjxrLsGCl/7KAQLZlUPsS3UpAw4JxwCUkFR/dThYNRgpjb2Hg+m4SHEqIyP
         SMrw==
Received: by 10.229.111.70 with SMTP id r6mr6745075qcp.120.1348929962402; Sat,
 29 Sep 2012 07:46:02 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sat, 29 Sep 2012 07:45:42 -0700 (PDT)
In-Reply-To: <50670655.3030600@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206650>

Jens Lehmann wrote:
> I'm not against the change per se, but do we really want to risk breaking
> scripts which parse the output of "git submodule status" without even
> providing a commit message explaining why we did that?

Oh, I didn't realize that there might be such scripts.  What
justification do I give in the commit message apart from
prettification?

Ram
