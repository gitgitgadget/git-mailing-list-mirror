From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Parent-less branches
Date: Sat, 3 May 2008 00:32:25 +0200
Message-ID: <0EACFC4A-F2E7-48D3-BE49-10D2B32AB470@wincent.com>
References: <F26CE1A6-FE85-4AC6-BCE6-B41085A09F0F@simplicidade.org> <7vskx0wf8i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pedro Melo <melo@simplicidade.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js3p1-0003P3-FW
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 00:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764037AbYEBWcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763973AbYEBWcm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 18:32:42 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:43044 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758606AbYEBWcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 18:32:41 -0400
Received: from cuzco.lan (228.pool85-53-21.dynamic.orange.es [85.53.21.228])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m42MWRJd011638
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 May 2008 18:32:29 -0400
In-Reply-To: <7vskx0wf8i.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81040>

El 2/5/2008, a las 23:47, Junio C Hamano escribi=F3:
> Pedro Melo <melo@simplicidade.org> writes:
>
>> inside an existing repository I want to create a new branch without =
a
>> parent commit. Is there a set of commands to do this?
>
> Typically these commits come about because you created a completely
> separate history elsewhere in a separate repository and fetched and/o=
r
> pulled from there.
>
> So "a set of commands to do this" would be:
>
> 	go away
> 	git init
>        build history as usual
> 	come back
>        git fetch ..from that other repository..

I wanted to do this just the other day, but I did it all inside the =20
one repo, and made some notes on the process here:

http://rails.wincent.com/wiki/Creating_independent_branches_with_Git

Basically, using "git write-tree" and "git commit-tree" plumbing.

Cheers,
Wincent
