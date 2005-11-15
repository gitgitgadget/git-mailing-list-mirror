From: Adrien Beau <adrienbeau@gmail.com>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 16:37:43 +0100
Message-ID: <94fc236b0511150737x7f0977ffmf9eb4a875715e7a0@mail.gmail.com>
References: <1132034390.22207.18.camel@dv>
	 <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	 <1132042427.3512.50.camel@dv>
	 <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051115121854.GV30496@pasky.or.cz>
	 <Pine.LNX.4.63.0511151518210.23020@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 16:47:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec2sV-0002UV-BH
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 16:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVKOPho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 10:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVKOPho
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 10:37:44 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:63730 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932543AbVKOPho convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 10:37:44 -0500
Received: by zproxy.gmail.com with SMTP id 13so1524747nzn
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 07:37:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aFNBdb2JNcNBIcsRVkn5EEmEQiZSqESOFvEV/dEbTziarZyYscKEFQG8ocIg6PX7DA+9it9pViH/ONM2sUVyllXkGvVheFVpoMInARMgI6ffcL7+7rMIXj6FDk7TcQkXwoiYLkKlSuvK5iGWjDQEKm/8ttjTkgoN4eihR9GMRtw=
Received: by 10.36.59.8 with SMTP id h8mr5320121nza;
        Tue, 15 Nov 2005 07:37:43 -0800 (PST)
Received: by 10.36.250.69 with HTTP; Tue, 15 Nov 2005 07:37:43 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511151518210.23020@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11909>

> Well, I can see no good reason for symrefs, except for backwards
> compatibility! Modern systems do support symlinks, you know?

What about less modern systems? I like to have tools that work on those=
, too.

> Let=B4s face it. The main target for git is not Windows users.

Yes, but they are a worthy secondary target.

> If we really want to support all idiocies of all possible ones,

I don't think we want that, but I don't think the symref vs. symlink
issue is an idiocy either.

> how about this one:
>
> If I clone a repository to a USB stick on cygwin, and try to access i=
t
> from my iBook, it does not work, because for *backward compatibility*
> reasons, files fitting the 8.3 format are stored in UPPER CASE.
>
> So, I would like to have support for UPPER CASE files in .git, please=
? And
> since I cannot do my own testing, please could you force everybody=B4=
s git
> to write OBJECTS and MASTER in UPPER CASE?

Long and mixed-case filenames are supported almost universally. Why
aren't you using FAT32 on your USB key? Even that decade-old
filesystem supports them.
