From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Sat, 10 Nov 2012 17:08:06 +0800
Message-ID: <CAMPhdO9qNUA=8WG+jTchex3fw=E6spA6pwwJVF+CYJ_orjSaDg@mail.gmail.com>
References: <CAMPhdO8Sy8ZuXyWbvch+fXzbSVdmwC69a-KaLBRBGX8MVGxv_A@mail.gmail.com>
 <6df0df49-afb9-4faf-9a2d-6f397f3a167a@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:08:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX73V-00052P-GU
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 10:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab2KJJIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 04:08:30 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:45979 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab2KJJI2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 04:08:28 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so3515811lag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 01:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gZJ5aNn7TV0gvYeJ/J9EijmHwKmHG6Q1g3+/yNDm1po=;
        b=hTzhotJTXl/g2jeUKshu47iNtSlJL2g2oOQTxokgxgB8MeukBn11/T0IuGbnmVlNBd
         hBBsEVEy8gERvRBVXttuST06t9bNj6kAKNMAq1hNLJLfSn6s4FzcOihBB5BkAlItePQL
         66xuYZxWo7ZieG1eqUnpO4ySexrLc4Lc+C78SdsI6Ac8kSH0ScHXJ6nLyM/AtYjo68cc
         4zSd0/Xc5VJ6byNTf4swFFF8fQYxjUzyrvp9ZbkIp3HcHb6fkFqfWuW77d5oCmJx9bvb
         0WwyYuO8k38iSFrk7ds0o1H6/p5UUSN9vZU9C8c2FIWkJkCI/atOBDextDIQXWWEYtGf
         BmDg==
Received: by 10.112.38.163 with SMTP id h3mr5488414lbk.134.1352538506925; Sat,
 10 Nov 2012 01:08:26 -0800 (PST)
Received: by 10.114.75.1 with HTTP; Sat, 10 Nov 2012 01:08:06 -0800 (PST)
In-Reply-To: <6df0df49-afb9-4faf-9a2d-6f397f3a167a@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209265>

Yeah, that's a very clean way I'd always want to follow, yet the
kernel upstream isn't doing so.

On Sat, Nov 10, 2012 at 4:52 PM, Enrico Weigelt <enrico.weigelt@vnc.biz=
> wrote:
> <snip>
>
> yet another idea:
>
> you coud always put your patchsets into separate branches,
> rebase them ontop target branch before merging, and then
> do an non-ff-merge, which will make the history look like:
>
> * merged origin/feature_foo
> |\
> | * first preparation fo feature foo
> | * part a
> | * part b
> |/
> * merged origin/bugfix_blah
> |\
> | * fixing bug blah
> |/
> *
>
>
> cu
> --
> Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
>
> Enrico Weigelt
> VNC - Virtual Network Consult GmbH
> Head Of Development
>
> Pariser Platz 4a, D-10117 Berlin
> Tel.: +49 (30) 3464615-20
> Fax: +49 (30) 3464615-59
>
> enrico.weigelt@vnc.biz; www.vnc.de
