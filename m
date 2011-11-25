From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: load funcname patterns for -W
Date: Fri, 25 Nov 2011 17:32:32 +0100
Message-ID: <4ECFC320.4030003@lsrfire.ath.cx>
References: <5e3bcf651b31b299ca411296e6e7c4d11f6ae617.1322232319.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Nov 25 17:32:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTyhq-00055u-AQ
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 17:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab1KYQct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Nov 2011 11:32:49 -0500
Received: from india601.server4you.de ([85.25.151.105]:37179 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab1KYQcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 11:32:48 -0500
Received: from [192.168.2.104] (p4FFDB79E.dip.t-dialin.net [79.253.183.158])
	by india601.server4you.de (Postfix) with ESMTPSA id 0C6472F8039;
	Fri, 25 Nov 2011 17:32:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <5e3bcf651b31b299ca411296e6e7c4d11f6ae617.1322232319.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185939>

Am 25.11.2011 15:46, schrieb Thomas Rast:
> git-grep avoids loading the funcname patterns unless they are needed.
> ba8ea74 (grep: add option to show whole function as context,
> 2011-08-01) forgot to extend this test also to the new funcbody
> feature.  Do so.
>=20
> The catch is that we also have to disable threading when using
> userdiff, as explained in grep_threads_ok().  So we must be careful t=
o
> introduce the same test there.

Oops.  Thanks for catching this.

That reminds me to look into adding a thread-safe way to access
attributes again..

Thanks,
Ren=E9
