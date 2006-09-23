From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage
Date: Sat, 23 Sep 2006 21:54:40 +0200
Organization: At home
Message-ID: <ef43do$fm1$1@sea.gmane.org>
References: <20060919212725.GA13132@pasky.or.cz> <20060923125746.GJ8259@pasky.or.cz> <7virjes7dq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 21:55:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRDaZ-0004d4-DK
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWIWTyq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 15:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWIWTyq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:54:46 -0400
Received: from main.gmane.org ([80.91.229.2]:43143 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751509AbWIWTyp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 15:54:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRDaD-0004XL-VL
	for git@vger.kernel.org; Sat, 23 Sep 2006 21:54:42 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 21:54:41 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 21:54:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27621>

Junio C Hamano wrote:

> -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"<a href=3D\"http://www.kernel.org/=
pub/software/scm/git/docs/\" title=3D\"git documentation\">" .
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"<a href=3D\"" . esc_html($githelp_=
url) .
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"\" title=3D\"" . esc_html($githelp=
_label) .
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"\">" .

Why not use $cgi->a_begin({-href=3D>esc_param($githelp_url), -title=3D>=
$githelp_label});
or just plain $cgi->a and $cgi->img?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
