From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to delete large files
Date: Fri, 02 Oct 2009 13:41:04 +0200
Message-ID: <vpq7hvekoq7.fsf@bauges.imag.fr>
References: <C6EB1E10.D7AB%nilshomer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Nils Homer <nilshomer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 13:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtgaS-0008Uc-1t
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 13:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZJBLqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 07:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZJBLqA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 07:46:00 -0400
Received: from imag.imag.fr ([129.88.30.1]:50686 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbZJBLp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 07:45:59 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n92Bggre013393
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Oct 2009 13:42:43 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MtgVV-0005d3-1Z; Fri, 02 Oct 2009 13:41:05 +0200
In-Reply-To: <C6EB1E10.D7AB%nilshomer@gmail.com> (Nils Homer's message of "Fri\, 02 Oct 2009 03\:03\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 02 Oct 2009 13:42:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129439>

Nils Homer <nilshomer@gmail.com> writes:

> Still (using du =ADh) the repository is 656MB and I can see the above=
 files in
> the revision list:
> git rev-list --all --objects | grep tests.long/save/save.tar.gz
> ee2ee50c5075d05d29764c8d4b9acc2acedda919 tests.long/save/save.tar.gz
> e568480bcb8239e6d1ed8d2da86c309c0d3d101b tests.long/save/save.tar.gz
> f9f2faab597d4f8ccbfac2864347dbc256353fbf tests.long/save/save.tar.gz
> 926b1ba880a26354c4a6b9391985f57fbc9a1174 tests.long/save/save.tar.gz
> e3c0ee53f20e8ebfb60eaefcd7b405168c26a565 tests.long/save/save.tar.gz
>
> Could this be because of tags that I had previously created?

I guess so. Anything pointing to the old history will prevent Git from
deleting it.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
