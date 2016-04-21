From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 14:51:13 +0200
Message-ID: <vpqy487unum.fsf@anie.imag.fr>
References: <20160421113004.GA3140@aepfle.de> <vpqmvonw4a6.fsf@anie.imag.fr>
	<20160421123251.GA3186@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:51:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atE4r-0004CV-KM
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 14:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbcDUMvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 08:51:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48324 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbcDUMvV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 08:51:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3LCpCoF023898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 21 Apr 2016 14:51:12 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3LCpDVX009245;
	Thu, 21 Apr 2016 14:51:13 +0200
In-Reply-To: <20160421123251.GA3186@aepfle.de> (Olaf Hering's message of "Thu,
	21 Apr 2016 14:32:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 21 Apr 2016 14:51:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3LCpCoF023898
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461847876.04661@dQ6ZOy3RlafcyfBW3Tycig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292108>

Olaf Hering <olaf@aepfle.de> writes:

> On Thu, Apr 21, Matthieu Moy wrote:
>
>> My guess is that this commit has been sitting for a long time in a
>> repo outside Linus' linux.git, and got merged only recently.
>
> Thats what it looks like. And thats what I'm complaining about. But in
> fact that file is there since v3.13-rc7 (if the tag is really correct in
> my patch file), since at least end of 2014.

Ah, indeed. It was merged right before 3.13. See "git tag --contains
aed06b9cfcab".

It's indeed weird that "git describe --contains" gives a named based on
tag v4.6-rc1, but it is not really incorrect since tags/v4.6-rc1~9^2~792
is indeed a correct name for aed06b9cfcabf8644ac5f6f108c0b3d01522f88b,
and actually uses a tag that follows it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
