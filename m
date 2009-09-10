From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 20:54:17 +0200
Message-ID: <vpqtyzabpgm.fsf@bauges.imag.fr>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	<20090910013235.GA9980@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlon2-0006v8-Fo
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZIJSyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZIJSyV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:54:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52751 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbZIJSyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:54:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8AIoQMY008590
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 Sep 2009 20:50:26 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mlomf-0007hl-Kg; Thu, 10 Sep 2009 20:54:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mlomf-0007yd-JH; Thu, 10 Sep 2009 20:54:17 +0200
In-Reply-To: <20090910013235.GA9980@atjola.homenet> (=?iso-8859-1?Q?=22Bj?=
 =?iso-8859-1?Q?=F6rn?= Steinbrink"'s message of "Thu\, 10 Sep 2009
 03\:32\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 10 Sep 2009 20:50:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8AIoQMY008590
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253213426.77839@ZdqlmT08e7K6csadqqqfrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128135>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.09.09 14:27:56 -0700, Brendan Miller wrote:
>> 8. There's no obvious way to make a remote your default push pull
>> location without editing the git config file. Why not just something
>> like
>>=20
>> git remote setdefault origin
>
> Because "git remote" is the wrong tool. The default remote for
> fetch/push is configured per branch head, not globally.

(the --track option of git branch and git checkout can help).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
