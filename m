From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: nested git repos (not submodules)
Date: Fri, 10 Feb 2012 14:47:39 +1100
Message-ID: <CAH5451mU5G-_FaPkpuhKrHAt4_5wiECj=-j9wkA_Ctb=27ncQg@mail.gmail.com>
References: <jh1vo3$7af$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 04:48:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvhSx-0000UM-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 04:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758530Ab2BJDsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 22:48:01 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:49487 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758239Ab2BJDsA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 22:48:00 -0500
Received: by lbom4 with SMTP id m4so1140309lbo.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 19:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Uik8oL/gtcHp4buH7W1x9RsMwyG95deOBhMyr/IItTo=;
        b=RxtUMbCkBK/J+0aTcb7p/xE5O8a647r7bNahpdQn57hD9/1JO1P+G08RGiDTywJM3Z
         rE+WCsr2F7tlN6IIyWiOVph+wcy4Vu7B65FnQLedY16tOGtj0O9yo05jkaNTTAGRvJIR
         zMTJRuPF8Oli1os9ZSxCOftPV5JEhZbgizaXM=
Received: by 10.112.48.65 with SMTP id j1mr1473514lbn.76.1328845679273; Thu,
 09 Feb 2012 19:47:59 -0800 (PST)
Received: by 10.152.12.35 with HTTP; Thu, 9 Feb 2012 19:47:39 -0800 (PST)
In-Reply-To: <jh1vo3$7af$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190374>

> Thanks in advance for any feedback.

My understanding was that such a configuration is essentially tracking
the same set of files in two different git repositories. The location
of the .git is not important, I could just as easily set the working
directory of any git repository to be a folder tracked by another
repository.

My concerns would be based primarily on the different repositories
trying to act on the same files at the same time. Ignoring the
sub-folder completely within the encompassing repository would avoid
that, however you might have use cases that prohibit that.

Out of interest, what itch are you scratching by using this model?

Regards,

Andrew Ardill
