From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: blame on a deleted/renamed file
Date: Wed, 05 Aug 2009 14:54:07 +0200
Message-ID: <vpqr5vqbevk.fsf@bauges.imag.fr>
References: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
	<20090805123754.GA13340@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 14:54:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYg0d-000768-Ar
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 14:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbZHEMyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 08:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934288AbZHEMyP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 08:54:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55346 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934198AbZHEMyO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 08:54:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n75CrLLs031589
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 14:53:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYg0N-0001wy-Fd; Wed, 05 Aug 2009 14:54:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYg0N-0000He-EF; Wed, 05 Aug 2009 14:54:07 +0200
In-Reply-To: <20090805123754.GA13340@atjola.homenet> (=?iso-8859-1?Q?=22Bj?=
 =?iso-8859-1?Q?=F6rn?= Steinbrink"'s message of "Wed\, 5 Aug 2009
 14\:37\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 05 Aug 2009 14:53:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n75CrLLs031589
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250081603.35707@anusQOZ4COrdfXb1WYR81w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124902>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> doener@atjola:h $ svn blame file://$PWD/repo/bar
> doener@atjola:h $ svn blame file://$PWD/repo/bar@1
> svn: '/bar' is not a file in revision 1

but "svn blame bar -r 1" here actually means "give me the blame for
the file whose name is now 'bar' starting from revision 1". I don't
know how to do such thing with a single git command.

--=20
Matthieu
