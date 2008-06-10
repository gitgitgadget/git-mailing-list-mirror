From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 15:25:08 -0700
Message-ID: <905315640806101525n26a0a4eic7943613ab9e1a8c@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
	 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
	 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
	 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
	 <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
	 <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org>
	 <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Denis Bueno" <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:26:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6CI3-00087B-HA
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051AbYFJWZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 18:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758004AbYFJWZM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:25:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:51306 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674AbYFJWZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 18:25:11 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1622418fkq.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=aUIIJiSh1aE2G9jn1nsqJaa7drY3yrswhZCac4c3lcY=;
        b=gxyhDJ1K2FjI4QjXAS3SQ7dskW5ssSze5/0kViPB/zen5qUW6FIvb6J5g5pnWRuI9E
         Iqtaiv7ImIJUkpavbon16CMGPGa/Jt8CpYH5oY93btuGpSvZ/wSGpeW+C3s4r6R9Cfdj
         4nhO//uXFH/6ItGYFpdH8KIzEEHqVkQolXPm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=M6BawW/TRJhH3lRgCaONXTGu4TVeRfe0ie9pJqN7P1JHgaVuBGblX213wCz0QRtEu9
         UUgZC+Hudpfxl3RCorZIXw3OZzAgQDCPkTq+SvUCL6rcnoAptu+ATBoiVeo3hfIH+EWm
         je746lGSj/j/Tai+RYHfI6Y/213cDZk/cnWPQ=
Received: by 10.82.151.9 with SMTP id y9mr380361bud.8.1213136708750;
        Tue, 10 Jun 2008 15:25:08 -0700 (PDT)
Received: by 10.82.157.18 with HTTP; Tue, 10 Jun 2008 15:25:08 -0700 (PDT)
In-Reply-To: <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 3f34496ea5e45a19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84553>

On Tue, Jun 10, 2008 at 3:09 PM, Denis Bueno <dbueno@gmail.com> wrote:
> It is the same computer on which the problem occurred last time.  It's
> an OS X 10.4 macbook pro.  I haven't noticed corruption in other
> places, but it's fair to assume it's occurring.  I'll have to boot off
> my install disk and fsck the drive....

Do you have fink installed?  Do you have the openssl fink package
installed?  Vger seems to have swallowed my original reply, but see
this thread:
http://marc.info/?l=git&m=120787191106549&w=2
If so, try removing the fink openssl packages and reinstalling git.

Do you push from this machine often?  If you do, then this probably is
not your problem as you would have seen it earlier.

-Tarmigan
