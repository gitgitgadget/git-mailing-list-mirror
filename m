From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: fixes for older versions of bzr
Date: Fri, 17 May 2013 12:25:39 -0500
Message-ID: <CAMP44s1-RdmM9vs=XSvN1KNOh92Zr=nJWHGR0MZZV9BFXG_3JQ@mail.gmail.com>
References: <1368810619-18419-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 19:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOPZ-0000wR-3W
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426Ab3EQRZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:25:41 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:43469 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367Ab3EQRZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:25:40 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so4452797lab.7
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3KWsfWqR95OBEohWkzmYbNXlUEl7bmHZHXTjk7iwtUY=;
        b=czvMpJwMhHhqCSgx3um79lUGQvKYeARJqXfM/bYIkMW4xqzo+TrpAKIyK0tHPFvneo
         DXDcvxFVvDTZvauXJg2arq8v4kUVdEQegV2rFSENYmdHqCTpv9wEc9yaJr7azf/gtBAW
         +lHsNelV4evKnHnEXYp4kRjkRcBYrZ3Y8V+mVNzsj7D8C9l6Z1muQs7YZxi69Fj2wAx2
         F6pAUU9xy14PZXj2+NwIT6VhDR8nudfAYXqVmj++dXKTXXSGjCacyyJxQ/81Zyk1OM+k
         evYyPKIl/UcUAmkIpBBpXDqOY11X3cCp7uCbCyXTMuwHqRVdpQO9J1WByejg5IXYcLIL
         0xNw==
X-Received: by 10.152.27.132 with SMTP id t4mr13996638lag.46.1368811539250;
 Fri, 17 May 2013 10:25:39 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 10:25:39 -0700 (PDT)
In-Reply-To: <1368810619-18419-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224717>

On Fri, May 17, 2013 at 12:10 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Up to v2.0.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

We want this for v1.8.3, otherwise it wouldn't work in older versions of bzr.

-- 
Felipe Contreras
