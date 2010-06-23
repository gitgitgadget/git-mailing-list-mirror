From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Uncommitted source and header files disappeared after a git mv  operation
Date: Wed, 23 Jun 2010 13:23:35 +0200
Message-ID: <vpqwrtqf0w8.fsf@bauges.imag.fr>
References: <AANLkTikeW1-Kzdyu1APSqzKGsNnny6InueWluXsKMccU@mail.gmail.com>
	<AANLkTiloMDccUDObmPXPGWI_HYVDMk57EoHxZjFUiSvi@mail.gmail.com>
	<AANLkTilNI0lq0rUqvUIdNRpubNUNqKf3_5nX3TGauvQv@mail.gmail.com>
	<AANLkTim8TblD_TUpmGR2vCjQnXMfK4WAFA3dh39dloAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Wed Jun 23 13:27:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORO6o-0000hS-Ou
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab0FWL1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 07:27:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:54780 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab0FWL1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 07:27:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o5NBNbCw022763
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 23 Jun 2010 13:23:37 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ORO3M-0005wS-6W; Wed, 23 Jun 2010 13:23:36 +0200
In-Reply-To: <AANLkTim8TblD_TUpmGR2vCjQnXMfK4WAFA3dh39dloAs@mail.gmail.com> (Laszlo Papp's message of "Wed\, 23 Jun 2010 12\:50\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 23 Jun 2010 13:23:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149509>

Laszlo Papp <djszapi@archlinux.us> writes:

> I had some news.
>
> I have just checked the bash history on linux, which doesn't contain
> any intereting, but I have just realised the situation now, so the
> following happened:
>
> 1) So the uncommitted files were on windows
> 2) I renamed the whole directory under linux.
> 3) I pushed the changes under linux
> 4) At last I did a git pull under windows.

Are you sure the files are not where they used to be (i.e. under the
directory name used before renaming)?

Git usually takes great care not to touch untracked files. I'd be very
surprised if it did for you.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
