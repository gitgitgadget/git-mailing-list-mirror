From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Add USER environment variable to executed git commands 
	when serving
Date: Wed, 3 Jun 2009 06:34:56 +0530
Message-ID: <2e24e5b90906021804tf3db263qc41a6f8b171111e1@mail.gmail.com>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
	 <20090602135659.GA4320@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tv@eagain.net
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 03:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBeue-0003md-Or
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 03:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZFCBE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 21:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbZFCBEz
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 21:04:55 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:9038 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbZFCBEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 21:04:55 -0400
Received: by qw-out-2122.google.com with SMTP id 5so5904301qwd.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 18:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6daMAyYq5stNxGoj1rDJ5etQbEv+f94saC1wt7bTDwU=;
        b=SB2A9xZy52FFfv9u7Dl8y3Ln5XLOnJR3NRGWFhwVZtc0j3GYHeU6/ZWJjPrnFsjlWm
         Js8WBUOM6HE5zflAEAVQLUE3w/Aiw2cglwm44TASgaMRL4iFBvC3LMCxZW6xAPXLxVw2
         AkaBk3HGI/4bYue3nOxsbWhdv8Yep9uejtJ4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pYihFtMnA0VrlKiqjXMeIssiq6MLu1IGIV4TAgs81dnuSDhTZPlpRIjcqp333U3UiY
         ieVLgJF1ukr5aqgtXq1FcwH0sTwxr309ugyFDFhBUvdZ7D4YHk6TiWhj92buT0iZiOel
         AgOpQdjYPmIHNWVTTRRMrK7ZdZ6oDQ1CbeIEo=
Received: by 10.231.14.133 with SMTP id g5mr96246iba.27.1243991096572; Tue, 02 
	Jun 2009 18:04:56 -0700 (PDT)
In-Reply-To: <20090602135659.GA4320@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120568>

On Tue, Jun 2, 2009 at 7:26 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> This is useful if you want to implement access rights by branchname.

I see this as more fundamental than any specific purpose.  Right now,
gitosis completely loses information on "who did this push", and this
fills that basic need.

And thanks for a patch that's even simpler than what I was *thinking*
of doing :-)

I will test it out today at work and report back but it should work; I
don't see why it wouldn't, unless somewhere else there's a
sanitisation of env vars going on for security.

Regards,

Sitaram
