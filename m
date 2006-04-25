From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make die() and error() prefix line with binary name if set
Date: Tue, 25 Apr 2006 12:22:02 +0200
Organization: At home
Message-ID: <e2kt7h$o4a$1@sea.gmane.org>
References: <20060425101207.GC5482@bolero.cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Apr 25 12:22:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYKgF-0000Ae-QT
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 12:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWDYKV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 25 Apr 2006 06:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWDYKV7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 06:21:59 -0400
Received: from main.gmane.org ([80.91.229.2]:49064 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932182AbWDYKV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 06:21:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYKg3-00006f-Gl
	for git@vger.kernel.org; Tue, 25 Apr 2006 12:21:51 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 12:21:51 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 12:21:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19145>

Rocco Rutte wrote:

> +=A0=A0=A0=A0=A0=A0=A0=A0size_t len=3Dstrlen(name && *name ? name : "=
");
> +=A0=A0=A0=A0=A0=A0=A0=A0if (0=3D=3Dlen)

Wouldn't it be easier (and less idiomatic) to just do

+=A0=A0=A0=A0=A0=A0=A0=A0size_t len=3D *name ? strlen(name) : 0;
+=A0=A0=A0=A0=A0=A0=A0=A0if (0=3D=3Dlen)

--=20
Jakub Narebski
Warsaw, Poland
