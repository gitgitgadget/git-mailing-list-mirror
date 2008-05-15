From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use whitespace.
Date: Thu, 15 May 2008 11:16:27 +0100
Message-ID: <e2b179460805150316n77513037y5409042b01170d4e@mail.gmail.com>
References: <20080427151610.GB57955@Hermes.local>
	 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
	 <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
	 <20080428094119.GA20499@sigill.intra.peff.net>
	 <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com>
	 <20080513091143.GA26248@sigill.intra.peff.net>
	 <e2b179460805131110k3cf582fdn9b8bd31046b90ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 12:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwaWY-00069g-DR
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 12:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbYEOKQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 06:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbYEOKQc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 06:16:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:30349 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbYEOKQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 06:16:31 -0400
Received: by rv-out-0506.google.com with SMTP id l9so423163rvb.1
        for <git@vger.kernel.org>; Thu, 15 May 2008 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y+g6omEGsVwUae0jfmAJmBENtX/LfuuAkUVWVh2mjqw=;
        b=ecubxreT8GU+XhFEZTDna1DNAMqVtNgj9NiJyUzykPXPpz9cLi+betcfGMXFEkMz/ZvDaGyb8JrwgHPYPFugL/ZRoEi1AShf41QrUTg54KDkEfraU59mROYGZKMvTh9lZ4ACo8i7ke3b8QzjaHRcZfaPV1+IM0fL/J7ufF2CDvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uEGa+9IrYNUU+Rpua7ekkHnJUtivYr3P0YYV2CkWCdRjA5a8jxJQrZjtsXr5K+dGzPH4iFkNVpHKSK3t/N6f3KoTUeyJ7Z+IfkHcx1w8RSjU5XccfK8FsGEeRlZmRcDHSVzohnwzgBI06jujDnDbUOIIf9MSqmA56NV5F3u1wXE=
Received: by 10.140.163.3 with SMTP id l3mr1037817rve.15.1210846588012;
        Thu, 15 May 2008 03:16:28 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Thu, 15 May 2008 03:16:27 -0700 (PDT)
In-Reply-To: <e2b179460805131110k3cf582fdn9b8bd31046b90ca7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82197>

2008/5/13 Mike Ralphson <mike.ralphson@gmail.com>:
> Thanks - that was a helpful spur to action. I'll check tomorrow how it
> fairs pulling, building, running the tests etc. I've added a couple of
> 'try git tag -f's to it, so I have KNOWN_BUILDING and KNOWN_PASSING
> points to pass quickly into bisect if necessary.

My KNOWN_BUILDING and KNOWN_PASSING tags are now happily chasing each
other up the commit log.

Which branch(es) would it be most useful on which to have this
automated build/test cycle?

Although the list of tags might get slightly unwieldy (i.e. the top
commit will gain a lot of tags if all is well), with a sensible naming
convention, these tags could be pushed to a central repo (a regularly
updated clone of git.git) allowing easy visibility of the current
state of the 'build collective'.

Something like {intials}_{uname info}_{branch}_KNOWN_{BUILDING|PASSING} ?

Mike
