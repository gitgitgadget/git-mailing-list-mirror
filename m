From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Archiving tags/branches?
Date: Tue, 21 Oct 2008 10:15:26 +0200
Message-ID: <200810211015.27257.jnareb@gmail.com>
References: <48F93F52.4070506@pcharlan.com> <m3prlvibb7.fsf@localhost.localdomain> <48FD55BF.1020207@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	SZEDER Gabor <szeder@ira.uka.de>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 10:17:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsCQF-0005CX-3G
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 10:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbYJUIPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 04:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYJUIPo
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 04:15:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:39916 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYJUIPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 04:15:42 -0400
Received: by ey-out-2122.google.com with SMTP id 6so722028eyi.37
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2A5y3JpwJuHd4Y3CC1i3VVlSAP7AegZsBAWQyLb09mE=;
        b=HubfH5/flHg7HFpPkI6pRuQsjtFzV+iUicV/GxCqZrp3kLuquzzcq+ZLEQ06dGCJC9
         slSXZNavVN1dSGv8t8Oak5nnCaPJnT7gCd2nU+dC7xgzNa2CHeAcyKEFLfoTqgGZNzuU
         YVpUwqSFtxBxSaaZI5SWx8I4DOnsTgRYF2IG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lZokl8JlCpLk6PV4opOwdB2dwhGGK/CLApxJqBxafzBwfnw1b5/WdkL1Wn/oLwKCTb
         IPUoNTc5fP91TznMBiAtoSvFg692JRHefb4AcMbBU1ffufjQWxGvStAzsjC3i+vySW6i
         L01LDs/hl6UqQIgsIMLSLwd0scjoMISnQIpCI=
Received: by 10.210.143.11 with SMTP id q11mr8312747ebd.135.1224576940297;
        Tue, 21 Oct 2008 01:15:40 -0700 (PDT)
Received: from ?192.168.1.11? (abvd38.neoplus.adsl.tpnet.pl [83.8.201.38])
        by mx.google.com with ESMTPS id 1sm7201694nfv.18.2008.10.21.01.15.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 01:15:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48FD55BF.1020207@pcharlan.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98765>

On Tue, 21 Oct 2008 06:08, Pete Harlan napisa=B3:
> Jakub Narebski wrote:
>> Pete Harlan <pgit@pcharlan.com> writes:
>>> Johan Herland wrote:
=20
>>>
>>> Using a secondary repo solely to overcome a flat tag/branch namespa=
ce
>>> feels hackish.  Perhaps git will benefit someday from work in this =
area,
>>> but until I come up with a patch your suggestion should work fine. =
 Just
>>> knowing I didn't overlook an existing feature helps a lot.
>>=20
>> I don't quite understand what you mean by _flat_ namespace for tags
>> and branches.
>>=20
>> First, it is not unusual to have hierarchical branch names, at least
>> for short-term topic branches. For example in git.git history (and i=
n
>> "What's cooking..." announcements on git mailing list) you can find
>> branch names such as rs/alloc-ref, nd/narrow, tr/workflow-doc.
>> Additionally remote-tracking branch names have inherently hierarchic=
al
>> names: refs/remotes/<remote>/<remote branch>.  While tag names usual=
ly
>> are of the type x.y.z, it is not mandated by some technological
>> limitation.
>=20
> What I mean by "flat" is that "/" is just another character as far as
> what git exposes to the user.  Regardless of any semantics the user
> chooses to assign to it, and regardless of what advantage git makes u=
se
> of "/" internally, unless I can do something like:
>=20
> % git tag --ls
> sometag
> someothertag
> releases/
> % git tag --ls releases/
> releases/2008/
> releases/2007/
> % git tag --ls releases/2008
> releases/2008/r3.14
> %

Actually you can have kind of second and third examples; "git tag -l"
takes optional <pattern> argument, so you can do the folowing without
any new features:

  # git tag -l 'releases/2008/*'
  releases/2008/r3.14
=20
(the quotes are to protect wildcard characters against expansion by
shell)

> "/" is just like any another character in a tag or branch.
>=20
> (The above notional --ls modifier is probably very easy to write, and=
 if
> I do so it may address all of my woes.  Subversion's branching/taggin=
g
> can be organized pretty much exactly like this, and importing into gi=
t
> such a repository is what initially led me to ask about organizing ta=
gs
> and branches.)

Hmmm... it looks like what you are complaining is not the fact that
tags have flat namespace, but the fact that recursive mode is the
default behavior (something like "ls -R" or "git ls-tree -r").
=20
> What I'm usually likely to want from a "list tags" command is to see =
the
> most recent few tags, not (say) all 226 tags in git.git.  I'll probab=
ly
> write a little alias that does that, but even then when looking at th=
e
> whole list it would be nice to have the option to navigate it
> hierarchically.  (Or in some other manner, and/or possibly with a
> configurable directory separator.)

So you would want some '--local' / '--non-recursive' option to listing
all tags (for git-tag) and branches (for git-branch).

As to the "most recent few tags":
  $ git for-each-ref --format=3D'%(refname)' --sort=3D-taggerdate --cou=
nt=3D10 refs/tags/

--=20
Jakub Narebski
Poland
