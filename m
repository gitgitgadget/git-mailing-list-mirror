From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Thu, 27 Jan 2011 21:53:35 +0100
Message-ID: <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 22:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiZ1f-00069L-V9
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 22:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab1A0VFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 16:05:00 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52796 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab1A0VE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 16:04:59 -0500
Received: by fxm20 with SMTP id 20so2603027fxm.19
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BB7hll+kjKlc8RgfDr8/pPpm7nGuKQsRdmkJ7j+VWRg=;
        b=cWa2Yl/+ej8dviSa5ZKjL5hX0Vxi8FwTTrD7biDWzjv1QpEC4rr+7dwdd2xnUbw2Vh
         dB3U0i0TB1c8q3/AzXUDOAlj4/u9lyIqc8sT9mLalwXXzjLkG/KEvbNodzkNnTTWyNBr
         RYAniF1ZqGF3WWtWOLyWfYCRXMJ6EsoUqihls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R18LrJTJzt8vh7F3GDey5wHPDpHpSy6xKsBlvom+CoDRhaSjAI1KeNgY/MCloQzT3z
         p1kD+p89+/Iq2Fq/ut2LxyRzjQze9Kk6rlGyiXhxeE7Sv3yVsplwMHVNTyK7hrm1ntpS
         e5fl+fww6jFyn/Rd9eTufPdhBjrQ7JPrdyug4=
Received: by 10.223.86.130 with SMTP id s2mr1408398fal.66.1296161615115; Thu,
 27 Jan 2011 12:53:35 -0800 (PST)
Received: by 10.223.95.201 with HTTP; Thu, 27 Jan 2011 12:53:35 -0800 (PST)
In-Reply-To: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165591>

On Thu, Jan 27, 2011 at 20:38, Thomas Hauk <tom@shaggyfrog.com> wrote:

> Am I incorrect or is there a way to accomplish with Git what I was
> doing before with P4 and SVN?

Different systems have different methodologies. Perforce and
Subversion are more of a virtual filesystem, while Git tries to track
a single project.

You'll be much better off if you have project-specific repositories.
