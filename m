From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 16:27:41 +0300
Message-ID: <c6c947f60803130627r45629099g33a0741f319dc99c@mail.gmail.com>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
	 <20080313114738.GC2414@genesis.frugalware.org>
	 <alpine.LSU.1.00.0803131254580.1656@racer.site>
	 <20080313121644.GD2414@genesis.frugalware.org>
	 <20080313125853.GA12927@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:28:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnTr-0003Ce-DC
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYCMN1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYCMN1o
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:27:44 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:29957 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbYCMN1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:27:43 -0400
Received: by el-out-1112.google.com with SMTP id v27so2143695ele.17
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=W7hhsUKZOuHOD5LJni3zXHKn5v07lwlsDfpxwelLnR4=;
        b=BU1ZUS5wWj3bP+itjEHX0gu9PBIRx/H4EGyKAC0PmWzKX9tN2lscXAO4iovH4EDD4dwL+nlprUG1B0a22BSHj/0aB7BiD/gjLyLPf5T8fO8DSCKK5q4AL7uaFP19rOPqWUXqo7PUW0+NYMCXmdPzIMdHtJSRyPT1SUXhFWghUrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=okxXiurVhkTVKuZtzDXCHDF10Yo4cx5DbJpK/7gH+gT3qfmdo66NGNOt3Law9MWTINL9EBc0+a5vd3O3Jt+9HUUiphVIdy4W5x5s1ZsnodfN/oG9sKFnH5SIanVTznAP+Qw+oidm0O+/IreBUcoV3qvyF4+K5CTwxwenkzKYukA=
Received: by 10.114.144.1 with SMTP id r1mr9319476wad.135.1205414861310;
        Thu, 13 Mar 2008 06:27:41 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Thu, 13 Mar 2008 06:27:41 -0700 (PDT)
In-Reply-To: <20080313125853.GA12927@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77081>

>  It's normally at this point that that you'd need to bring in a security expert to ask a
>  whole lot of questions about your exact use scenario, do a formal
>  threat analysis, since there are all sorts of unanswered questions
>  about what kind of key management solution you really need for your
>  situation.

Uh. This is for kind of hobbyist noncommercial usage, so there are not
that much resources for bringing in security experts. :-)

Also I do not expect this data to be protected from determined (payed)
professional attack -- a determined professional would probably be
able to find some weaker spot elsewhere. However I do want such attack
to cost enough to ward off idle amateurs and bored professionals. :-)

>  It's usually not as simple as "just encrypt it".

> How many people need to have access to the to the repository?

Well, 2-5, up to ten, I guess. In immediate future -- two persons only. :-)

>  Do you need to revoke access to the repository later?

Probably. But restricting remote access should be enough.

> Who is allowed to give a new person access to the repository?

To keep things simple, me myself only.

> etc., etc., etc.

Thank you,
Alexander.
