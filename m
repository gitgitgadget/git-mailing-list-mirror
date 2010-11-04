From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 10:36:41 +0100
Message-ID: <AANLkTin7d-RJcy4CHmd5A6LaiphAvHEdbsxJExHt317_@mail.gmail.com>
References: <1288847836-84882-1-git-send-email-kevin@sb.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:37:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDwFp-0006UB-Or
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab0KDJhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 05:37:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53938 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0KDJhD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 05:37:03 -0400
Received: by fxm16 with SMTP id 16so1259151fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=XtzO7fpcZzzhUrRmgPC2YyU5xySiXrmvGyOagHam4yU=;
        b=khSvIZPk7BJciaVfOdflcYnBCIGh2wjhCWrdm3wNTEhnKrdpQTWj+0TnhnsPKzoI4d
         Qd+7hmb0fzucI7B4/UZ9dQRuxv8MLdj/4AmZ6awjzWetctqL747telOrYpsw5CTM2R4k
         y3XONBdJZRpnKOsz/F7O9Q+WvL+RiIFR6Kf3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=BbQ6X0gAq4Ek7BLLkIzu0zE0ILcMPsiWwl9DCaW8QuFqPN6AUtJqDgyJgJ5cTQG3OF
         n8ieQkuBg1sLaSmJhbDXZ6SFcfJbI2A87Ncl6FipSmbbQihg99y+VaDTKXkjIN9cVgyB
         KY2SYpEdgCRbHgZEec7k5jGxeDfNTu1RT89vo=
Received: by 10.223.74.193 with SMTP id v1mr407519faj.105.1288863421899; Thu,
 04 Nov 2010 02:37:01 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Thu, 4 Nov 2010 02:36:41 -0700 (PDT)
In-Reply-To: <1288847836-84882-1-git-send-email-kevin@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160707>

On Thu, Nov 4, 2010 at 6:17 AM, Kevin Ballard <kevin@sb.org> wrote:
> Add a new command "shell", which takes an option commit. It simply exits
> to the shell with the commit (if given) and a message telling the user how
> to resume the rebase. This is effectively the same thing as "x false" but
> much friendlier to the user.
>

I'm sorry if I'm missing something, but how is this different from "edit"?
