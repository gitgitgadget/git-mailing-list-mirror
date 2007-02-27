From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 13:53:21 +0100
Message-ID: <81b0412b0702270453ib2398a7q4b348a8677f5ac1e@mail.gmail.com>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
	 <81b0412b0702270449r7aced195xa0a24af78d94243a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 27 13:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1pe-0000Yo-O8
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbXB0MxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030614AbXB0MxY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:53:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:16778 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030603AbXB0MxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:53:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1094058uga
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 04:53:22 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LlvKlPwTokKXB55uPnq1G9O5BLX5mItW6AOJId0Mz/iDitV5WJi79FPPBWuTfHm25nvS77TyVriTfeyucWAASSoxebmmY4u4XRn1ppGD+txHEb/rll7vRD6jP3UJjyydMcDvq3omlaHEEjE2WnkCiSre+H31chVQeUr7Xd909E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EBqO30T/wix8JHK+GMwHWwekfFRrLYY0GRw4LAQEuvXlwc0Y1BUNMGBc56QJMdKZLNj3ceYfOj1QLc6wqi0ww/e91vX6WwfF9IJQfkP4+woPjiYi7/0yHCK5x3B7mFVBXmH9r9w3OB9XdeJPb5xYQwtZyo98iZ0K+XCuZd+Wix4=
Received: by 10.78.81.20 with SMTP id e20mr569888hub.1172580801510;
        Tue, 27 Feb 2007 04:53:21 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 27 Feb 2007 04:53:21 -0800 (PST)
In-Reply-To: <81b0412b0702270449r7aced195xa0a24af78d94243a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40726>

On 2/27/07, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> git cat-file -p <objname>:file
>
> I.e.: git cat-file v1.37:e2fsck/pass1.c
>

Err... With -p (for pretty).

  git cat-file -p v1.37:e2fsck/pass1.c

This outputs just the file, not prettifying, actually.

Btw, for broken OS (and not to be named broken workarounds
for the broken OS') we probably need "-o <output-file>".
I forget what it was, but something used to mangle pipes on windows.
