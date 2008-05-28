From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Rename git-rm --cached to --index
Date: Thu, 29 May 2008 01:57:44 +0200
Message-ID: <58CD1F67-D406-44BF-A3E2-DB57FD1742EC@wincent.com>
References: <20080528231405.GA25416@denkbrett.schottelius.org> <7vprr6roxt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nico -telmich- Schottelius <nico-git-20080529@schottelius.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VXt-0008ED-Hn
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbYE1X56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 19:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYE1X56
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:57:58 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:56657 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYE1X55 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 19:57:57 -0400
Received: from cuzco.lan (156.pool85-53-26.dynamic.orange.es [85.53.26.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4SNvn8B016464
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 28 May 2008 19:57:51 -0400
In-Reply-To: <7vprr6roxt.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83152>

El 29/5/2008, a las 1:25, Junio C Hamano escribi=F3:
> Please don't make naming inconsistent.  --index means "do things that
> usually affect only work tree also to the index as well", while --=20
> cached
> means "act only on the index" (study "git apply" for another example)=
=2E
>
> "git rm" that does not touch work tree but removes only the index =20
> entry
> should be named --cached.

I think this is a bit of an arcane distinction. I wonder if a more =20
intuitive scheme might be:

   "--index" as it is now (for "do things that usually affect only =20
work tree also to the index as well")

And:

   "--index-only" for "act only on the index"

Although the latter is more characters to type than "--cached", it is =20
a hell of a lot less surprising. For the typing-phobic there's always =20
completion.

Let the arguments about bikeshed color and breaking people's scripts =20
ensue!

Cheers,
Wincent
