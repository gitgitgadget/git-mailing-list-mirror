From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sun, 6 Sep 2009 20:16:21 +0200
Message-ID: <20090906181621.GA23412@localhost>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905084641.GA24865@darc.dnsalias.org> <vpqfxb0s177.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 06 20:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkMI3-0004Zm-So
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 20:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098AbZIFSQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 14:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758085AbZIFSQ3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 14:16:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45407 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbZIFSQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 14:16:29 -0400
Received: by bwz19 with SMTP id 19so1192183bwz.37
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=gqTpy6tPVBzFc6Kqk3iUQsTsqn96M/gVRhwwNaVo6kI=;
        b=tPS5jnH0zctde94iMZGlmY4YstyoEYbur4QCJ9bYbqmfOy5pzVkn5ZlFxtUMKxMju6
         626qt6FF/vcvah5I55nmOMs5J8SEO6e/w2Fk48x8OTDWjOqxO74qDZJhueUx7M93iM8R
         hcqtFz7FLfDYBPVG3jqr3WNrujEeCdB3ZX9Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=BDIVccsYTmu27jL0qQpfCzbP9ebXeCZeDf5ibHvzlgtBW5bfIt1WGvp2Do8dITnNl7
         jiTbDMu1PJpNfJprYAvYicXrV1/my/az10vsu2ahd9Lmv3M7ZbGQ9k0nyAaYyVjIycZQ
         22AKK7H10PQXJ+R1mCBJCv+E1K/oLYv0jq0Ds=
Received: by 10.204.154.142 with SMTP id o14mr784531bkw.125.1252260990312;
        Sun, 06 Sep 2009 11:16:30 -0700 (PDT)
Received: from darc.lan (p549A55B4.dip.t-dialin.net [84.154.85.180])
        by mx.google.com with ESMTPS id 28sm3886294bwz.20.2009.09.06.11.16.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 11:16:29 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MkMHl-00080p-3l; Sun, 06 Sep 2009 20:16:21 +0200
Content-Disposition: inline
In-Reply-To: <vpqfxb0s177.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127862>

On Sun, Sep 06, 2009 at 02:32:44PM +0200, Matthieu Moy wrote:
> I think it has already been proposed to introduce "git add -a" doing
> what "git add -u" do, but for the full tree.

I like that, actually. AFAICT it's completely analogous to "git commit -a".
We also need something for "git add -A" though.

Do you feel the same way about changing the behavior of "git grep"? I don't
really want to change the command's name.

Clemens
