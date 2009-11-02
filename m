From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Mon, 2 Nov 2009 16:12:59 +0100
Message-ID: <fabb9a1e0911020712q4920e009w5a6d435be205b68e@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-7-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300221290.14365@iabervon.org> 
	<fabb9a1e0910300557x42d3612pf7e83907e91efdc9@mail.gmail.com> 
	<alpine.LNX.2.00.0910301118070.14365@iabervon.org> <fabb9a1e0911011733o7d8d95eem57e02d455e0bd86@mail.gmail.com> 
	<alpine.LNX.2.00.0911012038120.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:15:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4ycg-0003fP-86
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbZKBPOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 10:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbZKBPOr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:14:47 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36151 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbZKBPOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:14:46 -0500
Received: by bwz27 with SMTP id 27so6413994bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xaXVnS/rJHy9ZJ7CrtoSDu6FnW1n+adz+zAoHKq5va0=;
        b=Dt0yNc1jqZxeYFPy79Zu4FK922WuoVNpPvJ4rF5nj61/MtxwPB9Q4AT+xP3056mnSo
         dA5CdImyT8H+vluIDLWhsDbPzWgxVRp7C6Wu48BSp4zS21v+oycj5Mj2Ip7PI8jf9Zv/
         hOP+lBP2j9RLLwnpr8GXmP47Fi3wHNZ0u4Upw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sTQG0gEqIY0cBdmHHk3oS5bBtyCSTawDQTcqKplRjySsD1qG2eCBl5gTaoKT+vIKCw
         vCVgg6zgmi6gZAQ0X9opm/T4y2tRQQoC1HxFR4AsemLDuAaG2uDJuQ1h1amWGKsItGI+
         Rhual+MwwoeRpPT5pZRmoRRiY3zMwgw+Ia0y8=
Received: by 10.204.10.135 with SMTP id p7mr4104304bkp.69.1257174889858; Mon, 
	02 Nov 2009 07:14:49 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911012038120.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131913>

Heya,

On Mon, Nov 2, 2009 at 04:16, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Why not have the regular list report:
>
> @refs/heads/trunkr HEAD
>
> or whatever it is, again like native git? That is, SVN would have an
> interaction like:

That's fine with me, but earlier you said you didn't like the whole
symlinking idea.

You said in another thread you'll be working on some patches, does
that include this 'refs' command? I want to avoid duplicate work if
possible :).

-- 
Cheers,

Sverre Rabbelier
