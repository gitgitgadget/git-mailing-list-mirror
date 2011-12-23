From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Patch to support proxy authentication through NTLM?
Date: Fri, 23 Dec 2011 02:43:13 +0100
Message-ID: <CACBZZX4FS37zqY3eUKHK+FGMjXB4D1DEi17hQSPsmQBS9E8jUA@mail.gmail.com>
References: <4CDEC141B5583D408E79F2931DB7708301691B80@GSX300A.mxchg.m.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Schmidt, Marco" <Marco.Schmidt@cassidian.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 02:43:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RduAe-0000us-RM
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 02:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149Ab1LWBng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 20:43:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54869 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab1LWBnf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 20:43:35 -0500
Received: by eaad14 with SMTP id d14so2419959eaa.19
        for <git@vger.kernel.org>; Thu, 22 Dec 2011 17:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QswpMtS7Vu02OscN1bSHPQa27ixDrX54Ej4JJ7QLJ6U=;
        b=Oj+AL8htxFwpZ1KQtW9jo8AzMkG0pvZvVPbt6cV2/XEdfqD3f3FBULhYAWGBP1xrH8
         L/rvJYvd6xBTxoElduqaT5vZlQIA9fKw6ALHnGchExFDFxPXcTiscleTTxHwSISWUmc2
         EnkA1aGGH24aMLoAy42GSeM4nYakzzEl8BE2Y=
Received: by 10.204.157.25 with SMTP id z25mr3627877bkw.25.1324604614372; Thu,
 22 Dec 2011 17:43:34 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Thu, 22 Dec 2011 17:43:13 -0800 (PST)
In-Reply-To: <4CDEC141B5583D408E79F2931DB7708301691B80@GSX300A.mxchg.m.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187618>

On Thu, Dec 22, 2011 at 09:45, Schmidt, Marco
<Marco.Schmidt@cassidian.com> wrote:

> After debugging git proxy authentication and creating my own fix to
> support git+https over an NTLM proxy I found a set of patches inside of
> the mailing list archives [1]. What is the state of this patch set? The
> essence of the patch would be to allow NTLM authentification by giving
> the correct options to libcurl.

~Weekly Junio sends out a "What's cooking in Git" E-Mail. Things that
aren't listed there aren't being actively considered for inclusion.

Which means that if you're interested in it the best thing you can do
is to take that patch, rebase it on top of master, make sure it works,
and re-submit it.

See Documentation/SubmittingPatches and one of those E-Mails Junios
sends out for more info.
