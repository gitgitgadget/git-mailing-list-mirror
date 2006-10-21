From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 18:31:33 +0200
Message-ID: <200610211831.34462.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE> <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, "Jan Hudec" <bulb@ucw.cz>,
	"Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 21 18:31:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJkw-0001nX-2a
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423356AbWJUQb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 12:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423357AbWJUQb1
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:31:27 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:30663 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423356AbWJUQb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 12:31:26 -0400
Received: by hu-out-0506.google.com with SMTP id 28so578763hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 09:31:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=thozYEy7AyZd+atjonl7VFmUPepIWwoYwugwdolURd4oHDxRRjBlfsOCAme8kEBGkmQcN4v9R2wjXs/nwu6m5MXnfJhpt+gUoyCx8fc6NKryNWi6D2FDcGXO55LRZesrNCKEbq4aku20HdYtj/4WKDOMZTfNTyBnWtJdnqL64eE=
Received: by 10.67.30.6 with SMTP id h6mr2564871ugj;
        Sat, 21 Oct 2006 09:31:24 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s1sm2793178uge.2006.10.21.09.31.24;
        Sat, 21 Oct 2006 09:31:24 -0700 (PDT)
To: "Erik =?utf-8?q?B=C3=A5gfors?=" <zindar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29631>

Erik B=C3=A5gfors wrote:
> On 10/21/06, Sean <seanlkml@sympatico.ca> wrote:
>> On Sat, 21 Oct 2006 16:13:28 +0200
>> Jan Hudec <bulb@ucw.cz> wrote:
>>
>>> Bzr is meant to be used in both ways, depending on user's choice.
>>> Therefore it comes with that infrastructure and you can choose whet=
her
>>> you want to use it or not.
>>
>> From what we've read on this thread, bzr appears to be biased toward=
s
>> working with a central repo.  That is the model that supports the us=
e of
>> revnos etc that the bzr folks are so fond of.   However Git is perfe=
ctly
>> capable of being used in any number of models, including centralized=
=2E
>> Git just doesn't make the mistake of training new users into using
>> features that are only stable in a limited number of those models.
>=20
> This is just plain wrong.
>=20
> bzr is a fully decentralized VCS. I've read this thread for quite som=
e
> time now and I really cannot understand why people come to this
> conclusion.
>=20
> However, if you do want to work centralized, bzr has commands that
> fits that workflow really good.

Read carefully: bzr is _biased_ towards work with central repository.
Default workflow (as for example using revnos, as for example using
"merge" for one repository and "pull" for other) of bzr is geared
towards star topology, i.e. some centralized repository.

That to be said, it is supposed to be able to work in fully decentraliz=
ed
way, using revids. But then for example you don't have "simple rev
namespace" (moreover you have _worse_ namespace than git's sha1 ids).

--=20
Jakub Narebski
Poland
