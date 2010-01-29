From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 19:35:31 +0100
Message-ID: <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
References: <20100129012350.GD20488@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:35:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NavhG-00063H-BX
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab0A2Sfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 13:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166Ab0A2Sfx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 13:35:53 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34060 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab0A2Sfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 13:35:52 -0500
Received: by pzk1 with SMTP id 1so2223126pzk.16
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 10:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=3miKnljouF1h7fvItMXg7lr6LxNI1JgoJJvI7gPXfF8=;
        b=XDxg/6+92fUF9PJYguN5KLdoZwHLhKjPgtVD/tX0JlzJk5wGT6kkswBMxDAgbVx3ZB
         EzEUUls54SDGLVnAVl4etj/n732RkDlG99aZKTQw1bSlZO8U9dBAEAYEbleg0dE1F8Oo
         Os2pCWqCPYsAPChwJt7kAfzhd0d+JGUkyx6n4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=n5PeA7JufomfbXghMpAUhqqVZVjRC1YFjcDjbsfvOY4dQtopeGaeK9IPDORJ2nWU1D
         6w3J/2SRHHktcNvqsaWilzT3AnBP6e4H0ptnl/+07umcQ3LiEGVoXafwu5zCicokckSy
         iOOxO2N5y3J2elNNCSFe7Ts8ek/A8qk1Nn7gw=
Received: by 10.142.247.1 with SMTP id u1mr798094wfh.249.1264790151087; Fri, 
	29 Jan 2010 10:35:51 -0800 (PST)
In-Reply-To: <20100129012350.GD20488@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138335>

Heya,

On Fri, Jan 29, 2010 at 02:23, Shawn O. Pearce <spearce@spearce.org> wrote:
> index 60d0aa2..8114f93 100644

Looks like you based it off an old version of fast-import, at least
not on what is in master atm, since that has my fast-import series.
Rebasing shouldn't be too hard, you'll just have to move the option
parsing to the appropriate function.

-- 
Cheers,

Sverre Rabbelier
