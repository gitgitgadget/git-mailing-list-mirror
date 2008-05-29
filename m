From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: whomto.pl -- finding out whom to send patches to
Date: Fri, 30 May 2008 00:19:23 +0200
Message-ID: <9a8748490805291519l18a88d1bj6d5ffa2b88c19b1d@mail.gmail.com>
References: <20080529210018.GA5508@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	"Jan Engelhardt" <jengelh@computergmbh.de>,
	"Sverre Rabbelier" <alturin@gmail.com>,
	"Joe Perches" <joe@perches.com>, git@vger.kernel.org
To: "Vegard Nossum" <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 00:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1qTp-0004mt-U7
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 00:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbYE2WT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 18:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbYE2WT0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 18:19:26 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:18993 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbYE2WTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 18:19:25 -0400
Received: by yx-out-2324.google.com with SMTP id 31so415369yxl.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zw4qrHPF9NPNT5P0EeHARWvrs5LQ12r3r5nW6hjbjIk=;
        b=dH2BY8vowWNPGqqL3PDJmJ0d20cQrOPsJRiVtnzLBKbh6ZrMA9MBAEb8bnZatbuDCPFXXqlrO3hrXKOg5Pt7sqaMe2mrgCoUk+FrXbZOY8XD1nVu/HizIOSidR/WC9Hoa8ZINaX4sJPEVW1TBBFnh7Ik0CLWtXX09wGr5+zU9lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SUMWzbVRFouHw0ihnbsEvBqUVXMr6Jphh/6AmPtMCVemYsz+oaNqpY4YmJ4MnqyPKiNJKOlGCEmTeZk+WDl/42g+zwxTMGPSyLe1KZCAPEAqJ02Pp7mmUbT4Ns277LRrG8KJfixSCPHZi7n5Vs1i534dQKhBfkdifYPaymtdjxE=
Received: by 10.150.86.10 with SMTP id j10mr8155217ybb.210.1212099563378;
        Thu, 29 May 2008 15:19:23 -0700 (PDT)
Received: by 10.150.197.4 with HTTP; Thu, 29 May 2008 15:19:23 -0700 (PDT)
In-Reply-To: <20080529210018.GA5508@damson.getinternet.no>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83249>

2008/5/29 Vegard Nossum <vegard.nossum@gmail.com>:
> Hi,
>
> I've written this perl script that takes a patch as input and prints the
> authors/committers of the affected lines, using git-blame as the back end.
>
> (The purpose of this is of course to find out whom to send patches to.)
>
<snip>

The script is nice, but I'd wish it looked at a few other things as well.

When I personally need to determine who to send patches to I do use
'git blame' for some of the addresses, but in addition to that I also
check;

- The comments at the top of the file.  Sometimes there are email
addresses there for relevant people (sometimes just names, but
addresses can then usually be found for those people in CREDITS or
MAINTAINERS).

- Entries in MAINTAINERS that are relevant to the subsystem and/or
file I'm modifying.

- Entries in CREDITS that look relevant to the subsystem and/or file
I'm modifying.

- Names/email addresses in files in Documentation/ that are relevant
to the subsystem/file I'm modifying.

If the script could be made to check all (or just some) of those
sources as well it would be really great.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please http://www.expita.com/nomime.html
