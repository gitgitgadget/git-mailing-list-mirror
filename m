From: Aghiles <aghilesk@gmail.com>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 16:18:37 -0400
Message-ID: <z2m3abd05a91004141318mdf91a7aapf66b742192fc44a3@mail.gmail.com>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com> 
	<slrnhsba0k.h9q.heipei@dualtron.heipei.net> <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com> 
	<20100414194552.GA5178@dualtron.lan> <w2s3abd05a91004141305h28d69d44g2fcb69abe578dbcc@mail.gmail.com> 
	<r2rfabb9a1e1004141311sa27dedf2h8bfff789a6ef1200@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O293B-0000Gq-1O
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540Ab0DNUS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:18:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53939 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab0DNUS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:18:58 -0400
Received: by wyb39 with SMTP id 39so114983wyb.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=vO1E13+l4150+cK3F5k7jV7GKfnDIKecV70PcofQWXU=;
        b=cnPEWrMu7hXbspWrNl9+B7MYFEufgcFpD6HkgcoqpVTrh4riPmjnogvUahAKzsyIoY
         Wd7SixBsnwhNKcEzmoNzNodj4Qz2B47tDJejA2zu7P1vu4UO8mvEtebowrQ+pTJA+HLy
         cZXdxGke1ZZ6oCml5Dl1RKU/jxIeX0CiSCkY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=k+ud/DsNyXb9aqlfNoP92Jr+NFrXbzNpI6VYT26NBn06WPpGbKnvC0LrV0rU/CGXGM
         Ijpoa/TWFcdzNwpHWLXaAxsH+1wqf6C7x45Sxs6MwF2aRCbXQOx8oe4MmxnJAwI5g9aQ
         h1Rio3+wyehpHosV4WpJUaybEwMPY4abmG0rA=
Received: by 10.216.157.212 with HTTP; Wed, 14 Apr 2010 13:18:37 -0700 (PDT)
In-Reply-To: <r2rfabb9a1e1004141311sa27dedf2h8bfff789a6ef1200@mail.gmail.com>
Received: by 10.216.86.142 with SMTP id w14mr5656987wee.33.1271276337309; Wed, 
	14 Apr 2010 13:18:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144904>

On Wed, Apr 14, 2010, Sverre Rabbelier wrote:
> This can be done as said before, by fetching (which does not touch
> your working copy, it only adds some objects to your store). Can you
> explain what your hesitation to doing the fetch is? Are the objects
> stored on the server (potentially) very large?

Yes, size can be an issue. Additionally, git fetch will probably update
some references, like FETCH_HEAD, no ? I might want these
untouched, if possible.

  -- aghiles
