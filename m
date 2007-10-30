From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 12:02:33 -0400
Message-ID: <20071030160232.GB2640@hermes.priv>
References: <20071029174000.GA4449@efreet.light.src> <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org> <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org> <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 17:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImtVV-0001Kl-UA
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 16:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbXJ3P7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 11:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbXJ3P7n
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 11:59:43 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:1644 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbXJ3P7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 11:59:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1917255rvb
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=GwKGJ6c7/UVNcaBdDHfAadfB4fbiYrzWd7jr6TRG/44=;
        b=O/XZtxLURzEHExpi8RMs4Np+/ag4r/iyIoVXyNKc5HiFfcQhG9vfK3Q3iZBf0YRAtv8/yVdMC0e9HQrVbNFHv7F2nD+BMMeIvGzFlpD3vPNgxMyFUS9fNitzqGgxq1TEsYRhifzYdLDg3kZa3EFlqNYSTUQuABWBShK6i1gFL30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=dQKH19cdlWS6Wtf87TsbDc/FfnPNDdegVg5OGvL46BCAOMwAfApIiGM1OhB5Z+8gDAFoLNbTk0awWaNPSUYaorqdTtILsI/Z7MAoXY0cthwPjDqA52QD9wOuywbc5UdDcwiZKTwsFrosDzxlQdm8lpZrrDKAtA3GnXHhaB+/vGY=
Received: by 10.141.48.10 with SMTP id a10mr3412381rvk.1193759981903;
        Tue, 30 Oct 2007 08:59:41 -0700 (PDT)
Received: from hermes ( [70.54.7.143])
        by mx.google.com with ESMTPS id f45sm18209898pyh.2007.10.30.08.59.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2007 08:59:41 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Tue, 30 Oct 2007 12:02:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2007 at 07:59:45AM -0700, Linus Torvalds wrote:
> > Not that I care, but git should probably handle things consistently.
> 
> Git has been, and *is* entirely consistent. It uses convenient repo names. 
> If you don't want to call them url's, then call them "repository name". 
> Call them whatever. But they are 100% obvious, even if there are multiple 
> forms of them (and *none* of the forms do any quoting at all):
> 
>  - <remote shorthand> ("origin")
>  - <path> ("../git.git")
>  - <host>:<path> ("master.kernel.org:/pub/scm/...")
>  - <protocol>://<host>/<path> ("git://repo.or.cz/...")
> 
> See? We may not follow RFC's, but we follow "easy to use".

Well, only the last one actually looks like a URL, so that is the only this
discussion is about. I don't think anyone is suggesting that the first three
be changed at all. So, to use your terminology, git has a variety of ways to
specify a repo name, one of which happens to be a URL (or looks like one). The
suggestion is that we should make that way (and only that way) behave like a
RFC URL.

And git should be consistent with web browsers, automatically quoting things
it gets passed. I think the only point of contention is probably how to deal
with URLs that git receives that are already quoted.

1. We ignore the quoting and re-encode everything for the http transport.
2. We honour the encoding and decode everything for the git transport.
3. We handle git:// and http:// different, so that the three git:// URLs below
refer to different repositories, while the three http:// URLs give refer to
the same repository.

> > git://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> > git://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> > git://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git
> 
> > http://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> > http://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> > http://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git

The third possibility is probably what we do now, which is why I am suggesting
git is inconsistent. The first will fall down when using a repository that is
colocated, and somebody copies a URL from the web browsers location bar (which
will be properly encoded). Which leaves the second.

  Tom
