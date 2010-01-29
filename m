From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 19:41:10 +0100
Message-ID: <fabb9a1e1001291041w48776835m9b291923fbb859c3@mail.gmail.com>
References: <20100129012350.GD20488@spearce.org> <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com> 
	<20100129183705.GB22101@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:41:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Navmi-0001Ax-UD
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab0A2Slb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 13:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556Ab0A2Slb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 13:41:31 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:59678 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0A2Sla (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 13:41:30 -0500
Received: by pxi12 with SMTP id 12so1819801pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=cKMzVDHZMSITEnuKXoXQdjhronWqF1UL7/dh9y9TwJ0=;
        b=lv49Zf6HB4j2WhA86BkBaKbzHVM7qTkLimr2EKXN1iks3OsS7LAZFk5YKNi57cHutY
         j/kjETgippbA5hAFOdS3K4j/7nj7yXVfqWMGpm/BaaVCQ92yC/sPDKn3HgHEk0cJtcZM
         86pNAclyxHXjgwCb9hZlzugpvp7U/K3a7tbtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fA2fj2qGMBtylEoTjvgl2/1rdb18O6xbYEqeN+07UvQCaBAEE60zt8U/c8AIUM/jTR
         aFe5JpuBN68+SPXRCDSkUcL3oOuF7n6BFJxxc6riBE0LB4RAtNfvgA1i1bXVk3/j/Whn
         FGa/wFcK7aLSf1uwX5doceZTkWyx05x9LZJA0=
Received: by 10.142.196.3 with SMTP id t3mr810646wff.10.1264790490107; Fri, 29 
	Jan 2010 10:41:30 -0800 (PST)
In-Reply-To: <20100129183705.GB22101@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138337>

Heya,

On Fri, Jan 29, 2010 at 19:37, Shawn O. Pearce <spearce@spearce.org> wrote:
> I was intentionally slating this for maint, to fix a bug a user
> reported when handling large streams.

Ah, sorry, did not notice that.

Speaking of which, how does one figure out what commit a patch
is/could be based on? Couldn't we include that in the part behind the
triple dash?

-- 
Cheers,

Sverre Rabbelier
