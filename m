From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Thu, 19 Mar 2015 17:59:19 +0700
Message-ID: <CACsJy8B=Dx2+OWch1zx_xg91de9yhttVMwgE1SxDOuSTns2b_w@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
 <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
 <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
 <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
 <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
 <CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
 <CACsJy8BqA2dm8DpDrrFN4FxHG+4gnG3Q7c3kM=YmBrkuHftvog@mail.gmail.com>
 <CAABECY13XT3+rEGGtKfe3Xwg4RtzcWtpL=Nm7aivv4_35TvL0w@mail.gmail.com>
 <CACsJy8D16ERGH=P4etGRpZM_3BR9iYZBsUnWBGAbayVqmEhhXw@mail.gmail.com> <CAABECY2x=G+nYdSyxpz8MvE4G6RSwcGSXu1LzwAKYG7Mqwk1kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:59:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYYB9-0000fy-CS
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 11:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbbCSK7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 06:59:50 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35463 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbCSK7u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 06:59:50 -0400
Received: by ieclw3 with SMTP id lw3so62248319iec.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o31wE6rRjg7jYdPqh/uu2eRdhYza87h3j9ESkWtIvFY=;
        b=lRIrmGv46wBt1TS5LZ8KzmijzXn1Z7JZQuqNXws2yX9/xeb5ojl2TO9IthSy4FOeP0
         C8m5BmmNzoo/BNBB66BiNq/CVEsUI6+YEz6zKBSZNaW3kFVMzBxDSE8VxkLIY2jNDIM5
         DmICzLt7X6V8a1FPspvLJW++u/N1lfuUOKPk9WG6I3Jby5rVfro8KAlrwPVzvNx9cOWz
         jx2ptqYcq1E/sTW7BeGthzzvrxkgklZwTlKMx43Rmm00Gq3ScvU9gaY87pCTUHO+wRPi
         1fpPVUer3E+wUMMotcBZWawmJNsYMZYOrq58FhZPpDXGgKwOQMCJpsb77/R+XNe6geJF
         Kjyg==
X-Received: by 10.107.29.21 with SMTP id d21mr8030452iod.11.1426762789443;
 Thu, 19 Mar 2015 03:59:49 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Thu, 19 Mar 2015 03:59:19 -0700 (PDT)
In-Reply-To: <CAABECY2x=G+nYdSyxpz8MvE4G6RSwcGSXu1LzwAKYG7Mqwk1kA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265797>

On Wed, Mar 18, 2015 at 10:14 PM, Graham Hay <grahamrhay@gmail.com> wrote:
> Got there eventually!
>
> $ git verify-pack --verbose bar.pack
> e13e21a1f49704ed35ddc3b15b6111a5f9b34702 commit 220 152 12
> 03691863451ef9db6c69493da1fa556f9338a01d commit 334 227 164
> ... snip ...
> chain length = 50: 2 objects
> bar.pack: ok
>
> Now what do I do with it :)

Try "fast-export --anonymize" as that would help us understand this.
Or you can try to see if these commits exist in the remote repo. If
yes, that only confirms that push sends more that it should, but it's
hard to know why. Maybe if you fire up gitk and mark them commits,
you'll figure out a connection. There are actually objects in this
pack that are expected to exist in remote repo, but it's hard to
tell..
-- 
Duy
