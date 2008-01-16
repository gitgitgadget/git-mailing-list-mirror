From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 10:59:48 +0100
Message-ID: <vpq4pdeum3v.fsf@bauges.imag.fr>
References: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 11:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF55B-0006F7-2L
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 11:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYAPKAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 05:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYAPKAo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 05:00:44 -0500
Received: from imag.imag.fr ([129.88.30.1]:46670 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbYAPKAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 05:00:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m0G9xsJJ016871
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 10:59:54 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JF53l-0000uc-1P; Wed, 16 Jan 2008 10:59:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JF53k-0000ZV-VH; Wed, 16 Jan 2008 10:59:48 +0100
In-Reply-To: <478D79BD.7060006@talkingspider.com> (Mike's message of "Tue\, 15 Jan 2008 22\:27\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 16 Jan 2008 10:59:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70647>

Mike <fromlists@talkingspider.com> writes:

> I'm learning git and I'm really annoyed that the .git directory lives
> in the same directory as my code.  I don't want it there for three
> reasons:

The idea was discussed here, mostly under the name "gitlink". I'd like
it for another reason :

* Have my tree on a fast, unrelialbe local disk, and have my .git on a
  slower, but safe and backed-up NFS partition.

But up to now, AFAIK, no one (including myself ;-) ) stepped-in to
implement it.

-- 
Matthieu
