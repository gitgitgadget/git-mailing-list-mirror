From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Possible Solaris problem in 'checkout_entry()'
Date: Mon, 17 Mar 2008 11:23:27 -0400
Message-ID: <118833cc0803170823q1e1e29a9p18b9a41f6975e268@mail.gmail.com>
References: <alpine.LFD.1.00.0803170756390.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 16:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbHC5-0003vA-Lo
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbYCQPX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbYCQPX3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:23:29 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:43442 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbYCQPX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:23:29 -0400
Received: by an-out-0708.google.com with SMTP id d31so1292314and.103
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=txyRR4KgJsl844+Op3iBuHx68UzH6J+u5NVytiqdOH0=;
        b=c5LXultGQ0wu/YDZANuuotj4ACdl+zsLJqrhSk0R8ePhsvlk7LFAra9ArZQoOpgH2SDSTr5rqhiBb7YA8g1i/VMS9rBVG9vnJneAC2OgSuC5fqqo8Vj1P9a58HX1r6HhvmKnKfcfzv8dP9M7dBmq9xuQxKBZe4aaLO7yLjQ0We0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJmDRYk1y/EB3BQFLfAlBQX6y4Ansrl1gTplrnze5SdkNF4Qcdxee+W0ZEbqM1nJ0/RVCxwoPBf3AG8RoJeaCC36cdpo/FZrUp3GyEIiwq1IdiKO7QRqFy1On+PIrKZ0H+Qv7m1gerzyMWzkSoEMogbKICsf27hxCDpmML7AgIg=
Received: by 10.100.41.16 with SMTP id o16mr32804594ano.73.1205767408051;
        Mon, 17 Mar 2008 08:23:28 -0700 (PDT)
Received: by 10.100.131.6 with HTTP; Mon, 17 Mar 2008 08:23:27 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.00.0803170756390.3020@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77440>

>                 unlink(path);

And checking the result from unlink might not hurt either.

Morten
