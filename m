From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: path/to/some/file: needs update
Date: Fri, 3 Dec 2010 12:52:51 -0600
Message-ID: <20101203185250.GA14049@burratino>
References: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 19:53:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POaku-0002ku-OV
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 19:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab0LCSxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 13:53:11 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57715 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0LCSxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 13:53:10 -0500
Received: by fxm20 with SMTP id 20so2497080fxm.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 10:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VC/XePz/2u0oHwBm95oXugKRCECFzdLyP9rVkIiQ0wA=;
        b=C4jypALuHADciluRw4W5emFe5tGholifew5nUF4KT4aUFZLcfzCPEqbEsJoGGictSP
         pLIRiR3WtRutOWijceNPgmIeDlPvoxJZ62NE3yvNOE4D9OQ3Kl+MId18XdzD/O3YVrYJ
         nTwF/4FYGJDPhaRGxgxGHe7PlrjqakJurEGCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Mo3XElIkJMKkkvuALXbXhatq4VCXzDHp9OSh3WXEYXpicUqQm1KFjTYn1qXgQN7qh0
         yzXNzRgr4JwFrbgnjYzYDMH8ODnBRDY44qbPVW/uB05kag8Kf2EDx1CEBsuOkJVlXfk+
         h6k1ypcX0F1Bn2E+qla4zVcUWgXYTwGwDMPOE=
Received: by 10.223.79.13 with SMTP id n13mr2572844fak.139.1291402388736;
        Fri, 03 Dec 2010 10:53:08 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id r24sm745869fax.27.2010.12.03.10.53.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 10:53:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162824>

Hi,

Patrick Doyle wrote:

> Needless to say, I was able to calm them down.  But it occurred to me
> that "needs update" isn't necessarily the most helpful message and
> that "error: ... Cannot merge" could offer a little more explanation.
>
> I'm happy to submit the trivial patch changing "needs update" to
> "locally modified".  I suspect there might be some ramifications in
> terms of scripts that expect the old message to be there
[...]
> What do folks think?

I think you are quite right, on both counts.

See v1.6.0-rc0~4 ("needs update" considered harmful, 2008-07-20) and
v1.5.6-rc0~7^2 (unpack-trees: allow Porcelain to give different error
messages, 2008-05-17) for inspiration.  Do you remember which
porcelain command was making trouble in this example?
