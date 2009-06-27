From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 1/9] gitweb: refactor author name insertion
Date: Sat, 27 Jun 2009 17:48:33 +0200
Message-ID: <cb7bb73a0906270848q64c76bb3ye24a2d5388cf3c6c@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906271624.52372.jnareb@gmail.com>
	 <cb7bb73a0906270826y45f3f9f1lec720aa4dad2a237@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 17:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKa8z-00010Z-WF
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 17:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbZF0Psc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 11:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbZF0Psb
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 11:48:31 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:59751 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbZF0Psb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 11:48:31 -0400
Received: by bwz9 with SMTP id 9so2519023bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FAZTu0BNWAUzXjTCDsCGSLG6yYC1CK7vqPPjfVpxPxI=;
        b=Evn3qFSjogrrpx7ynA+ADe5qg011RotVTOtLvcV3Z8P2Kdazq7zbSG75oeM5GHxka8
         hYouB4zMzoJ8VyxuNkGgvTP+OX8O119E6OS7V8oh5enAaOwvZtp1iWWrRRtz2Gvv0Xzi
         s7WtZYIEOxW9fPL8S7pmWQd4YzC4YY0Heetmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IH7kbfFQphEUvOquTCqJdLZDZoQMUAq+v4oibhOdQkbZ4qYqDPO8naSw8+TAZ37aav
         VKcP/O9Gu8SW5+Rh/YiLkhXr6yIVQ8IzNTlBVCV1xKrZl6cy7/LRhVL2oUmxjKyQC/KB
         27WzncFufPz1WLw2dyaVu1CBgeJbQD1adcE4o=
Received: by 10.204.122.200 with SMTP id m8mr4940238bkr.176.1246117713329; 
	Sat, 27 Jun 2009 08:48:33 -0700 (PDT)
In-Reply-To: <cb7bb73a0906270826y45f3f9f1lec720aa4dad2a237@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122368>

On Sat, Jun 27, 2009 at 5:26 PM, Giuseppe
Bilotta<giuseppe.bilotta@gmail.com> wrote:
> 2009/6/27 Jakub Narebski <jnareb@gmail.com>:
>> By the way, this "atnight" warning is duplicated in subroutine below
>> git_print_authorship_rows(), but IMHO it is not something very important.
>> It can be left for later.
>
> I'll resend this patch, with this thing refactored too, and with the
> localtime fix.

Eh, the refactoring caused a chain of changes in some of the following
patches, so I'll wait a bit before resending. In the mean time, the
new patchset can be found here:
http://git.oblomov.eu/git/shortlog/next..refs/tags/gitweb/avatar7bis

[BTW, for some reason
http://git.oblomov.eu/git/shortlog/next..gitweb/avatar7bis gives a 404
instead]

-- 
Giuseppe "Oblomov" Bilotta
