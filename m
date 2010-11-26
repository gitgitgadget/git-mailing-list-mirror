From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH/RFC 00/20] Refactor rebase
Date: Fri, 26 Nov 2010 20:16:46 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011261954350.17721@debian>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com> <alpine.DEB.1.10.1011252120450.17721@debian> <AANLkTikyQTA3b8+subR2FTL9zFBt_dGqNxjsjP+fwE-n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 02:19:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM9Rc-0002eE-Gm
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 02:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab0K0BQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 20:16:32 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:39284 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0K0BQc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 20:16:32 -0500
Received: by vws15 with SMTP id 15so228941vws.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 17:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=aB5LSbnipJBBlnl+qx7XLK88xioWjO7p0SD+I12Uvo4=;
        b=JC9tU1MGv9qxalAdBuq5fyKg8U259hfAv8a8xFH0KhaPjvlFXLzZB+TxHOBZYMcBuE
         jnxgyIF6oYcoDyKeOBbcxPjrMgh22q+5xp7W5qwkLaQgqny6NUCXDJUFb7WxXS7E9PxA
         8NqfWL5Fcg9lejPiWqA4q0a2+RxgL6Nnu/o2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=s/1MXKnChAvi4tmKDtDMHLwaGspvEk1j1RkKWaVglrp7AgUVa9X/wM5cTbXpmEaeyz
         9dRdp9hZ9v2AtXrwV0+IQgM42hASpGVg32tNNev967Oo/vhRmBopErjdpvntq6ap+zN4
         yHD2tBaoUdbtLW2/yPOeWRWakm3Ay5NPNbkg4=
Received: by 10.220.190.5 with SMTP id dg5mr712221vcb.163.1290820591014;
        Fri, 26 Nov 2010 17:16:31 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id j21sm348537vcr.10.2010.11.26.17.16.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 17:16:30 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTikyQTA3b8+subR2FTL9zFBt_dGqNxjsjP+fwE-n@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162289>

On Fri, 26 Nov 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Thu, Nov 25, 2010 at 21:23, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
> > I forgot to say that the patches should be applied on pu.
> 
> This is undesirable. In general you should base your patches on
> master, unless they depend on a multiple topics in next, in which case
> it's acceptable to base them on next (or directly on that particular
> topic, if there's only one).

They touch the same code as 729ec9e (rebase --abort: do not update
branch ref), 7baf9c4 (rebase: support --verify) and 92c62a3 (Porcelain
scripts: Rewrite cryptic "needs update" error message). However, it is
only 7baf9c4 that would have to be more or less redone if I did not
base the patch set on it. Do I understand correctly that I should
therefore have based them directly off of 7baf9c4?

I suppose it is not worth resending this time. Tell me if you think
otherwise.

/Martin
