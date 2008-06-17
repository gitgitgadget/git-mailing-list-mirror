From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Guided merge with override
Date: Tue, 17 Jun 2008 11:53:19 +0200
Message-ID: <bd6139dc0806170253r5ea7844dm71d0bc407da2acc7@mail.gmail.com>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
	 <20080616092554.GB29404@genesis.frugalware.org>
	 <48563D6C.8060704@viscovery.net>
	 <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
	 <485756AE.9050904@viscovery.net>
	 <bd6139dc0806170153h4fba934ei62cb06e98e0280fd@mail.gmail.com>
	 <alpine.DEB.1.00.0806171045570.6439@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Geoff Russell" <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8XtN-0000Ug-R3
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 11:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbYFQJxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 05:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754579AbYFQJxU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 05:53:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:11884 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbYFQJxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 05:53:20 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5657559wfd.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1sSGHc22WF5cy2JMQK5u/wFchWswnU8uBE+ZZ/2+BKs=;
        b=ZZUWYEYNWbausbq7utFGTBNRzxHhR1HYINqW1HGUeLWqjipbCih+2ELNYGMB10dsFx
         3JLDY3ygrB/TNevh6DYjY+dNpCzq+jtK2PtSMU+e9hoHQnmAwEmTXANF3tERz5d8WlXp
         7UTz/ZAetaLOJwV1V5gpiejb34w6FBoago5rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=EAsxcb4g2B0dTs13QwwFbhY6AR3gVMOvsg/t9COO9cJ/s/T5D00JHPdC0L0bUwqhs/
         ao7pTSoV2tYRsu/aGqbe3YOjgoeTQrkMHB0tisPp/cEghmrTsgBXXV8gZxI29XuEVXXj
         f6PWQgHmzjPAlOz+XG5ITGqb5UJi4JvCkFyfk=
Received: by 10.142.211.1 with SMTP id j1mr2819988wfg.231.1213696399449;
        Tue, 17 Jun 2008 02:53:19 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 17 Jun 2008 02:53:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806171045570.6439@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85283>

On Tue, Jun 17, 2008 at 11:48 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 17 Jun 2008, Sverre Rabbelier wrote:
>> How about 'git ls-files -t | grep "^M " | xargs git checkout B --',
>
> You probably meant 'sed -n "s/^M //p"' instead of 'grep "^M"', right?

Whoops, yes, that would be a lot better :P.

> Of course, I think that a better way would be to ask "git diff
> --name-only --diff-filter=U".

Hmmm, not having an unfinished merge at hand, would that require the
sed on top too?

-- 
Cheers,

Sverre Rabbelier
