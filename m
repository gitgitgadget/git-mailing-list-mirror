From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git 
	directory
Date: Wed, 4 Nov 2009 23:06:05 +0100
Message-ID: <fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-12-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041621400.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 23:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nzt-0007kk-1R
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 23:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbZKDWGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 17:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbZKDWGV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 17:06:21 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47197 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbZKDWGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 17:06:20 -0500
Received: by bwz27 with SMTP id 27so9405848bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 14:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FYoj9J1Moiop9Gsf2DtY2XCEkqpMHKQ2pacFqe1NNoY=;
        b=OuOmnWFwn0WUeScDDEv8vXrBYQMaCDInzCHqKubClFqFGZSDS0T2sHiLUQAc9aQp+M
         Z5EY6pN2ERTkR/+iolvQMdrPIyk1TRy339+dVvP3URWA8yAe8FJ1V/H9nVboXPta8Pav
         eUTeeVKYg1gAC3v5ZjzWTXJU1AsjL2O7FbPco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OT6jsfp9Rjfj/DoOOAaM68xGOSZYs+G44x2Fhu7NgwHXlhutI3uuYtueSyHAFmDCJM
         44iYT1HfTVDjSOdMXGtZLb80JMJ6i8i63cpmz1t6haA0UrXat4gd7z1kTwroHU9F/vSc
         4hWYGo27Y0eAeAEzxS8OWe7KTLz3SNkPOnx8E=
Received: by 10.204.34.199 with SMTP id m7mr2128123bkd.48.1257372385126; Wed, 
	04 Nov 2009 14:06:25 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911041621400.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132160>

Heya,

On Wed, Nov 4, 2009 at 22:35, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I thought we cd into the repository in the middle of clone somewhere,
> before running stuff.

It does, but not soon enough, that is, not before I needed it in my helper.

> In any case, I think it would be good to have
> something like that, but I think maybe we should tell it where it can put
> its status files, rather than telling it where the .git dir is.

Yes, that would probably be a good idea, .git/info/remote-<vcs>/<alias> perhaps?

> It would
> also be nice if this is the absolute path that gfi will base a relative
> path for the "marks" options on when importing.

The marks option has been dumped in favor of 'feature import-marks='
and 'feature export-marks=' which will be in the reroll of
sr/gfi-options.

-- 
Cheers,

Sverre Rabbelier
