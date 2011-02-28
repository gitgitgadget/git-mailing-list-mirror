From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 17:46:19 +0100
Message-ID: <AANLkTikTPVf1fZiTxsmLe-MCWVQY4YBGen5Bj_Yn0SSz@mail.gmail.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com> <7vfwr8jfsl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 17:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu6Fa-0006aJ-FY
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 17:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab1B1QrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 11:47:03 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49433 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab1B1Qq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 11:46:59 -0500
Received: by ywj3 with SMTP id 3so1315153ywj.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=73RNkHerQO7C2NqRHMSfwtYg9bq9POZGYY91Qcgz7g8=;
        b=WLsAM+M5RFlxaKCqSILp+wbW+6JxV/c4JvwBK8YLKg4q5Hl+jfE+9nRGeXD9ckRkST
         IpAY2bn2P33vGynmnZWkltTusHwI7+YRqK7Hwmbyl/TMa2ce1WwkdWQkdljsqzmVSoOC
         KFedqFaAS3YqtAcyLXvPijEmbm1Ij6xGy0Y8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qXOXqLl/dM4ivEB0HOQV/51vyp2vgBoIZGXmPoLnLvRzglE5Dyla52O+S3ad65oHUS
         trcCSda+l6yd0kxS9pBXegVsok6+xVNHl5GhOEA3DMVg9YxzKLPd0ElkLpCKKTJ+KiKY
         gPlEPwVTP67V6abGQd4XM4wYS7ialCLCCBZuY=
Received: by 10.150.218.16 with SMTP id q16mr7360615ybg.349.1298911619099;
 Mon, 28 Feb 2011 08:46:59 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Mon, 28 Feb 2011 08:46:19 -0800 (PST)
In-Reply-To: <7vfwr8jfsl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168120>

Heya,

On Mon, Feb 28, 2011 at 17:16, Junio C Hamano <gitster@pobox.com> wrote:
> Not yet; the code has just become in good enough shape to be built and
> measured by anybody interested --- didn't I say WIP somewhere?

Yes, but I figured that we'd want to see if it's worth pursuing at
all, e.g., whether we should try and get this in decent shape or not?

-- 
Cheers,

Sverre Rabbelier
