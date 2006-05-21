From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 10:24:37 +0200
Organization: At home
Message-ID: <e4p83e$uqt$1@sea.gmane.org>
References: <20060521054827.GA18530@coredump.intra.peff.net> <7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net> <20060521081435.GA4526@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun May 21 10:24:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhjEm-00079v-Ba
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWEUIY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 21 May 2006 04:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWEUIY3
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:24:29 -0400
Received: from main.gmane.org ([80.91.229.2]:28049 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751489AbWEUIY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 04:24:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhjEZ-00078T-Gp
	for git@vger.kernel.org; Sun, 21 May 2006 10:24:19 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 10:24:19 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 10:24:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20438>

Jeff King wrote:

Hmmm... isn't the patch slightly against git coding style?
> +     if(unpacked)
[...]
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for(i =3D 0; i < len;=
 i++)

compare to:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0for=A0(ref=A0=3D=A0refs;=A0ref;=A0ref=A0=3D=
=A0ref->next)=A0{

--=20
Jakub Narebski
Warsaw, Poland
