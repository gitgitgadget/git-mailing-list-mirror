From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/5] grep: use parseopt
Date: Sun, 17 May 2009 21:45:16 +0200
Message-ID: <4A10694C.5010109@lsrfire.ath.cx>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain> <1241725608.4772.11.camel@ubuntu.ubuntu-domain> <4A0E8AEF.3000704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 21:45:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5mId-0002nR-6L
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 21:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbZEQTpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 May 2009 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbZEQTpX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 15:45:23 -0400
Received: from india601.server4you.de ([85.25.151.105]:35470 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZEQTpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 15:45:22 -0400
Received: from [10.0.1.101] (p57B7E53E.dip.t-dialin.net [87.183.229.62])
	by india601.server4you.de (Postfix) with ESMTPSA id 5C6C62F8044;
	Sun, 17 May 2009 21:45:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A0E8AEF.3000704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119407>

Stephen Boyd schrieb:
> Ren=E9 Scharfe wrote:
>> +int context_callback(const struct option *opt, const char *arg, int=
 unset)
>> +{
>=20
> Shouldn't these callbacks be static?

Oh, yes, they should.

Ren=E9
