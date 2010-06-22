From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git svn relocate [SCRIPT]
Date: Tue, 22 Jun 2010 15:11:15 +0000
Message-ID: <AANLkTil6VEPqJxp4wiE7f25zmrnZ9vS1M-f4tFuV4pMO@mail.gmail.com>
References: <20100622114043.1419733jtkx6m0co@webmail.tu-harburg.de>
	<m3r5jznr9z.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Stimming <christian@cstimming.de>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 17:11:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR58H-0006E1-UW
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 17:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356Ab0FVPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 11:11:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53591 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450Ab0FVPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 11:11:16 -0400
Received: by iwn38 with SMTP id 38so985964iwn.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TrFBePAa2kfBa0PNT0pwAXerRHbBBijGIpDwKVrjFjU=;
        b=Tlu6e06SY2uYI9JPHFn853+ZNmDZiEt5/xz+8BoqcfngKfI8RoWjiRacdhsCRILYU7
         xyBGOIFRpieDOfFNi6kRe9vOy9//yaOFn1usf7DnpvRAkRmY7lRIAsItXUYvi1DY+31w
         HthiYp7630N/kfz8XzhBr8eTggt33FTxqtbQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SfGFaOxGpayOhyyTMIg6V+m0GNf35ZoX0Tkb/mZAGJR8lTVCKKH69pc7gRfGqJ3wdf
         3qVg6hlgO2gnlnyQoZcpB/HP1tcA4ZteHFVtkwctxeuSVBChua3vuI1tFPzwHyd/n9q1
         hmMxH8g7rpWrUBm5jRbqPYS9Gohh47bZIPv2A=
Received: by 10.231.176.72 with SMTP id bd8mr7861141ibb.0.1277219475856; Tue, 
	22 Jun 2010 08:11:15 -0700 (PDT)
Received: by 10.231.158.195 with HTTP; Tue, 22 Jun 2010 08:11:15 -0700 (PDT)
In-Reply-To: <m3r5jznr9z.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149482>

On Tue, Jun 22, 2010 at 13:15, Jakub Narebski <jnareb@gmail.com> wrote:
> If you can put this script somewhere (e.g. GitHub, or repo.or.cz), could you
> please add information about it to InterfacesFriontendsAndTools page on Git
> Wiki (http://git.wiki.kernel.org)?
>
> Alternatively, perhaps you could send it as a patch adding it to somwehere
> in the contrib/

This is part of the "Reconstructing git-svn metadata after a git
clone"[1] problem for which there's an open thread. You have to
rewrite history using git-filter-branch to fix the branch references
if you need to change the SVN URL.

It would be nice if you could specify that sed replacement in some
git-svn config file if you needed to change e.g. someone's http://
clone to a svn+ssh:// clone without rewriting the whole thing.

Would that sort of thing be possible? Eric?

http://kerneltrap.org/mailarchive/git/2010/5/8/30062
