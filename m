From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 13:08:26 +0530
Message-ID: <v2me72faaa81004190038y4aeefa80g9f60bb3b1e795e4b@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004180246.18263.jnareb@gmail.com>
	 <20100418005917.GO10939@machine.or.cz>
	 <201004180324.54722.jnareb@gmail.com>
	 <20100418021223.GP10939@machine.or.cz>
	 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
	 <20100418223120.GB3563@machine.or.cz>
	 <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
	 <vpqeiicey0d.fsf@bauges.imag.fr>
	 <7vfx2rsy6y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 09:38:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lYv-0003hb-0N
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 09:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab0DSHi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 03:38:28 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:36665 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab0DSHi1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 03:38:27 -0400
Received: by ywh32 with SMTP id 32so2594198ywh.33
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 00:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KtH5dStyhL8cg0RwwC+1/KbliLQINiP1JXoy/cYWSJw=;
        b=OvEoaMYA0Nga4zJwKKcGamaZ2Y5q5XqQJ+KRK+mh+eUYweHumpl7y6bhijpGNf0x/E
         c9eUm8CMbV04j8Op5yFjWqTP9XpwifZ1O5Yqhw5oIkiTjjJJ0hi3ussb2QmUPrEbvGQv
         IINYTmgPTyULtDOuSJHBovCbb9FrVtndAG5nI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FdsniVNBNcKrpf68dve3cIcD7cW3Jv5Yjg3tNrZZDZguxnUDMD7LizZwPSytMo1vhN
         Lk2xli6lyJD30wfpZR040Sf6PUPhZwOPt7batwGSkXbxcFFgitTJcfbR2mu57AaVnt2e
         4DXRy9+3VTdZeYeN7sxtvOj/m118XhnfvwohM=
Received: by 10.90.118.4 with HTTP; Mon, 19 Apr 2010 00:38:26 -0700 (PDT)
In-Reply-To: <7vfx2rsy6y.fsf@alter.siamese.dyndns.org>
Received: by 10.91.163.17 with SMTP id q17mr2939483ago.36.1271662706666; Mon, 
	19 Apr 2010 00:38:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145273>

On Mon, Apr 19, 2010 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:
>>
>>> Session management reduces the length of URL
>>
>> ... but OTOH, GET parameters allow painlessly cut-and-paste-able URL=
s,
>> which is in my opinion a must-have for gitweb.
>
> These self-contained URL are used in bookmarks and e-mails to the mai=
ling
> list. =A0I think "the length of URL" is a red herring at best, and sh=
ortened
> URL that is not self-contained is not an advantage at all.

Yeah, I agree to that.

> On the other hand, a proposal about giving multiple clients access to
> their own individual server-side checkouts (ala "workspace" in DELTA-=
V)
> would require some mechanism to maintain the state on the server end,=
 and
> session management would be one ingredient necessary to achieve that.

So, why don't we do like this,
There will be no need of session management when gitweb is installed
in some site like repo.or.cz which needs copy'n'paste URLs
but there will be session management when the write modules are
enabled and when gitweb is installed locally or on intranet (basically
when it is used to work on a repo).

What do you say ?

> When I heard that somebody wants to do a "write support" in gitweb, I
> naturally thought the proposal was about implementing RFC3253 using g=
it as
> a backend. =A0I think it would be a reasonable thing to do (as oppose=
d to
> coming up with an ad-hoc "write support" mechanism that is not compat=
ible
> with anybody else), but on the other hand it might be a bit too ambit=
ious
> for a one-student summer project.
>

Sorry but I don't know what it is.
The current average git used are in need of a git client and git-gui
is not doing a good job of it. So, this proposal solves it by
providing client features inside gitweb itself. :-)

-pavan
