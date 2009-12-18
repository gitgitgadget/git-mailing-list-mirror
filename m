From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 13:37:03 -0600
Message-ID: <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net> 
	<7v4onoywws.fsf@alter.siamese.dyndns.org> <200912182004.25520.j.sixt@viscovery.net> 
	<7voclwxemf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 20:38:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLieA-000482-9h
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 20:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbZLRThg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 14:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbZLRTha
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 14:37:30 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:60860 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZLRThX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 14:37:23 -0500
Received: by vws30 with SMTP id 30so1105531vws.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 11:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=cvg0RAf6uAttmB8XrLdlXnWK/NMu+/qunMCTDZcCPJU=;
        b=bBniPId6ImZxsm1Wz6RgWfSVJnrUdcTp0LFZphBRbOdTsv9rN7xpVcxJiaP2/v3jfA
         7FI5m+8CHd0SiO8urDDCwQDxwS71AlckSuVcC+77+qfTbjCG96Hgxh4c4XldUSv0uOIx
         JFkubM5TP7nmcpQXKIH4AWv0iQK5ykiip9LuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cDqIMJUS6ihfhpBYh36zYAPYpd2k6W9TPa1/GQWDbB7yi+5R3gIwqKKp4jXPSme/bU
         WHeOx16TU9qPTmCPRj7PI+TUji/K2gBiq1goG/FLj+3OxIDHlthKtjTJ+8YUMkeWHF9S
         QvTTFVt4aZtoSHd5wuzaGUmCnvJ/ZWVKvq58w=
Received: by 10.220.127.2 with SMTP id e2mr3110847vcs.70.1261165043121; Fri, 
	18 Dec 2009 11:37:23 -0800 (PST)
In-Reply-To: <7voclwxemf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135432>

Heya,

On Fri, Dec 18, 2009 at 13:32, Junio C Hamano <gitster@pobox.com> wrote:
> Sure, it will empty the index, so it is dangerous in the same sense that
> "reset --hard" is dangerous because it will wipe all your local changes,
> or "rm -rf it" will remove everything underneath it.

With the difference that both 'reset --hard' and 'rm -rf' need a flag
to do their destructive work? Although 'git reset' might be just as
destructive if you've been using 'git add -p' a lot or something,
mhh...

-- 
Cheers,

Sverre Rabbelier
