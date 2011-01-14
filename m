From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 13:02:48 -0500
Message-ID: <AANLkTikM5cX1Jbo8m6bwoUPq1q-BLQ5VL_L=1QspE=Xj@mail.gmail.com>
References: <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net> <AANLkTimcQq++CLv66AyTve+PiXBhYdUPk2epCyOXX1c0@mail.gmail.com>
 <20110114163333.GA1230@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 14 19:03:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdnzi-0000st-SA
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 19:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495Ab1ANSDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 13:03:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757071Ab1ANSDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 13:03:21 -0500
Received: by iyj18 with SMTP id 18so2730658iyj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=g6Rp6/E8cq1t5AshzWFXuFtYNFNUteGc/SYkgTBgk4I=;
        b=mgUWbntQROZwe/fksJPL38yR94Cl2/cBgMFymFQ89SpnxP9vMay2/iiuMJyrWVbx2P
         XJhTG+fVZGqfNMYEpnblF7fUD9QisklETwT9vhuPg7VF7b95+6m8OcY4sPKHXmLo9faH
         MGKKI3K9kanfz/4IU2e5YeSSVOsu82nFqadwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JWe/O8lSw5nbzKvLK2118mvWbp9pr7jIJY474k2CBR02MpdtdSooRPpf+L5NbQxj0x
         OkiXaarwvihjvNzSXdCPmCzao8vwH611J/7IRfZrquO2A4a0DRcYEGXIV1cGB9yok/PW
         B/4kNUG2DfC1HXly6pUoSrmkZapapKuu50SyU=
Received: by 10.231.11.204 with SMTP id u12mr1018778ibu.109.1295028200552;
 Fri, 14 Jan 2011 10:03:20 -0800 (PST)
Received: by 10.231.167.78 with HTTP; Fri, 14 Jan 2011 10:02:48 -0800 (PST)
In-Reply-To: <20110114163333.GA1230@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165116>

On Fri, Jan 14, 2011 at 11:33 AM, Jeff King <peff@peff.net> wrote:
> Even if we remove the check, it may still be worthwhile to say "Just so
> you know, older versions of git may mangle the name you have chosen".

I knew this conversation sounded familiar. It came up before in a
different context:

http://thread.gmane.org/gmane.comp.version-control.git/150871/focus=150902

j.
