From: Howard Miller <howardsmiller@gmail.com>
Subject: Re: "submodule" mistake and a problem
Date: Mon, 1 Oct 2012 13:05:57 +0100
Message-ID: <CAHVO_93d92Ert35z1popk+X8HAAHX_jwTVdRCjrhNHrhTsvx2Q@mail.gmail.com>
References: <CAHVO_92=5u-i+-d__5k7Uoq5pF4iACq9GuBSj4U5MepbKV_jdA@mail.gmail.com>
	<506981C1.3030504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 01 14:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIelE-0007uB-9w
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 14:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab2JAMF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 08:05:58 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64142 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab2JAMF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 08:05:57 -0400
Received: by ieak13 with SMTP id k13so11849954iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P0/pSzJ2mmpDfJY/HPPBTN9upkjzjjQfTvPkgoYs8vc=;
        b=NqUovLiQ/LJ7mgbP1HDQFuDNekhRGY+jlhKpstfma4OihWNYpvX2xdRJsEAOkpDWRU
         WKa4T4EGHfZ7LExVi/C6zp5FpmOjxJOzdEL8KIlFCmee7cICPZMZmi5RnHskoEKsc855
         vF9K6+9PWOaKoI8pkxbNDCTP8b5ZyTn1SsOKdWrjOtqub/ENOtzvNX28lzq5g6tfLRiW
         JI1fW8AjOjdmKutVochQ0BozWBPQaJW62g1Cap8UYRawhN3FUiQHky3eVA6Vosi9Jyvq
         5ZDYSLz/asc1OI/O3RZcSk4aGd6/+1d7Edaa6VrXhbaP1+fdiLq6fJqq/QnUmGInKZv5
         KfXg==
Received: by 10.50.237.98 with SMTP id vb2mr1752964igc.6.1349093157387; Mon,
 01 Oct 2012 05:05:57 -0700 (PDT)
Received: by 10.64.13.110 with HTTP; Mon, 1 Oct 2012 05:05:57 -0700 (PDT)
In-Reply-To: <506981C1.3030504@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206730>

>
> Perhaps:
>
>   git rm -f --cached path/to/subdir   # remove from index, keep files
>   git add path/to/subdir
>
> -- Hannes

Fantastic.... worked perfectly.  I'll write that down somewhere for
the next time I do it :)

Is there a better way of handling sub-modules like that? I've looked
at git submodules but just got into more of a mess. It would be nice
to push a project complete with a (git) submodule upstream but it
seems tricky or impossible.

Thanks :)
