From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit] Immediately evaluate the ProgramFiles environment 
	variable
Date: Sun, 10 May 2009 14:09:02 +0200
Message-ID: <e5bfff550905100509s656caf34u528307a2d629c06b@mail.gmail.com>
References: <1241949225-10046-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun May 10 14:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M37v5-0002zd-W4
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 14:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbZEJMJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZEJMJD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 08:09:03 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:19340 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZEJMJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 08:09:03 -0400
Received: by ey-out-2122.google.com with SMTP id 9so749690eyd.37
        for <git@vger.kernel.org>; Sun, 10 May 2009 05:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+2TjLD5ahx4DI9K6+vVz0MTCLvCSRjbiSOWb0ox9obg=;
        b=XTNYiwquZpbHk8MqDko8+a/7Nv5BeyGRxybsBIE7UoJtQFJDC8sqq+y4znIpVnwOns
         h27AcYmtNdxUiVOEz2QwHetASeQ7FTmiwFmAf1tJxg5Z557Riu1+0H69ZaaNrZ6TeNUd
         BwQmYJ7z1koaSlejcWzoYou+AfpFJI3dSk2hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w0iW6sLQq0mDHwtvBpuPOZrZGWj7aLGeeDkeow+FKQO3tOJgqg7YRg5RP29zAWdp9l
         ePZO9kJYQV9KHlOLqeChRGRwzeEhShCUFoy4k6lhULvv4HfEpF/Ljzay86Ys4tbRIjPv
         ZzNF2i9mJAfwhmPaPg6q6jwAQjNUsvJpLm7xQ=
Received: by 10.216.47.71 with SMTP id s49mr2730914web.129.1241957342570; Sun, 
	10 May 2009 05:09:02 -0700 (PDT)
In-Reply-To: <1241949225-10046-1-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118717>

On Sun, May 10, 2009 at 11:53, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Commit 50d839b (Don't hardcode GIT_EXEC_DIR for Windows so much,
> 2009-04-18) broke 'make install' on Windows. Somehow the current working
> directory was prepended to the install path given with target.path, when
> $(ProgramFiles) should be evaluated during the call of 'make'.
> This seems to be a qmake bug with generating the Makefile.
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---

Thanks, patch applied and pushed.
