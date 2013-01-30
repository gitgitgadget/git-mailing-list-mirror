From: Max Horn <max@quendi.de>
Subject: Re: Anybody know a website with up-to-date git documentation?
Date: Wed, 30 Jan 2013 14:27:51 +0100
Message-ID: <72077344-E4EF-43E1-A9E0-A907C423616F@quendi.de>
References: <D6EAC791-63E2-4B0E-92AA-676112039BD9@quendi.de> <20130130115439.GH1342@serenity.lan> <CA+xP2SbWKucCCPq3sS8Y2DQQM129urrM7-QzeDYju4+wA_-aUg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Sebastian Staudt <koraktor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 14:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Xi3-00062Y-68
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 14:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab3A3N1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 08:27:53 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48018 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753674Ab3A3N1w convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 08:27:52 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1U0Xhf-0000b3-8w; Wed, 30 Jan 2013 14:27:51 +0100
In-Reply-To: <CA+xP2SbWKucCCPq3sS8Y2DQQM129urrM7-QzeDYju4+wA_-aUg@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1359552472;326dc7fc;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215015>

Hi Sebastian,

On 30.01.2013, at 12:56, Sebastian Staudt wrote:

> Hello Max,
> 
> git-scm.com is the best source and it's not outdated.

Then it seems you are using the word "outdated" in a different way than me which I don't understand :-). Sure, it strives to be up-to-date, but fact is that it fails to do that, due to a bug (I guess). The end result (failure to update at all, vs. failure in an attempted update) sadly amount to the same.

> It gets an
> update after every single release of Git.
> See e.g. http://git-scm.com/docs/git-config which was updated in the
> current stable version.
> It seems that git-remote-helper's documentation was just not updated
> since version 1.7.12.3.

Yes, and it is not alone in that, which makes the site somewhat unreliable, sadly. Some more examples of pages tuck at version 1.7.12.3 and showing outdated content:

http://git-scm.com/docs/git-log
http://git-scm.com/docs/git-merge
http://git-scm.com/docs/git-merge-base
http://git-scm.com/docs/git-mergetool
http://git-scm.com/docs/git-reset
http://git-scm.com/docs/git-rm
http://git-scm.com/docs/git-status
http://git-scm.com/docs/git-symbolic-ref

I did not bother to check every single page, though, and I am pretty sure there are plenty more. Because there definitely is a plethora of other pages that are stuck at 1.7.12.3. Several of them still show the latest version due to not having had updates since the 1.7.12.3, but that is not always easy to tell due to included files (e.g. git-log.txt was not changed v1.7.12.2, but it includes rev-list-options.txt which was last changed in 1.8.1).


So, yeah, I do think git-scm.com is outdated -- in the sense that for many pages, it does not show the latest officially released version of the page.


Best regards,
Max