From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 5 Oct 2011 12:50:06 -0400
Message-ID: <CAG+J_DynqAK8uXDPtHwWpGhfA5qFZifucs91qL79Pu_DmCxG3g@mail.gmail.com>
References: <4E8C6F2F.1070306@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: nicolas.dichtel@6wind.com
X-From: git-owner@vger.kernel.org Wed Oct 05 18:50:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBUfd-0000eg-9I
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 18:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934993Ab1JEQuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 12:50:07 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53132 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934960Ab1JEQuH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 12:50:07 -0400
Received: by ggnv2 with SMTP id v2so879083ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=73X8cMfOxUFTVNxiaX5s3MVlSHNdxeoVmEIZdBlyn1I=;
        b=UMm+jOW8mOeFUtkjX1tzghQ2UF/SUX/8W9OSsAFWIpFsKBxMsdhABTx/1hsuwqzlhh
         +dXBSFLLdnEKl3cRr6ude497CaeptuxOcsFhhRMVi7MB/Z5mTNLe+C1Iwl7A4xFPJCa8
         jSzzsK783/rfG+Gax+cgtPJrgthQYmjpI2uV0=
Received: by 10.236.190.200 with SMTP id e48mr14725320yhn.59.1317833406504;
 Wed, 05 Oct 2011 09:50:06 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 09:50:06 -0700 (PDT)
In-Reply-To: <4E8C6F2F.1070306@6wind.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182862>

On Wed, Oct 5, 2011 at 10:52 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> Hi,
>
> still with version 1.7.6.4, when I do a cherry-pick, that succeeded, =
I
> cannot do a commit --amend after:
>
> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> [dev 1a04a23] drivers/net/usb/asix.c: Fix unaligned accesses
> =C2=A01 files changed, 33 insertions(+), 1 deletions(-)
> # echo $?
> 0
> # git commit --amend
> fatal: You are in the middle of a cherry-pick -- cannot amend.
> #
>
> The same operations (with the same patch), with version 1.7.3.4 is ok=
=2E

Please do the following with 1.7.6.4:

# ls .git
# git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
# ls .git
# git cat-file -p 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
# git cat-file -p HEAD

And send the transcript.

Thanks.

j.
