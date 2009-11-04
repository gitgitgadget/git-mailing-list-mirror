From: Eugene Sajine <euguess@gmail.com>
Subject: Re: gitweb - bare repos integration - owner info in description file
Date: Wed, 4 Nov 2009 18:48:21 -0500
Message-ID: <76c5b8580911041548p74bf0f34o9fc4f1ab65307e72@mail.gmail.com>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
	 <m3ab00gr25.fsf@localhost.localdomain>
	 <76c5b8580910091532yd6c6fc4ib942a29c827f3a6c@mail.gmail.com>
	 <200910102045.13374.jnareb@gmail.com>
	 <alpine.DEB.1.00.0910120201350.4985@pacific.mpi-cbg.de>
	 <76c5b8580910121448q67edd935wb189c8a6f9af2f2e@mail.gmail.com>
	 <20091103202211.GA17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:48:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5paW-00058g-M4
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758345AbZKDXsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 18:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758221AbZKDXsS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:48:18 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:32856 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210AbZKDXsR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 18:48:17 -0500
Received: by iwn10 with SMTP id 10so5382822iwn.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 15:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jv/2j5OTJ+MRzYuWkzDtcoDsr+TNeoYOv2XcP/iRpbA=;
        b=F0KDSHEo10RYbpGsMVQXeeyi+bsSvId7fxLXIZkG39d9wWip17AAX0LuzokZahLVRN
         +P5UpCKSp8lbKvlyMrWJRyQgCfjlKrjot3Dw1PHU+IEMdrNED6ZuiIOjW7RrUBpZfNwk
         wiVmaStZtkoo0yEtpIU/srmh4NTnnQWjORk40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b0IyGoAJoECc0c2QATS1yntoqTdgaVXCRzrq0BbWHWeViEzmQxxMAE2FBgo6Et9cVp
         JJVKRoW8zD0n+Gjnne6lNLQpk37qjiTtT3ASIzSGenwFGMO+HO2MmVhY3XHDf8RflzVr
         g31Q1YAgljJDejWbEKTCghqhxp324hBLiiX7M=
Received: by 10.231.20.230 with SMTP id g38mr83522ibb.49.1257378501995; Wed, 
	04 Nov 2009 15:48:21 -0800 (PST)
In-Reply-To: <20091103202211.GA17748@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132173>

>
> I think you got confused by perhaps unclear gitweb/README wording. Th=
ere
> is a single property file, it's called "config" and _that's_ where yo=
u
> set the gitweb configuration variables, in its gitweb section.
>
> Try running
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config gitweb.owner "Eugene Sajine"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config gitweb.description tralala
>
> within the repository (and optionally marveling at the config file ag=
ain
> afterwards). Is this what you are after?
>
> Perhaps the gitweb/README file doesn't make it clear enough that thes=
e
> are gitweb configuration variables, not stand-alone files, and maybe =
it
> should provide an example on how to set them. I'm sure that if you wi=
ll
> submit a patch for gitweb/README clarifying this, it will be welcome.
>
> Kind regards,
>
> --
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Petr "Pasky" Baudis
> A lot of people have my books on their bookshelves.
> That's the problem, they need to read them. -- Don Knuth
>

Thank you for the advice, but I found a better solution than gitweb - c=
git!

I should say cgit is an amazing tool - nice design and graphic
appearance, easy to set up and very easy to maintain, full of features
and fits our environment nicely. Many thanks to the Author (Lars
Hjemli) and all contributors!

Eugene
