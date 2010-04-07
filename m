From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Wed, 7 Apr 2010 18:17:47 +0000
Message-ID: <r2n51dd1af81004071117gcc3359dcg1b7d9f034d4b1e16@mail.gmail.com>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
	 <1270661327-28078-1-git-send-email-avarab@gmail.com>
	 <o2zfabb9a1e1004071052g24f91df2ra15f0c517bdd4887@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZp5-0003YJ-AP
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab0DGSRu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 14:17:50 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59488 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab0DGSRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 14:17:49 -0400
Received: by bwz1 with SMTP id 1so1101237bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8ITAsPp9uUQkuMMVis244XfoR/PFKQKHz4pCI/eiwNU=;
        b=TIAA1AUTsRGhMJpiuchpsJ4oQ+kLrYYIdNkX9E9FHu1jw0vvMiC3bJDDyCKn/qJM/W
         /rCnHXfnzJfuvYXWBSEjmZiVrH2B6eXfb/OOB6eIsCCgoJ+ybiqlxeCHEW+kw5Se0mPt
         j9v244vekyI5coVcXSLOgvGrZGv6LX089KByI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OYUTLDSGtSqzn03Br7UeRR/6vyWfNkVdeY6+XM2KNIH4/u1EprvyqFXuJ16opD+2ST
         bMH23B7IS7FBaguj8laDMyAFYqs9wVSltlVA6UHWYCk8+5Zx29OT98TPM58U1F3Xd3bl
         OK2ilzhDpuhF+4rCl/wluBMUPQFD8igxnDyFY=
Received: by 10.204.121.195 with HTTP; Wed, 7 Apr 2010 11:17:47 -0700 (PDT)
In-Reply-To: <o2zfabb9a1e1004071052g24f91df2ra15f0c517bdd4887@mail.gmail.com>
Received: by 10.204.84.5 with SMTP id h5mr9459745bkl.164.1270664268025; Wed, 
	07 Apr 2010 11:17:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144259>

On Wed, Apr 7, 2010 at 17:52, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> On Wed, Apr 7, 2010 at 12:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> I'd forgotten how the Git project likes rebasing :)
>
> It's not so much the rebasing, but your patch gets applied manually
> from the mbox (meaning a different timestamp) by Junio (meaning a
> different committer), who adds his S-o-b (meaning a different commit
> message), so yeah, the hash is gonna change ;).

Of course, but in this case the patch had already been pushed by Junio
to the Git repository as 1aadbf, my original commit was 1eb6f8. The
SHA1 wouldn't change when it was cherry-picked to master unless it was
further rewritten.

But in any case referencing the mailing list post instead of the SHA1 i=
s better.
