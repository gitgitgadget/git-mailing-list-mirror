From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 12:31:19 -0700 (PDT)
Message-ID: <m3wskek4wt.fsf@localhost.localdomain>
References: <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
	<7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
	<7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
	<7v3anb19n7.fsf@gitster.siamese.dyndns.org>
	<7vwskjazql.fsf@gitster.siamese.dyndns.org>
	<20080621121429.GI29404@genesis.frugalware.org>
	<7vwskfclfs.fsf@gitster.siamese.dyndns.org>
	<9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
	<20080624160224.GA29404@genesis.frugalware.org>
	<alpine.DEB.1.00.0806241709330.9925@racer>
	<20080624185403.GB29404@genesis.frugalware.org>
	<alpine.DEB.1.00.0806242007150.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:32:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEFY-0002To-3D
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYFXTbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYFXTbY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:31:24 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:26763 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYFXTbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:31:23 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1579563ika.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=W04fuppNwwFJ7wKfiNYRs1NYLqJZqPI+Cw4FnK74KD4=;
        b=l+rDUGCktZwz5pFGXCNt1orNxQxs1v00VI4iIV2Wl7OFdLFoVJjjMcb/PxdlqFAexq
         2GBN1zGKSusuPZduo94qGqCJuFBTAVEPQEE1dnKcaeDCar/7hSyKxvSXYHZ9moj5CWfE
         VnDtEXhRTlVkaKMzDIOMxUIczcprvtDAN1maI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=IRcyg+sb3kMV5H/Pp8S3+rQ8z0Y90rNdVSGLBjVKO9vk4BxqS9KijNh7LkpsgEsvQk
         +SulEaGHykjid3sv/UJa7Y6TPHV/UsVKmuqx1siQOC8/L9MwvFwXeUgFD7z94qv9RRxK
         TW0AJUj6gHKVPm+eNxiaDzoImdBb9ZTTEusxo=
Received: by 10.210.56.7 with SMTP id e7mr794443eba.123.1214335881985;
        Tue, 24 Jun 2008 12:31:21 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id i3sm1065522nfh.14.2008.06.24.12.31.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 12:31:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5OJUAZI010493;
	Tue, 24 Jun 2008 21:30:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5OJTcR0010483;
	Tue, 24 Jun 2008 21:29:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0806242007150.9925@racer>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86123>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Tue, 24 Jun 2008, Miklos Vajna wrote:
> > 
> > Using fc48199 ("Merge branch 'master' into next", which includes
> > ed99a225) on the server, v1.5.6 on the client, I get: 
> > 
> > $ git clone server:/home/vmiklos/git/test next
> > Initialize next/.git
> > Initialized empty Git repository in /home/vmiklos/scm/git/next/.git/
> > vmiklos@server's password:
> > bash: git-upload-pack: command not found
> > fatal: The remote end hung up unexpectedly
> 
> Hmm.  Probably the client needs to be newer, too.  This is going to be 
> painful.  Junio?

It looks like git-upload-pack and git-receive-pack would
have to be left in $PATH, at least till old clients die
of old age ;-)

git-shell hackery won't solve problem, because not everybody is using
git-shell.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
