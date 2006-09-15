From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add "git show-ref" builtin command
Date: Fri, 15 Sep 2006 23:24:56 +0200
Organization: At home
Message-ID: <eef5m8$euj$1@sea.gmane.org>
References: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org> <7vmz90g80m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 15 23:25:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOLBB-0003Da-R5
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 23:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWIOVYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 15 Sep 2006 17:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWIOVYn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 17:24:43 -0400
Received: from main.gmane.org ([80.91.229.2]:60318 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932277AbWIOVYm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 17:24:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOLAl-00039f-LD
	for git@vger.kernel.org; Fri, 15 Sep 2006 23:24:31 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 23:24:31 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 23:24:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27101>

Junio C Hamano wrote:

> +<format>::
> +=A0=A0=A0=A0=A0=A0=A0A string that interpolates `%(fieldname)` from =
the
> +=A0=A0=A0=A0=A0=A0=A0object pointed at by a ref being shown. =A0If `=
fieldname`
> +=A0=A0=A0=A0=A0=A0=A0is prefixed with an asterisk (`*`) and the ref =
points
> +=A0=A0=A0=A0=A0=A0=A0at a tag object, the value for the field in the=
 object
> +=A0=A0=A0=A0=A0=A0=A0tag refers is used. =A0When unspecified, defaul=
ts to
> +=A0=A0=A0=A0=A0=A0=A0`%(refname)`.

Wouldn't it be better to be able to use (or be able to enable, like ech=
o -e
option) interpretation of the  backslash-escaped characters, like=20
\t, \n, \0?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
