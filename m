From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: First time compiling source
Date: Tue, 15 Jan 2008 15:01:36 -0600
Message-ID: <c0f2d4110801151301m18f65fa5x29eb8f5b6d3e2ece@mail.gmail.com>
References: <c0f2d4110801151234i2292ad2aw48e38f4f4fcb5ee7@mail.gmail.com>
	 <20080115205603.GA12055@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 22:02:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsvc-0004Wb-8U
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 22:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbYAOVBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 16:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756702AbYAOVBk
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 16:01:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:18959 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbYAOVBi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 16:01:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4545363wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o8cLs6q5QQt+ap0Xd91U8X5SoEzyTnq4cyOEk0VKsoY=;
        b=cFEr3xA9SqijezzgtiXOr2MsetlT4st3Gx2dBtb1jPfRL3fyJwuApFQjmj2GUK9YqII466Bdagl3xezoA8Cbx3G3zKR32eu78mq3avkucZrHPas3q+rV8XnXJCOz0maoSbAEFASMPDPqQL0fQHFa2sVztz74rNT2zV6e7owdc/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RtZBygGj3nB88Fk3e1PyWGGDsDM28cKip6XapKgDfIhWKBy1tepyObglpR8aFWVHY8OT4oGvLoUzOx/fkhG9fD5md7IwGHy42QWmxl1NcB3wKYCFcX9o8PwgHRk+8g7MI1O3T4fGMben8fEQs9fveNvkbdQDlXq38w6SHf3JX0Q=
Received: by 10.115.90.1 with SMTP id s1mr6192926wal.50.1200430896350;
        Tue, 15 Jan 2008 13:01:36 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 13:01:36 -0800 (PST)
In-Reply-To: <20080115205603.GA12055@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70560>

That was it, thanks.

On Jan 15, 2008 2:56 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 15, 2008 at 02:34:12PM -0600, Chris Ortman wrote:
>
> > then to check
> > which git
> > /home/chrisortman/bin/git
> > as expected
> >
> > however git --version still reports 1.5.2.5
> >
> > What did I miss?
>
> Is bash caching the location of git? Try 'type git' in that shell, or
> try running 'git --version' from a new shell.
>
> -Peff
>
