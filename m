From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from Windows 
	Explorer
Date: Sat, 26 Sep 2009 11:45:54 +0200
Message-ID: <bdca99240909260245i6ba10dd4j1b2ee9e74ea5282d@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org>
	 <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com>
	 <20090925225940.GB14660@spearce.org>
	 <bdca99240909251658q395a62b6r8d5998382ac3fc7b@mail.gmail.com>
	 <20090926000500.GE14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mstormo@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 11:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrTqw-0005eJ-FQ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 11:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbZIZJpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2009 05:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZIZJpw
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 05:45:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:56665 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZIZJpv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 05:45:51 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1088720fge.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oNONUbZvyVONucbM9MdD+b0v3MtlKDNxqd5yv8h1Xr0=;
        b=T8u3aE4qP/qo6A/RJinQIyTUzC4cxdHEn/zve+djyCeh0l/i7hhmnzu/eKAU2Lx401
         7FLn2GzAoCIkLl4pcaXd8L67Z5vNTotF6jr+zI2ZQ5UBC3RRC5nfFr8VwEZDxp73N5nF
         Ev4zBP7VAkfQvIiZW/M8nRc4haCW27dndIBxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nxRr+amq+dBihH79BK3MiJ2ibStRebWi1s3Z2cy9AwTYfK6GTUOF0kgcVAjUKPKYdN
         eQJXf74zuf14Z84Of/3GksQ9sYYWaNVg/X11dH1bFXIjwp2SKT19suBeZv0LjPdn+E9D
         4WPAno4bZYzX7DLYePjaOJqKBYGILtM1EeVSc=
Received: by 10.86.240.9 with SMTP id n9mr1673884fgh.70.1253958354543; Sat, 26 
	Sep 2009 02:45:54 -0700 (PDT)
In-Reply-To: <20090926000500.GE14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129147>

On Sat, Sep 26, 2009 at 02:05, Shawn O. Pearce <spearce@spearce.org> wr=
ote:

> Odd. =C2=A0If I copy and paste from Thunderbird, its fine. =C2=A0But =
if I
> save the body out as an attachment from mutt, it fails.
>
> I wonder if it has to do with the From header appearing in the top
> of the body; this header has to be escaped with a leading space in
> mbox format. =C2=A0It looks like Thunderbird might be doing some magi=
c to
> remove that leading space from the context lines, while mutt isn't.
>
> Next time, don't include the first From line?

Will try. So what about these two patches? Should I re-send them with
the first "From" stripped?

Or will *.patch files that are attached to emails, instead of sending
the patch inline, be accepted?

--=20
Sebastian Schuberth
