From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 00:32:05 +0100
Message-ID: <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Harl <sh@tokkee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:33:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4PSI-0007a5-S6
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918AbXLQXcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756040AbXLQXcj
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:32:39 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:34192 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbXLQXci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:32:38 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1J4PRr-00006f-W3; Tue, 18 Dec 2007 00:32:36 +0100
In-Reply-To: <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68664>

On Dec 18, 2007, at 12:00 AM, Junio C Hamano wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>
>> ...  The current behavior of git stash is very
>> dangerous as the following frequently happens to new comers:
>>   $ git stash
>>   $ <hack on something else>
>>   $ git commit
>>   $ git stash apply
>>   $ git stash clean # Oops, typo, I just stashed my changes again
>>   $ git stash clear # Oops, I just lost my changed
>
> This is a plain FUD, isn't it?  The first Oops should not happen these
> days.


*git pull in git*
*reads Documentation/RelNotes-1.5.4.txt*

Blah.  I didn't know follow the development over the past 3 weeks  
well enough, sorry for the noise.  I'm glad that this was improved.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
