From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: git for subversion users
Date: Tue, 26 Jun 2007 13:02:09 +0700
Organization: AcademSoft Ltd.
Message-ID: <200706261302.10056.litvinov2004@gmail.com>
References: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com> <46809733.2060200@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Patrick Doyle <wpdster@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 08:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3484-0004xP-Lh
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 08:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbXFZGCT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Jun 2007 02:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbXFZGCT
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 02:02:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:26115 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbXFZGCS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 02:02:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so18115ugf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 23:02:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=im2LwpgSUKRJJ42WsPZAgtIL8QQukBVwZ6YrKsegcmKdkw6rxIdJTW0UQq6DI27PiUC7uMsHP2wFFrLL32fulZiug6h4GkSHBEeiDbWLAsNTMTd+8XbgMx31cXEE6ycKzpq7UF7ORAIYFiwPZnfAGKTvVKekX9btU84bgfaLkoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EprdDaaFaSWs8D3/hG4r7dIIm8GVH2xV9i/tzVt4RIFEGCfJRwX4UoFODHX5Zf9dDy5B4bh1UicKfvaoJf7wwLf5V79PmeocczVJ4JKx/QHE6ahDnbfFIqSYJ/GzlrNsXirl4VqB1xfJEBO+y+W+9b6iE1ek9LQkhAMg6AF9ysk=
Received: by 10.67.26.7 with SMTP id d7mr131499ugj.1182837737127;
        Mon, 25 Jun 2007 23:02:17 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id j3sm5248671ugd.2007.06.25.23.02.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2007 23:02:16 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <46809733.2060200@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50951>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 26 =D0=B8=D1=8E=D0=BD=D1=8F 2007 11:33 Sam Vilain =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BB(a):
> There's your first issue - misunderstanding branching :)  You should =
end
> up realising that every little idea or feature forms a code branch in
> the direction of its implementation, the choice is whether to let the
> branches twist and grow together or train them in clear directions.

git-svn has one major trouble with branch handling: merge two branches =
that=20
are different branches at svn. Or simply start from different point fro=
m svn=20
branch.

git-svn dcommit operation tries to figure out where to commit at svn si=
de and=20
fail at these conditions. It seems to me this happend becuse it uses sp=
ecial=20
line at git's commit comment and in case of such merge it does not know=
 there=20
to commit. I did not found how to deal with this situation.

So, git-svn just a offline-capable version of svn client with linear hi=
story.=20
Sure. you can fork your own branch and then merge it into svn branch ag=
ain=20
but you should really careful about this.

I even does not know the way to solve this problem.

---
Alexander Litvinov.
