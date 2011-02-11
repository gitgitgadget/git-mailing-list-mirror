From: Frank Li <lznuaa@gmail.com>
Subject: Re: [msysGit] git-svn.perl should check GIT_ASKPASS environment
Date: Fri, 11 Feb 2011 17:37:03 +0800
Message-ID: <AANLkTik9mFNsqFQn5SEZkYd_uxDeoY-9nqgV_PJ+nNsi@mail.gmail.com>
References: <1c47e93c-5b7c-4aed-8a78-807d3aff2700@n36g2000pre.googlegroups.com>
	<AANLkTinkv0dNxNxehud0Byuu9tpqxp1kBMJ1OyEcfVQ_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jose Roberto Garcia Chico <jose@toro-asia.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 11 10:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnpRF-0003Yf-D8
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 10:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab1BKJhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 04:37:06 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39678 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002Ab1BKJhE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 04:37:04 -0500
Received: by iwn9 with SMTP id 9so2221269iwn.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 01:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DwUhDoIeeApAqVCJ84pZY5KhdiUTzF7k9+rHw63G1rE=;
        b=ENu9qTCcBorXaw4NctVvuY4it3xbr8ZFEbM3OF2kJ+izHcFW+ZKyEtJz0m01MsEWcv
         6f6CUhGvK1qLgNqRAaqeMfMKjpb5uaNCpcTAO81j7FUUvmcwbr3jshBPOKbe45Qk3rVo
         8XyZ6luRRw5bHzXjnHYO+vVi5mcrVfX0nSagE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AySAc3pIHNMq2kUDJrgfSIdaqEPAJUecjpquP2YtjSSCmrBi512ZQshUYKjSmAYl8G
         veZBqLux8xCHN2Tx502jH3lxufnHeil2UDYgs40Fo8OU3ykstqHbpLNZrLG3kkFk56M8
         Uj9AB6jT7SKHJIEaJN8JNjoMx2HCIabFIBoc0=
Received: by 10.231.10.197 with SMTP id q5mr189382ibq.197.1297417023942; Fri,
 11 Feb 2011 01:37:03 -0800 (PST)
Received: by 10.231.33.73 with HTTP; Fri, 11 Feb 2011 01:37:03 -0800 (PST)
In-Reply-To: <AANLkTinkv0dNxNxehud0Byuu9tpqxp1kBMJ1OyEcfVQ_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166547>

> But I don't think it should check GIT_ASKPASS, GIT_ASKPASS isn't a
> general-purpose dialog-box hook, it's a hook for getting *passwords*.
> To allow git-svn to query the user of a non-terminal user, another
> mechanism would probably be created. But in any case, I we should do
> something other than just waiting if we're not connected to a TTY. I
> don't really know Perl that well, but perhaps something like this does
> the trick?
>

SSH_ASKPASS is used to accept "Enter your OpenSSH passphrase".
refer to git-gui/git-gui--askpass

GIT_ASKPASS should be similar with SSH_ASKPASS.
git-svn can use GIT_ASKPASS hook to launch third part application to
accept certification.
