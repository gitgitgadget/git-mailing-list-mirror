From: Eric Raible <raible@gmail.com>
Subject: Re: git push <branch-name>
Date: Tue, 5 Oct 2010 15:28:56 -0700
Message-ID: <AANLkTi=sDDXRKuHf93cZ4fSVpZFvgyB+k934qg7gDL9T@mail.gmail.com>
References: <201010051811.49211.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 00:29:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3G0M-0004Je-RL
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 00:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab0JEW25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 18:28:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40253 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab0JEW24 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 18:28:56 -0400
Received: by ywh1 with SMTP id 1so205459ywh.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=WNJL+7hkMioKxZsVvHUtLf5mdLVJpTsKiDHOaLg3B4k=;
        b=Tw93Lu/UNi7fE9q+RTr7wMxYGLabCUwiSFKQnjiCamNGl9sxy0W+y9U7+GqRgX3RGM
         MmTfphQ47zOJ2Pp6pSiPEP2CZz4y+ldl+1f6VPBM8PP+EN74q/8tMcHGxfOjkehr7Nw+
         LIv7GBf9JziFNP1lKyddACvsQ1DW0esvNIZuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AURLykbel4sr5hVPtd4Go9NAIKKKZZJAJA1GedC/6d5Uq/ytlmJAEbPXFECHWr4g5V
         tAsmfVQA5iqnqfQUvCK3C/4DNPS1MvmU94YvtFOy6xluNdHGYanQmC8BuU4TxZZY7Sed
         E36KdTmCjm59kRczMugeW/RBRIPYwjl39RYS8=
Received: by 10.150.51.20 with SMTP id y20mr952758yby.244.1286317736121; Tue,
 05 Oct 2010 15:28:56 -0700 (PDT)
Received: by 10.220.163.85 with HTTP; Tue, 5 Oct 2010 15:28:56 -0700 (PDT)
In-Reply-To: <201010051811.49211.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158254>

On Tue, Oct 5, 2010 at 3:11 PM, Daniel Johnson <computerdruid@gmail.com> wrote:
> Isn't that syntax reserved for remotes?
> for example:
>
> git push origin
>
> I feel like it would be a bad idea to have these 2 types of invocations
> overlap in syntax like that.

The idea is that given "git push <branch>" if <branch> is NOT a remote but
IS a branch name then git could unambiguously provide the correct remote.

Naturally if there's a branch and a remote of the same name then for backwards
compatibility the remote would be chosen.
