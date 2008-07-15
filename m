From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 19:06:26 +0400
Message-ID: <20080715150626.GA2925@dpotapov.dyndns.org>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org> <20080715092023.GO10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIm7t-0003JO-Fm
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYGOPGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbYGOPGi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:06:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:16850 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYGOPGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:06:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2295093fgg.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wJqAjxdrpOg+WaA2s5qQbe7E3Pgrj8qgiDo0kHKxuZU=;
        b=Bgku2iK/UgahsqyJdHtNLKH/yciqgZu+8I705beo8qEBdrBb0/2VHB6RqVeLpqJKX+
         vUj5a/TUaTMZAsIi/thw1ftgrURMJi9nfPJ5eeTGDygUVnA2U/TDpofAjlahra2uqqf7
         wU0heQWt7iHaQRqG/nMbGLAki7VZH7Xlsd3OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ay6bND7DKKP7wqAHDdsoGFRi588TI8Bo5h40aC7OyaDPsdqVr3uQNaQ/t9SWjxK7fc
         KhTVrnyo2DGui07Uf29ORHdPg1sYNbzVoP5OeMA/QLxOs27lYijVq1+BniSaRdePSzpC
         on7T2mE/4k87qbJVzAEMP47/VZKKt1jxoPWHE=
Received: by 10.86.91.12 with SMTP id o12mr437331fgb.1.1216134395898;
        Tue, 15 Jul 2008 08:06:35 -0700 (PDT)
Received: from localhost ( [85.140.171.254])
        by mx.google.com with ESMTPS id 4sm308033fge.5.2008.07.15.08.06.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jul 2008 08:06:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080715092023.GO10151@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88564>

On Tue, Jul 15, 2008 at 11:20:23AM +0200, Petr Baudis wrote:
> 
> 	(iii) Most importantly, this is not about waiting another few
> 	years for Debian to catch up, since the next stable release
> 	should really be upcoming rather soon:
> 
> 		http://debian-community.org/LennyReleaseSchedule/

Even if Lenny will be released right on the scheduler (which I seriously
doubt), Etch will be around for another year. In fact, the last release
of oldstable (sarge) happened on April 12 this year.  Thus delaying of
indexversion=2 does not help much here. Anyone who is more or less
seriously about using Git grabs it from backports. The downside of
delaying is that any incompatible changes are much less welcome by users
during minor releases than major ones. People tend to read release notes
during major releases more carefully and think whether they prefer new
features or backward compatibility. This choice will not be the same for
anyone, but changing default settings on the major release is much more
appropriate than during minor ones.

> 
> 	(iv) These problems do not concern people who are currently
> 	_actively_ _working_ with Git; these people hopefully do not
> 	use 1.4 willingly and already use Git from backports.org.
> 	This is about user experience for casual users who are quite
> 	possibly interested only in read-only tracking of upstream
> 	using Git - these people will likely use default Debian Git
> 	version and that is okay, because frankly, for them, the
> 	1.5 improvements do not really matter much. This is also
> 	large class of prospective future real Git users and we might
> 	not want to ruin Git's reputation in their eyes.

I disagree. It is not Git does not support the old format, but it
switches on the new one as default on the next major release, which
is a sensible thing to do. Those repos that think that access for
Git 1.4 users is important for them can set indexformat=1. As to
prospective future real Git users, anyone who is trying to use Git
1.4 is going to hit by many usability issues that were resolved in
1.5; and there is no community support for Git 1.4 either -- you can
ask about any problem with Git 1.4 on this list, and the only answer
you'll get is that you should upgrade your Git. So, there is no way
for newcommers to start using Git 1.4 and be satisfied with it.

Finally, 18 months since 1.4.4 may not appear as a long time ago for
other projects that are being developed for many years, but for Git,
which was only 21 months when Git 1.4.4 was released, 18 months is
really very *long* time ago.

Dmitry
