From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Mysterious junk in file.... "not commited yet"
Date: Mon, 5 Apr 2010 14:52:26 -0400
Message-ID: <o2n32541b131004051152ie6c82b3wdab0f38a9e657943@mail.gmail.com>
References: <i2v26ae428a1004051113q68a0cf13o65fbf1349f941648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:52:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrPo-00070p-U5
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab0DESws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 14:52:48 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:37750 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab0DESwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:52:47 -0400
Received: by ywh2 with SMTP id 2so2601465ywh.33
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=E88rbzEmb2q36HVBZEVD6JXlBwbDPjF+4n4Rnr9He8c=;
        b=ozNzWJtlEno0SS72TpDbzQZl/FvEbPmGBvwcoonfQ/c8/ImB+QtPi7ZReT4wOlSIyp
         kVA+8jY74VcplbbRjptp0RG3GePiqtuDZ+saE1NVghBw0FdJ0uEnEdaLZpTw7FElwspJ
         PAW7vrEoNGg6sAfm7lkjqEwWWx9+O0fdKjWlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=yEEoWhwsYIHA5esZT0KKyEqPAXdhbRkKPY6k0AF9Aeli9GdDWr1dk4ZtNJsIXy//Ke
         tNYBf3hbpjvMjW23dmCL1C0uMefVOwHox9I0AtWUP/ZecONs+obQPxDqS684r5E5RhYr
         +ZI8h3OMgk/o1v/wAn+kvAC1XegKYPPpy3l3o=
Received: by 10.150.199.19 with HTTP; Mon, 5 Apr 2010 11:52:26 -0700 (PDT)
In-Reply-To: <i2v26ae428a1004051113q68a0cf13o65fbf1349f941648@mail.gmail.com>
Received: by 10.150.165.20 with SMTP id n20mr4547896ybe.316.1270493566440; 
	Mon, 05 Apr 2010 11:52:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144046>

On Mon, Apr 5, 2010 at 2:13 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> I just found a file in my project that has "junk" at the beginning
> (looks like some binary stuff at the start of a php file). Git status
> and diff show nothing unusual (nothing to commit). Git log shows
> nothing I wouldn't expect and show 'shows' show noting. Git blame on
> the other shows the offending line as 'not commited yet'. I tried
> doing 'git checkout <filename>' but it didn't fix it.
>
> What am I missing? Has git broken somewhere?

You might have 'git add'ed the changed line.  Try this:

   git checkout HEAD -- <filename>

Have fun,

Avery
