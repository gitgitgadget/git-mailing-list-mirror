From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: .git as file pointing to directory?
Date: Thu, 04 Nov 2010 19:32:45 +0100
Message-ID: <vpqpqulc52q.fsf@bauges.imag.fr>
References: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad Larson <bklarson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 19:33:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE4cL-0002nm-SH
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab0KDScw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:32:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52027 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab0KDScu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:32:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA4IHewU019734
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Nov 2010 19:17:40 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PE4c9-0003pd-UO; Thu, 04 Nov 2010 19:32:46 +0100
In-Reply-To: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com> (Brad Larson's message of "Thu\, 4 Nov 2010 13\:22\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Nov 2010 19:17:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA4IHewU019734
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289499463.01465@9GLaS1OroRYUC5csDG2alQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160745>

Brad Larson <bklarson@gmail.com> writes:

> Sorry if this is obvious, I can't figure out what term to search for.
>
> At gittogether there was some talk about having .git be a file, not a
> folder, with contents pointing to the real .git directory.  Similar to
> a symlink, but supported in Windows.  Is there a specific name for
> this feature?  Where can I find more details?  Which version of git
> introduced this?

It has been discussed under the name "gitlink", which was
unfortunately also used for something else in the subtree
implementation, but AFAIK, it has never been implemented.

The closest equivalent is git-new-workdir, but it relies on symlinks,
and shares a bit more than it should with the other repository (i.e.
if you checkout the same branch is two workdirs, you're doomed).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
