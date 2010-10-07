From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t/t5560: use `X=Y && export X' not `export X=Y'
Date: Thu, 07 Oct 2010 09:55:12 +0200
Message-ID: <vpqhbgy8mjj.fsf@bauges.imag.fr>
References: <1286437634-12593-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 09:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3lN4-0005Ya-TH
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 09:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760130Ab0JGH6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 03:58:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:40840 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411Ab0JGH6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 03:58:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o977tEQt019356
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Oct 2010 09:55:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P3lJp-0005NF-A8; Thu, 07 Oct 2010 09:55:13 +0200
In-Reply-To: <1286437634-12593-1-git-send-email-avarab@gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Thu\,  7
 Oct 2010 07\:47\:14 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 07 Oct 2010 09:55:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158381>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> Change t/t5560-http-backend-noserver.sh to use the `X=3DY && export X=
'
> style instead of `export X=3DY'. The latter doesn't work on all POSIX
> shells.

According to

git grep '\<export [A-Za-z_]*=3D'

there seem to be a couple of other instances of this.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
