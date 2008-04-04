From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Submodules and branches
Date: Fri, 4 Apr 2008 16:02:55 -0400
Message-ID: <32541b130804041302i1e32e4b3l141e8b08200a2357@mail.gmail.com>
References: <810a540e0804041240p4efd0973g7f46a2021b352822@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pat Maddox" <pergesu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 22:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhs8U-00019I-FR
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 22:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbYDDUC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 16:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbYDDUC5
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 16:02:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:64854 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYDDUC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 16:02:57 -0400
Received: by fg-out-1718.google.com with SMTP id l27so174948fgb.17
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SuVpa5zNp7+xU1TQCm7ikDFxCfxcu7M5/QS1DUbbVo0=;
        b=qEma8PZDBflawlrylVaQLhk303Lxj7YwRsOUqdU3f64MjGS0Wwev5Lxo1IJgNHfZawEJbRVYtkiPJS6jq08bASSzzm/vUxxCa8zlSlHdbKtNUajfeMQem7FUH3/NdKiRgKA6iLCsrjx78FMWt8MnH6Dxwao/gteFUMbMPUMaZKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rZ0P0DuJC1gi25UWiWGf2gckPy7qBajITAM9UZy2WUfFiX92lKfdie1D6yXEiOq3G3ZOLZ+eGZH7e8Am0clqv+Tm1beh337JujVqV2cXD59GYiirHCRUfJVW5xLR2SOiN+YPIQXmulxbLNr/HV+IA98tdLGO7gq5NyPQ6r4YcLE=
Received: by 10.82.167.9 with SMTP id p9mr3986866bue.7.1207339375356;
        Fri, 04 Apr 2008 13:02:55 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 4 Apr 2008 13:02:55 -0700 (PDT)
In-Reply-To: <810a540e0804041240p4efd0973g7f46a2021b352822@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78813>

On 4/4/08, Pat Maddox <pergesu@gmail.com> wrote:
> I've got a repository that uses submodules.  If I cd to the repo root
>  and create a branch, all the submodules are switched to that branch as
>  well.  All good so far.  I go into the submodules and do my work,
>  committing as I go along.  Then when I'm all done and want to merge
>  the changes into my master branch, I cd back to the repo root and do
>  "git merge new_topic"
>
>  That's where it breaks down.  The commits that I made go into the
>  master repo itself, and the submodules don't have them.

There is something wrong with your story somewhere: submodules in git
each have their own, completely independent,
branching/merging/pulling/pushing etc.  What makes you think the
submodules are branching at the same time as your supermodule?

Perhaps you have accidentally committed the *files* from your
submodule into your supermodule, which means you're not using
git-submodule at all.

Have fun,

Avery
