From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Sun, 13 Mar 2011 22:38:19 +0530
Message-ID: <20110313170815.GB19763@kytes>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net>
 <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net>
 <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <20110310001017.GA24169@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 18:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyonM-0002PK-4d
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 18:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab1CMRJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 13:09:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57163 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab1CMRJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 13:09:26 -0400
Received: by gxk21 with SMTP id 21so733547gxk.19
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Q8qFMuuJqZUOxG3vnmlap1/QrgKY9FYurIjwhtAZGKY=;
        b=bKyzgVTUwoaCRRsEvAmTW/hb5gZLxs9ZMiT8gZo9gnZ4jHRL2MsQSyp9IGrdud3Kah
         akR5+5801EFpr6k1U9JFR/TWHpiMrBUZ400+H7oP73tDVM6FGGaoS6k/oYj2H5odaMu0
         6KcNUk+X5iDAXqzL7NM2wzS5cjQCZzWtPauv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LklOR7Cy36xpH9D1lqLhZ/nG8M62hTmIPaodnW7O8Q9lFVgqRGDrjtPpAvH+te0/Nx
         eIyo8PekPhAzLLhjXSU29UQO0mu0gRDzkfrIAiMGmcww+lvBV4UsuGR7bPpdLY2JHyKL
         FOzSIHEu1EUv3AsWMvoJA6vA+bJxifsDxBc04=
Received: by 10.236.26.41 with SMTP id b29mr427338yha.139.1300036166019;
        Sun, 13 Mar 2011 10:09:26 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 68sm4553516yhl.19.2011.03.13.10.09.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Mar 2011 10:09:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110310001017.GA24169@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168971>

Hi Jonathan,

Jonathan Nieder writes:
> 3. Remote helpers: bidi git remote-svn (or one-way remote-hg, or
>    remote-cvs, or ...).

I wrote a small introduction and created an entry for git-remote-svn
in the wiki [1]. Two minor concerns:
1. The student will have to work very closely with us, and pick up a
   lot of scattered WIP patches. I hope he doesn't get confused
   between what's merged and what's in-progress.
2. The project isn't as de-coupled as we'd ideally like. The student
   has to learn about the new fast-import features, and the
   information contained in an SVN replay dumpstream before diving in.

Other than these, I think most of the pending work is in the mapper.

> 4. filter-branch killer: using fast-import's new features to implement
>    common filter-branch operations (--subdirectory-filter,
>    --prune-empty, obliterating certain files) faster.

This is an interesting project that I'd also thought about: it might
get tangled up along with the Sequencer project though. Should we put
up this project on the wiki nevertheless?

p.s- Sorry about the late reply; I wasn't in station.

[1] SoC2011Ideas#Welcome and SoC2011Ideas#Remote_helper_for_Subversion

-- Ram
