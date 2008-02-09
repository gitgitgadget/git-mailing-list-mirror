From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sat, 09 Feb 2008 11:36:31 -0800 (PST)
Message-ID: <m3abm9hqix.fsf@localhost.localdomain>
References: <20080209162234.GA25533@fieldses.org>
	<alpine.LNX.1.00.0802091251430.13593@iabervon.org>
	<20080209185038.GB25533@fieldses.org>
	<20080209190533.GD25533@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 20:37:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNvVe-0002PX-H4
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 20:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYBITgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 14:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbYBITgf
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 14:36:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:3332 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbYBITgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 14:36:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so84895ugc.16
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=ucAKyFTB1kLuO40KLT6ClZqOhGCIiNLhfHRxkYLbwxQ=;
        b=Ubo3X4AmcDQNHNbKUK0OmSmr3j3pQ+15t4Tn664D74r75zq9J4JsgHA0/TpogEP9u+1ZRnm82SN3uAswqMDcRibFJPD9OM5Gqx5xl8FSmCWrd+krKtTXQ2ZjmfxdIH1Uzk3q1PpdmJ93fSqTvre/CaHjDenM0Xr01CPMlMzcvKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=pi3rIe/NgSreGRCRQRcaQKzaw+lG9jvBGCBfC7//Tf86C94Vp8Ir4dgjAfTJy/HtFASoc2x3Qkjid+PelPnWjabcuOtiPlgyVKz2ZIq5rRySiv7awbtK8z4X+2fhABRcqNRTLVEaWPAs9EdM9kBzFZVyl3OuypBVrx5kE7/GDOk=
Received: by 10.67.119.15 with SMTP id w15mr6952428ugm.73.1202585792494;
        Sat, 09 Feb 2008 11:36:32 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.105])
        by mx.google.com with ESMTPS id o24sm2620062ugd.41.2008.02.09.11.36.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 11:36:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m19JZmpW006475;
	Sat, 9 Feb 2008 20:35:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m19JZIae006470;
	Sat, 9 Feb 2008 20:35:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080209190533.GD25533@fieldses.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73255>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>  gitweb/gitweb.perl                                  |  566 ++--
>  index-pack.c                                        |   30 

gitweb (at my insistence) uses tabs for indent, but spaces for align,
so that the layout is [roughly] preserved independently of the tab
size. IMHO it is superior style, but much harder to check
algorithmically (although I send some sketch of idea how to check that
at least for aligned commands). That is why there is such a big change.

I'd rather have real bugfixes, real documentation improvements, new
features instead of such bikeshedding.  If someone is making a change
somewhere, he/she can fix the whitespace in the neighbourhood.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
