From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: Best way to apply textconv to a working tree file
Date: Wed, 02 Jun 2010 17:12:38 +0200
Organization: Ensimag
Message-ID: <a4d60325ac1eba4038ca65739105b20d@ensimag.fr>
References: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr> <vpqd3walot1.fsf@bauges.imag.fr> <20100601171359.GD9702@sigill.intra.peff.net> <vpqtypmaceb.fsf@bauges.imag.fr> <20100601195036.GA18220@sigill.intra.peff.net>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 17:12:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpcc-0003KX-6t
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 17:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430Ab0FBPMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 11:12:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49335 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758419Ab0FBPMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 11:12:40 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o52F5F0q020706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 2 Jun 2010 17:05:15 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o52FCd2I012377
	for <git@vger.kernel.org>; Wed, 2 Jun 2010 17:12:39 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o52FCcRl006339
	for <git@vger.kernel.org>; Wed, 2 Jun 2010 17:12:39 +0200
In-Reply-To: <20100601195036.GA18220@sigill.intra.peff.net>
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Jun 2010 17:05:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o52F5F0q020706
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
MailScanner-NULL-Check: 1276095915.83686@P9JWT3vo/TZrQeA3FSDGjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148258>

We have finally chosen to use the "git cat-file --textconv
<commit_sha1>:<filename>" option, it works fine.
We are now using your patch to easily get the path, and it seems to fit
very well too :)

Thanks a lot
