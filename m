From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Enhance core.logallrefupdates
Date: Sun, 08 Oct 2006 22:15:06 +0200
Organization: At home
Message-ID: <egbm6h$7mu$1@sea.gmane.org>
References: <7vbqonkzfe.fsf@assigned-by-dhcp.cox.net> <egaibi$bb$1@sea.gmane.org> <7vr6xiio02.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 08 22:15:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWf36-00025H-TY
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 22:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWJHUO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWJHUO6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 16:14:58 -0400
Received: from main.gmane.org ([80.91.229.2]:64955 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751431AbWJHUO5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 16:14:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWf2i-0001zm-Oy
	for git@vger.kernel.org; Sun, 08 Oct 2006 22:14:36 +0200
Received: from host-81-190-27-91.torun.mm.pl ([81.190.27.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 22:14:36 +0200
Received: from jnareb by host-81-190-27-91.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 22:14:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-91.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28548>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>>> =A0 =A0Come to think of it, it might make sense to change the
>>> =A0 =A0meaning of "true" to do what this patch does. =A0I do not th=
ink
>>> =A0 =A0of reasons to create missing reflog for tags automatically
>>> =A0 =A0anyway.
>>
>> If we change meaning of "true", perhaps (just in case in case) we
>> should add "all" value?
>=20
> Didn't I just say that I do not think of reasons to do so ;-)?
>=20
> Saying "just in case" is not enough.  You need to say at least
> "this hypothetical workflow which requires to update refs/xxx
> and doing automated reflog creation only under refs/heads makes
> that workflow less convenient".

If I remember correctly there was example of workflow which did
fetch remote heads to local tags. But I'm not sure if this reflog=20
made sense with that workflow.=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
