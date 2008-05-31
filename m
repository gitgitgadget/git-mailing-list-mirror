From: =?ISO-8859-2?Q?Adam_Pi=B1tyszek?= <ediap@users.sourceforge.net>
Subject: Re: unable to push
Date: Sat, 31 May 2008 18:52:18 +0200
Message-ID: <48418242.1050606@users.sourceforge.net>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 31 18:53:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2UKe-0004WG-LD
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 18:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbYEaQwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2008 12:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbYEaQwg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 12:52:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63891 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbYEaQwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 12:52:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182784nfc.21
        for <git@vger.kernel.org>; Sat, 31 May 2008 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=6MvXXxWz3KRgbGamLLkA+fmh21iBCv1hACYIwwZ6c6I=;
        b=WCCHwkMUsumVqQKqNeBubdzX5MvK1IUzAOGph48F96EsWY6OBeL5eZt8Qh+2C9vmD7sajP0auFmfnThl6YjW33Ts0CjbhtBAs6pjj0Z0jrnGvUVELfaXz/eftEJ1a4BMNXRL0h1xmFDAAd+VmSQXjxVyJOhvbVUYdCwY72iIwlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=sznm+jwBwwA/dwjVCx1BzAjSbv9lLYgY6s38yUTf7DDMS6RYa0j0N2avTQ6I4cVbWy4OQgAFBR9Xs6TQnqkbv4HYluuvBRn1QLalv3sjs1xS+o9kwYy1lIhHAdT98ptkESqgHVmU/mbyO6b5ojCxa5g07yIKJri4hoxna2nRWpM=
Received: by 10.210.37.11 with SMTP id k11mr4231203ebk.70.1212252753066;
        Sat, 31 May 2008 09:52:33 -0700 (PDT)
Received: from ?192.168.1.4? ( [79.184.75.156])
        by mx.google.com with ESMTPS id z40sm1862794ikz.7.2008.05.31.09.52.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 09:52:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080516)
In-Reply-To: <20080531155036.GA27397@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83395>

* Jeff King [31 V 2008 17:50]:
> On Sat, May 31, 2008 at 08:03:47AM -0700, david@lang.hm wrote:
>=20
>> for some reason when I try to push to my public repo I get a message=
 that =20
>> everything is up to date, but if I switch to that repo and do a pull=
 it =20
>> updates properly
>=20
> If you "git push" without a refspec, it pushes "matching branches". S=
ee
> git-push(1) for more details.
>=20
>> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote public
>> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        HEAD
>> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        refs/heads/localmast=
er
>=20
> So you have only one branch, "localmaster".
>=20
>> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote .
>> 71ab4eea48eb3407a2ff4eef2befe9251897d676        HEAD
>> 71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/heads/master
>=20
> But the remote has only one branch, "master".
>=20
> If you want to push your localmaster to his master, you can do:
>=20
>   git push origin localmaster:master
[...]

I guess Peef described it the opposite way. In my opinion "localmaster"=
=20
is the only branch on the remote "public" repository and the local=20
repository has only one "master" branch.

So to push local "master" to the remote "localmaster" branch you should=
 use:

   git push public master:localmaster

BR,
/Adam


--=20
=2E:.  Adam Pi=B1tyszek (ediap)  .:....................................=
=2E:.
=2E:.  ediap@users.sourceforge.net  .:................................:=
=2E
