From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Wed, 4 Nov 2009 07:28:54 +0530
Message-ID: <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
	 <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
	 <1257295737457-3942366.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 02:59:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5V9J-0004nc-JX
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 02:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZKDB6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 20:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbZKDB6t
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 20:58:49 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:47332 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZKDB6t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 20:58:49 -0500
Received: by iwn10 with SMTP id 10so4624082iwn.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 17:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=x7HQ1gltS2jFaKdxPbP0RUsgwr3AZeg2vWBNZxI/VAg=;
        b=XwCmP1P/AT8cLNzpD9DL5w+sDFsxUE+ejrqK6twIq1r5bKc2ZVIFMq4SqjBZsaZESJ
         MLozoLKDsEmZoeBuSQXnuMnasg+Yn+cv3+DpK77G+5SYaD+4mDENnWQf3bZRIB0dVrno
         //WtW3x6FN5yh3P9435EY+hAsH5hzjOWozcOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cJ8qwS7HmwIkjTxFh1BG6GYJxkDJPzSENPrZo5nwiR3WbSqHe6fijH0SK4cQS5rgU3
         mtqqoVynGWLa5XDTch1/2Qv/ha+HghCAgFbtUZtpiCYC7HNaXwfqhQmRpdEq40hoOnUw
         JAvoUH7BgDeoGY6Fhhib1Vrwe2dbYPwTuo+n8=
Received: by 10.231.40.216 with SMTP id l24mr2251152ibe.40.1257299934501; Tue, 
	03 Nov 2009 17:58:54 -0800 (PST)
In-Reply-To: <1257295737457-3942366.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132022>

On Wed, Nov 4, 2009 at 6:18 AM, Tim Mazid <timmazid@hotmail.com> wrote:

> Might be better to include a configuration option to allow this, for those
> that know what they're doing. Most of the people that know what they're
> doing will use the command line, anyway, but it may irritate some people.

I considered that but found my tcl fu was seriously lacking.  These
are literally the first 3 lines of tcl I ever wrote in my life, and
this program is one huge 11,000+ line monolith, so I'm naturally
scared to make more than very, very, small changes :)

In any case, as you said, most people who know what they're doing can
use the CLI to get there anyway...
