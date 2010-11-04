From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: .git as file pointing to directory?
Date: Thu, 04 Nov 2010 23:14:15 +0100
Message-ID: <vpqbp64d9e0.fsf@bauges.imag.fr>
References: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com>
	<vpqpqulc52q.fsf@bauges.imag.fr> <4CD31904.5040308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad Larson <bklarson@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 04 23:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE84h-0007BO-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab0KDWOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 18:14:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52549 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab0KDWOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:14:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA4M7eb7030243
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Nov 2010 23:07:41 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PE84V-000642-BQ; Thu, 04 Nov 2010 23:14:15 +0100
In-Reply-To: <4CD31904.5040308@web.de> (Jens Lehmann's message of "Thu\, 04 Nov 2010 21\:35\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Nov 2010 23:07:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA4M7eb7030243
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289513265.56388@wP8kOEWlmsRqStAsIfGplg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160784>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 04.11.2010 19:32, schrieb Matthieu Moy:
>> Brad Larson <bklarson@gmail.com> writes:
>> 
>>> Sorry if this is obvious, I can't figure out what term to search for.
>>>
>>> At gittogether there was some talk about having .git be a file, not a
>>> folder, with contents pointing to the real .git directory.  Similar to
>>> a symlink, but supported in Windows.  Is there a specific name for
>>> this feature?  Where can I find more details?  Which version of git
>>> introduced this?
>> 
>> It has been discussed under the name "gitlink", which was
>> unfortunately also used for something else in the subtree
>> implementation, but AFAIK, it has never been implemented.
>
> Hmm, AFAIK gitlinks are already in heavy use for submodule entries ...

Err, isn't that precisely what I was saying? The same word has been
used in the subtree implementation, but the other concept with the
same name hasn't been implemented.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
