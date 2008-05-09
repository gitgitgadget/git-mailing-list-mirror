From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: mismatch between doc and program in git commit -u (--untracked-files)
Date: Fri, 9 May 2008 22:56:57 +0530
Message-ID: <2e24e5b90805091026l30f8802ek6e97d5ad0d3e0c1e@mail.gmail.com>
References: <2e24e5b90805080310p2cb77814i45a418a0cfc8a2c@mail.gmail.com>
	 <20080508161342.GB28701@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 19:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuWNv-0000WJ-48
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 19:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149AbYEIR1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 13:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757683AbYEIR1E
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 13:27:04 -0400
Received: from ti-out-0910.google.com ([209.85.142.189]:4780 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002AbYEIR1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 13:27:01 -0400
Received: by ti-out-0910.google.com with SMTP id b6so489243tic.23
        for <git@vger.kernel.org>; Fri, 09 May 2008 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ujHYJsu8lVf/eYCOgUFieofQJ7CgW7CD+lPaIexxEOg=;
        b=e0YYXBQ9F2fZq0NZwF993t+c8BRHQVbfob+8RX3N2kz7iNxgyW/YT4jTetz+IwgRD55dvQR1I8XMT+HhK9ytjjw6aPgatRVaMlskH9QIwjxzCjhlzG7q9DSsBTRQ9tz5FYdd9aD7/uktzY87n2oXci+xQnhw6x81VxxXW+Y74UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OXbEh+Z5p9hXpUv52pD6uHQSwniAGVZEycs57R7KV+Egks1CjcL0QR3PDkanDBxE+gms8S942TpRQ5ox5w58DzTbZiONl3baq9c4HTg3cnkrBQ0XWc0Lw+XRDYOTwyt2Ix0Lg3AjcwSUmC3PeISz/y+spbBJalAs5+rj0hc0xb0=
Received: by 10.110.3.8 with SMTP id 8mr464055tic.11.1210354017598;
        Fri, 09 May 2008 10:26:57 -0700 (PDT)
Received: by 10.110.105.1 with HTTP; Fri, 9 May 2008 10:26:57 -0700 (PDT)
In-Reply-To: <20080508161342.GB28701@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81627>

On Thu, May 8, 2008 at 9:43 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 08, 2008 at 03:40:14PM +0530, Sitaram Chamarty wrote:
>> The doc for commit says "-u" is a suitable abbreviation for
>> --untracked-files, but only the latter works.
>>
>> I'll submit a patch, but being new, I thought I'd ask which is correct
>> -- the doc or the code?

> So it should probably be supported. The patch is a one-liner, but I'll
> leave it as an exercise for you. :)

:)

Due to my using gmail which doesn't leave the whitespace alone, I had
to resort to the clumsy trick of doing a "sendmail -oi -t -f
sitaramc@gmail.com" from my home machine, and vger's SMTP listener
decided to greylist the mail.

It'll come through eventually, assuming I keep my laptop switched on
long enough!

(Although pobox.com seems to have accepted it OK.)

Sitaram
