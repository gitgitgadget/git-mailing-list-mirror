From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: how to git-archive ignore some files?
Date: Sun, 11 May 2008 12:44:27 +0200
Message-ID: <4826CE0B.8080109@lsrfire.ath.cx>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br> <BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE> <4820CC35.3090202@lsrfire.ath.cx> <7vk5i7gk6e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Sun May 11 12:45:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv93Y-0006YL-FK
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 12:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbYEKKoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2008 06:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbYEKKoj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 06:44:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:47233 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbYEKKoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 06:44:38 -0400
Received: from [10.0.1.200] (p57B7F29A.dip.t-dialin.net [87.183.242.154])
	by india601.server4you.de (Postfix) with ESMTPSA id 314782F8003;
	Sun, 11 May 2008 12:44:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vk5i7gk6e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81755>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> To really solve this without external tools, git-archive needed to
>> grow an --exclude option like git-ls-files, though.
>=20
> Because exclude is never about ignoring what is already tracked, an
> option "like" git-ls-files would not help this case, I am afraid.

True, it should be named differently, e.g. --ignore.

Another idea: would it make sense to have an attribute for that instead
(or in addition to the command line parameter)?  I.e. files marked
export-ignore would not end up in the archive.  I suspect the set of
files to ignore doesn't change from archive to archive one creates.

Ren=C3=A9
