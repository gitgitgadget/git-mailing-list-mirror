From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Mon, 23 Feb 2009 10:55:57 +0100
Message-ID: <4F48B127-49B0-4592-BE6F-04A46D061030@wincent.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>  <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>  <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>  <7v63j2z7bh.fsf@gitster.siamese.dyndns.org> <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com> <alpine.LFD.2.00.0902221225080.3111@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 10:57:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbXZD-0005jE-As
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 10:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbZBWJ4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 04:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbZBWJ4J
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 04:56:09 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:45929 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZBWJ4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 04:56:08 -0500
Received: from cuzco.lan (210.pool85-53-4.dynamic.orange.es [85.53.4.210])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1N9twBW015374
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 23 Feb 2009 04:56:00 -0500
In-Reply-To: <alpine.LFD.2.00.0902221225080.3111@localhost.localdomain>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111128>

El 22/2/2009, a las 21:34, Linus Torvalds escribi=F3:

> But I do realize that without the historical background, none of this
> makes sense. And quite frankly, I do hate "--pretty=3Dxyz" myself. I =
=20
> find
> myself wishing I could just write
>
> 	git log --oneline
>
> instead of "--pretty=3Doneline", and I wish "shortlog" was a pretty =20
> format
> instead of a command of its own.


Why not an alias then?

	git oneline

ie. something like this, which I have in my config:

	alias.oneline=3Dlog --pretty=3Doneline --abbrev-commit

Cheers,
Wincent
