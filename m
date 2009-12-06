From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH v2 0/6] add support for git send-email
Date: Sun, 6 Dec 2009 22:16:16 +0000
Message-ID: <b0943d9e0912061416y4089643l2a5ebdf1c1c0960b@mail.gmail.com>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Karl Wiberg <kha@treskal.com>
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 23:17:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHPOx-0008Uk-HU
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 23:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327AbZLFWQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 17:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934325AbZLFWQL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 17:16:11 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:60417 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934313AbZLFWQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 17:16:10 -0500
Received: by fxm5 with SMTP id 5so4363837fxm.28
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=RwWlNgrgiPlPswYZK15Z995Lt1yZ2kHEhnvPP/VgFxs=;
        b=jnMWQ30w10aFomybgy5vg0oAYA2q6WiPCHUeFmYkaq9Bj7aBB2/7Y5n3usjeAALW2s
         j/GQC2MuxwVjg9+4RKJybHwYfAkqhE6kq8YnWOOkAVIU0B4C1uK6V28xvBelA7V975ro
         zndwSQRWdA7TH6NT/0KuWeDMSw/9l47dSeMD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pn9URjEBCZu0UnDPwogalrE3MS+VDn+OwIgjnnUmEDz7hkCdZowHKFEXbylJ4G07Tx
         uRcwHthHrbfLbx9V2XY1NsOJwKHiaIAN7R2G3hr/4YdIAKD4QGG/BsWkRggKqo3IW1Z4
         SLUEd3LbwCMmAhJ6VLmf+KyOuMLaIYBzP4XT0=
Received: by 10.223.2.69 with SMTP id 5mr849644fai.88.1260137776265; Sun, 06 
	Dec 2009 14:16:16 -0800 (PST)
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134690>

2009/12/2 Alex Chiang <achiang@hp.com>:
> This is v2 of the series that starts teaching stg mail how to
> call git send-email.

I merged these patches into the "proposed" branch for now and test
them for a bit more. It would be nice for some of the stgit options to
be translated into git send-email options (I don't mind renaming the
stgit options to match the git ones):

--refid -> --in-reply-to
--noreply -> --no-thread

Thanks.

-- 
Catalin
