From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Setting up Git Server over SSH
Date: Tue, 16 Nov 2010 11:46:01 +0100
Message-ID: <AANLkTimTcnTLLsiLAQZn2EiswB_NAfwru6PX1Vw-kFUW@mail.gmail.com>
References: <B99C7057496B47E48E5ABED7DE6BA51A@denny>
	<AANLkTimF2N-rYFYjOMm5kRRqRueLnmzJGpUoaCK3jsAC@mail.gmail.com>
	<E698106BE2EB405A93D2C3304AF79529@denny>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Dennis <dennisfm@friendlymatch.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 11:46:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIJ3D-0001yi-GR
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 11:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934183Ab0KPKqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 05:46:04 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529Ab0KPKqD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 05:46:03 -0500
Received: by fxm6 with SMTP id 6so328847fxm.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 02:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=T1EecXMQyOHzsfuHYI14zx6Ekl9jWLuEmSYfg/AN50o=;
        b=uDx9CCr33W3aDGMBhJjl4JtlvJWG/5tjk42t+PUcRzZJCV4oaOCbZ5M0wrpE05On/+
         SjPVLeBkY7+IIjgUUyr29KCMfovss159W9qkwEYSSdRWNARWbRwqgDKzsG4MlirhxhDb
         Y6dJf1TixFZ7//82wWGypK15e5OHy5msFcn9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oRMp6ZYxfe1M921/BW393epFIzGUCSen/mduMzOnCFmyCXPgCPx/J7cosxcfF3X49m
         Hh5CHNSlrvp9jgM/wc51pJyctk9RK9F2f96K9mOXnvxGwH1QvjQiE7GjGr1zh5N0ZDgS
         JallfZKXW4WXT8b/T2jcnUyX+hoZ8L51E0sjg=
Received: by 10.223.93.142 with SMTP id v14mr5812576fam.49.1289904361383; Tue,
 16 Nov 2010 02:46:01 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Tue, 16 Nov 2010 02:46:01 -0800 (PST)
In-Reply-To: <E698106BE2EB405A93D2C3304AF79529@denny>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161556>

On Mon, Nov 15, 2010 at 20:14, Dennis <dennisfm@friendlymatch.com> wrote:
> I used OpenSSH instead of Putty
> and that fixed things up.

Does using Putty with this at the top of your .bashrc fix it too:

    if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
    fi

?
