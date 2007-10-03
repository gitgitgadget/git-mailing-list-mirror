From: "Chris Larson" <clarson@kergoth.com>
Subject: Re: [PATCH] Mention 'cpio' dependency in INSTALL
Date: Tue, 2 Oct 2007 23:09:08 -0700
Message-ID: <b6ebd0a50710022309n774afe5bpa995de6d8e4568ec@mail.gmail.com>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
	 <200710012342.37352.johan@herland.net>
	 <3f4fd2640710021409q104a4204r522391912d5b5c8c@mail.gmail.com>
	 <200710030142.30062.johan@herland.net>
	 <7v1wcdjbq6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 08:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcxQ9-0003sL-6f
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 08:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbXJCGJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 02:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbXJCGJL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 02:09:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:54696 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbXJCGJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 02:09:10 -0400
Received: by wr-out-0506.google.com with SMTP id 36so2357630wra
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=9xCftlsJcDbtHQf2uhiz0v27RSEO7cC615HJAYe24tA=;
        b=FlJDKCmogJGi3tJNgXfgWLF0fWSkoB4RMuzyOQA7Qr3WBX99PjXoYTXCuuHNrW0+6r+2Znt0y8GObuS5Pfq8ThOxwMW29Ns+7JB3JUyshqoJMftR1Qm8HR+OABJTfwMbSssEKhYVEB1ZZ6jqJIEC+x+oRUw2OThrpljS4SCLjhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FARO8uKGRiPuCqLjCm25+pZce/XaV8cX+VkEvwJ0iw/wrjds7g5UFuux3+wRXrIt4R8WGx+9G4gkrAlbwzy0tRSoab6raIekrR2yl6bdy1MrSvui7+8W9AEIwUeRkJCCp3VnybFm0hBwTwhiH6WQT0s+JjA7fPpCxZH6TC/fnZU=
Received: by 10.142.240.9 with SMTP id n9mr339649wfh.1191391748332;
        Tue, 02 Oct 2007 23:09:08 -0700 (PDT)
Received: by 10.142.81.6 with HTTP; Tue, 2 Oct 2007 23:09:08 -0700 (PDT)
In-Reply-To: <7v1wcdjbq6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: bc513cf367903475
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59794>

On 10/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
> > reveals that cpio is not mentioned anywhere in the documentation,
> > nor in the requirements section of the INSTALL file.
>
> Thanks.
>
> We use many other tools that are typically found in bog-standard
> UNIX environments, like sed, echo, cat, sort, etc. and we do not
> list them in the INSTALL file (nor we would want to).  cpio used
> to be in the "bog standard" category but perhaps Linux distros
> do not install it by default, so it is worth listing it there.
>
> Are there other commands we rely on that may not be universally
> installed?  I myself consider "cut" to be in the category, but
> other than that I do not think of anything offhand.

I'd think it might be a good idea to list any utilities used that
aren't in, say, the Single Unix Specification, for example.
-- 
Chris Larson - clarson at kergoth dot com
Software Engineer - MontaVista - clarson at mvista dot com
Core Developer/Architect - TSLib, BitBake, OpenEmbedded, OpenZaurus
