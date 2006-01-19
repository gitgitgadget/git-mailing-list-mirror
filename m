From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 14:31:58 +0100
Message-ID: <cda58cb80601190531q238a8f40r@mail.gmail.com>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	 <cda58cb80601170932o6f955469y@mail.gmail.com>
	 <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <43CF739F.2030204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 14:33:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzZtm-0005XI-6p
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 14:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWASNcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 08:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWASNcA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 08:32:00 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:30870 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161193AbWASNcA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 08:32:00 -0500
Received: by zproxy.gmail.com with SMTP id 14so199270nzn
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 05:31:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gLl0Slo6/sAFY2pvyUiDFMw+mGhLlz44jkVti5RSefz6AOGv1KWZAP25439qKfN8SAri/YV1jvKUXOhwml+BQuskXvCuRpBI5gPsqnZr0QOnYbAgCzO5V/4NZ0u8sRMoWj9a1QuxsEooLTjPSlMiZd2JvS/nqZSLO4c5PD9/6R8=
Received: by 10.36.34.9 with SMTP id h9mr521589nzh;
        Thu, 19 Jan 2006 05:31:58 -0800 (PST)
Received: by 10.36.47.7 with HTTP; Thu, 19 Jan 2006 05:31:58 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43CF739F.2030204@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14906>

2006/1/19, Andreas Ericsson <ae@op5.se>:
> Junio C Hamano wrote:
> > Franck <vagabon.xyz@gmail.com> writes:
> >
> >
> >>I'm wondering why the "grafts" files is not involved during
> >>push/pull/clone operations ?
> >
> >
> > Commit ancestry grafting is a local repository issue and even if
> > you manage to lie to your local git that 300,000th commit is the
> > epoch, the commit object you send out to the downloader would
> > record its true parent (or parents, if it is a merge), so the
> > downloader would want to go further back.  And no, rewriting
> > that commit and feeding a parentless commit to the downloader is
> > not an option, because such a commit object would have different
> > object name and unpack-objects would be unhappy.
> >
>
>
> I'm a bit curious about how this was done for the public kernel repo.
> I'd like to import glibc to git, but keeping history since 1972 seems a
> bloody waste, really.
>

That's exactly my point. Futhermore make your downloaders import that
useless history spread this waste.

I guess kernel repo will encounter this problem in short term. It's
being bigger and bigger and developpers may be borred to deal with so
many useless objects. But I'm not saying that it's bad thing to keep
that history. It just would be nice to allow developpers that don't
care about old history to get rid of it.

Thanks
--
               Franck
