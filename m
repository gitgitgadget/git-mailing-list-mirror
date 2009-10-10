From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb - bare repos integration - owner info in description file
Date: Sat, 10 Oct 2009 20:45:11 +0200
Message-ID: <200910102045.13374.jnareb@gmail.com>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com> <m3ab00gr25.fsf@localhost.localdomain> <76c5b8580910091532yd6c6fc4ib942a29c827f3a6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 20:49:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwh0L-0003dG-RR
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 20:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762018AbZJJSrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2009 14:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbZJJSrK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 14:47:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:15316 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbZJJSrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 14:47:09 -0400
Received: by fg-out-1718.google.com with SMTP id d23so93360fga.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qbU+IPWhyyt8xUZl/R3UQYthoQRNCbFd1eRrSbr17Gc=;
        b=X9BcqW14cqDjkBSQh7w51cqhgpZTA7J1XxB2wll4+lRU0tqSh8su1loAtqX3OX0LVZ
         VajXN+Bz82sixMDetcSKW2vhkrJqqfraqO9GUqenoUc4lJTcQsEQYDh3oN2TA2TCtgo5
         ddRGTq7iTvOei2/E4VSTkfRe+qJhrrwB2lI0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KBsmJDhI2/ur50hx83TraMEZ+jNveTqPS20HeCEXC4G7yM+S+0H3O3gEiY1ZTfjxw5
         ch97IksxOF3DXGIN7LX1Y2iHMtnrrkrbXH70V0RrOiKIW0issfBrroA0IpD9oye4eji2
         5DHnSY79f2Ueu6xeeXVwpEuZouwSwm6P8f2K0=
Received: by 10.86.222.15 with SMTP id u15mr3726109fgg.33.1255200321116;
        Sat, 10 Oct 2009 11:45:21 -0700 (PDT)
Received: from ?192.168.1.13? (abwa37.neoplus.adsl.tpnet.pl [83.8.224.37])
        by mx.google.com with ESMTPS id 3sm3759362fge.21.2009.10.10.11.45.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 11:45:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <76c5b8580910091532yd6c6fc4ib942a29c827f3a6c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129896>

On Sat, 10 Oct 2009, Eugene Sajine wrote:
> >
> > RTFM (in this case gitweb/README). =C2=A0gitweb.owner and gitweb.de=
scription
> > configuration variables in per-repository config.
>=20
> Ok, my bad, didn't get there;) It is good to know there are places
> where to keep the info. But it is not the point. The point is to
> integrate gitweb with bare repo creation more than it is right now by
> providing keys which will help filling out this info at the bare repo
> creation stage.
>=20
> shortly i'm talking about command like this (the key names are for sa=
mple only):
>=20
> $ git clone --bare repo repo.git -desc "description" -gwowner
> "gitwebowner@server.com" -cloneurl "git://host/repo.git"
>=20
> seems to me quite comfy, and no headache...

The project description, project owner and (clone) url are used by=20
gitweb only, so I don't see why git-clone has to feature-creep to
set them.

[cut off part about using XML for all of gitweb config: description,
 owner, cloneurl]
> > %
> > "To be fair, there are uses for XML. On Halloween, for example."
> >
> > =C2=A0 =C2=A0 - Johannes Schindelin, on git@vger.kernel.org
> > %
>=20
> yeah, to show kids xml print outs as an answer to "trick or treat!".
> Can save on candies;)

Err, I think Dscho meant here that XML is so *scary*... Isn't it?

--=20
Jakub Narebski
Poland
