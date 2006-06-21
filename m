From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 18:38:50 +0200
Message-ID: <200606211838.50864.jnareb@gmail.com>
References: <e79921$u0e$1@sea.gmane.org> <e7bj0s$b0p$1@sea.gmane.org> <200606211802.41071.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 18:39:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft5jI-0002KV-Mw
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 18:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWFUQit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Jun 2006 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWFUQit
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 12:38:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:28073 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932240AbWFUQiq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 12:38:46 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1115ugf
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 09:38:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=kLEE6lJEvDHhWDIzK8tzNlSzLsUVHn+I/mdag9VBv8jofEVA0Ue9uVc0B0TqgfgDfXRicB2yIHY2kpXp6obHD2BjwtAPl2lI497X1MxNV51uVy8rKvzAo/uwQr88VrTKSTTuIrfjMOdm3gn+CSJ1ywms4EvDLpRATgJq9LL2p0k=
Received: by 10.67.93.7 with SMTP id v7mr10100ugl;
        Wed, 21 Jun 2006 09:38:45 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id w40sm10394ugc.2006.06.21.09.38.44;
        Wed, 21 Jun 2006 09:38:45 -0700 (PDT)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: KMail/1.6.2
In-Reply-To: <200606211802.41071.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22280>

Josef Weidendorfer wrote:
> On Wednesday 21 June 2006 15:53, Jakub Narebski wrote:
>>> Yup, but when you are interested in the history of changes to files=
 in
>>> a given directory, you also want to see the name of the changed fil=
es on
>>> the same page, and not have to click on every commit to get the fil=
e
>>> names. Besides, the "commit" view shows all changed files, and not =
only=20
>>> the ones which are in the directory.
>>=20
>> Could you please create a mockup how you imagine the page to look li=
ke
>> (in ascii-art)? At least list the columns...
>=20
> Let's see. A think a mixture between current history and log...
> Currently, it looks like this
>=20
> =A0http://git.kernel.org/git/?p=3Dgit/git.git;a=3Dhistory;f=3DDocumen=
tation
>=20
> gives you the history of subdirectory Documentation/ of git
> (unfortunately only reachable via changing the URL...).
>=20
> And it could look as attached (I did a little copy/paste of
> HTML). I only modified 2 commits of the list...

It probably didn't get to mailing list (at least to archives) due=20
to having attachement.

I thought you wanted to enhance tree view, e.g. adding to the view like=
 in

  http://git.kernel.org/git/?p=3Dgit/git.git;a=3Dtree;f=3DDocumentation

columns 'Changed by' or 'Author', 'Age' or 'Last changed', 'Commit'=20
(i.e. abbreviated sha1 id of a commit), and perhaps shortened commit
message (short description of changes, a la shortlog but shorther).
In other words 'blame'/'annotate' for directory. Which would need new g=
it
command I think.

Adding filtered list of files modified by commit in log and history vie=
ws=20
should be fairly easy...
--=20
Jakub Narebski
Poland
