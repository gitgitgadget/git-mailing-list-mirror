From: Tom Werner <mojombo@gmail.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Tue, 25 Aug 2009 10:43:57 -0700
Message-ID: <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tom Preston-Werner <tom@mojombo.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg03y-0002hl-0h
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 19:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbZHYRn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 13:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbZHYRn4
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 13:43:56 -0400
Received: from mail-px0-f182.google.com ([209.85.216.182]:50713 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbZHYRn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 13:43:56 -0400
Received: by pxi12 with SMTP id 12so3597631pxi.22
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s88kMkiwma2oiOF5AQXvd3mdjrP0+nAhy3JhGKvVWHI=;
        b=H/k/8zYDwrnES9ssP55KR1M9EvajeMY2iWa+OSfIkqw28tfLDG0L1WnW+QkaYKFbAM
         s09Ey8SbeYskkzyeoU2Kpf+TjD4oaNnxNqoDi1YgRecehiKhEfF0sIDs5wSYgKe5ujCd
         Cw6PCcyM0JW3gHnJUg4fh/LvghAzilQryTGD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L/v/U95FFYAtvx55lsTmTVYYCQ++wfcB36LMjlH/VWbzAvD10YivbHetyNNC9lqicX
         AWU9GwqZNLWi/vwA5+YA5520xfGlNL2RJboKTQS6vXg1xVoigp1zJKhQIyQ3ldS63ffQ
         IyTP8SjH5jXK5wFvBijwAXOwlsXI2VITojsA8=
Received: by 10.142.119.10 with SMTP id r10mr480593wfc.13.1251222237855; Tue, 
	25 Aug 2009 10:43:57 -0700 (PDT)
In-Reply-To: <1250579093-40706-1-git-send-email-tom@mojombo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127033>

On Tue, Aug 18, 2009 at 12:04 AM, Tom Preston-Werner<tom@mojombo.com> wrote:
> A post-upload-pack hook is desirable for Git hosts that need to
> collect statistics on how many clones and/or fetches are made
> on each repository.
>
> The hook is called with either "clone" or "fetch" as the only
> argument, depending on whether a full pack file was sent to the
> client or not.

I was hoping to get some feedback on this patch, either positive or
negative. Since we'll be applying this patch for our use of the Git
Daemon on GitHub, it would be great to see it in core, so we don't
have to maintain custom debian builds forever. I'd imagine that other
Git hosting sites would find this hook useful as well. Thanks!

Tom

--
Tom Preston-Werner
GitHub Cofounder
http://tom.preston-werner.com
github.com/mojombo
