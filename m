From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 01:37:32 -0400
Message-ID: <20071030053732.GA16963@hermes.priv>
References: <20071027204757.GA3058@efreet.light.src> <Pine.LNX.4.64.0710280000240.4362@racer.site> <20071029174000.GA4449@efreet.light.src> <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org> <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org> <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 06:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imjky-0003b3-EC
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 06:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXJ3FfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 01:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbXJ3FfA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 01:35:00 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:14937 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbXJ3Fe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 01:34:59 -0400
Received: by py-out-1112.google.com with SMTP id u77so3320247pyb
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=jNFTGxAjIobkAeW5Kwa/abORictJew4xM6b943j2N08=;
        b=Pwa8PJy1OeVwYugp4S7T0EmycUnlGvzkEY1LQFBwf3YL4o56XfYSpcRtayQkAOBZsfzJBL7OcKuMRbNx3QGEZlX8hd2nizM54J7H9KrVReyrNkqE+05oVx0cL5sLFHrNFfAmcs9UejsZ4AOaMc2H8KWE3Lhy/N5pLnRNx91vp+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=TSCZhOBpwIUSHaZ01G/YQk/Ee6bd8JLwbG7IK/hdsOEYOjlxRQ//q04O75YLBqBrw45c/zHhWfMJg827tgYRCfBzhvuYPGEjXR/JpUgsuei0Z8iCxMf31qP9FTjilvDJPX/do2+iZsjifutn/lYqfDmgG4Cxsf3iHfGrBG5xGvE=
Received: by 10.35.109.2 with SMTP id l2mr8364716pym.1193722497743;
        Mon, 29 Oct 2007 22:34:57 -0700 (PDT)
Received: from hermes ( [74.14.64.83])
        by mx.google.com with ESMTPS id v15sm16902580pyh.2007.10.29.22.34.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2007 22:34:52 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Tue, 30 Oct 2007 01:37:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62665>

On Mon, Oct 29, 2007 at 09:51:47PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 30 Oct 2007, Theodore Tso wrote:
> > 
> > Mirror URL  git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> >             http://repo.or.cz/r/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> > Push URL    git+ssh://repo.or.cz/srv/git/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> 
> No.
> 
> The push url is generally written as
> 
> 	repo.or.cz:/srv/git/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> 
> Tough.

But gitweb (on git.kernel.org and repo.or.cz) both give git:// locators.

> 
> > Quick!  Which of the URL-like strings follow the URL quoting rules,
> > and which ones don't?
> 
> Quick! WHO THE F*CK CARES?
> 

So, how should git deal with

git://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
git://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
git://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git

compared to 

http://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
http://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
http://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git

Note: this doesn't have anything to do with server:/path/to/repo

Not that I care, but git should probably handle things consistently.

  Tom
