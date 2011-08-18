From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Branches & directories
Date: Thu, 18 Aug 2011 05:52:02 +0000
Message-ID: <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org> <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 07:52:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtvWw-0006Xx-2y
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab1HRFwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:52:33 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:63502 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab1HRFwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:52:32 -0400
Received: by iye16 with SMTP id 16so3311283iye.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 22:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ypQEmqVrqskX/0EYvxlWVoRyoEMTnECl3BuIch6D9+I=;
        b=jVc4ZXImK7pKTl7Nh45bz5jua2eh1gzu084DxhZKa+LFhhBcjoYiRgfOfbEJc6xWtJ
         U8it0m6NJAmUBAxqrhay/Vc2txG7RlUf2xiQoOsNASp++pbKqySZA4zMcfFpVSLtSjIY
         wG64etoGDqSRv5/tmQah1Sq2NDjccVzMVC34M=
Received: by 10.42.162.3 with SMTP id v3mr356630icx.89.1313646752077; Wed, 17
 Aug 2011 22:52:32 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Wed, 17 Aug 2011 22:52:02 -0700 (PDT)
In-Reply-To: <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179568>

On Wed, Aug 17, 2011 at 21:23, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> It would be really nice, though, if Git could somehow
> "stash" such files when checking out a different branch. In general, I
> would prefer if uncommitted changes and untracked and/or ignored files
> stuck to the branch where they were created.

As an aside, the problem here is likely a manifestation of the fact
that nobody understands what a branch is; the word 'branch' is
TERRIBLE, as everyone has a different idea for what that should mean.
In my opinion, `git branch' should become `git ref' or the like.

One of git's worst faults is that a complicated and imprecise
interface has been draped over a very simple and precise underlying
structure.
