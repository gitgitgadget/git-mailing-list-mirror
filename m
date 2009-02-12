From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to date 
	with -f
Date: Thu, 12 Feb 2009 21:30:34 +0100
Message-ID: <bd6139dc0902121230w1b9fec28sae4e14bdda58a50b@mail.gmail.com>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
	 <alpine.DEB.1.00.0902122126460.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:32:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiEc-0004cd-Dx
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760942AbZBLUaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760483AbZBLUaj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:30:39 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:57319 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760683AbZBLUah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:30:37 -0500
Received: by fxm13 with SMTP id 13so2642741fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 12:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=N0R+HPMBNXeY5ka15+pAbitCjo01gaLROOBz+8v/GZ4=;
        b=Ov9cT32DOEU8coWIRm633v205fIVqKBklmm0a/Oyhayt+CHSTC8Xo9HGxyWTC5Ty9+
         by7Y3BS7bk7CriAyka2oPkmlLhtHWxBilCHZMdNI7Olk5nApTH2FmCk5KKCMWrDLDT4R
         TcY43biW9gtNWc3YIyxuQu2Bz9k4hoIpo17Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Cgsryx3iTCecVr043RZ66y81FK68KQsHK22ziFc4kFoTdTpVmuYKP9L1ELbH20jIxO
         PIzVkd3MvaT6gQFxxj88JLaJ6/mH2sN28NvpINy3xYd6eFjmkEXVKHvKDONYqc9tBp/h
         psI3Ma+XPC8mBtWvIHXzR/qhBiI7VeWawcrQ0=
Received: by 10.86.3.4 with SMTP id 4mr69037fgc.41.1234470634153; Thu, 12 Feb 
	2009 12:30:34 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902122126460.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 42b02f96a3bf16d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109642>

Heya,

On Thu, Feb 12, 2009 at 21:28, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> FWIW I typically use 'git rebase --whitespace=fix $(git merge-base
> origin/master master)' for that, but that only works when there is a
> single merge base.

Hehe, shouldof known there is an easier way to do it currently. Why
does that work though? Also, any comments on the patch? ;)

-- 
Cheers,

Sverre Rabbelier
