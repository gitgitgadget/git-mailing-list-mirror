From: "Bernhard R. Link" <brl@pcpool00.mathematik.uni-freiburg.de>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Fri, 18 Dec 2009 15:47:57 +0100
Message-ID: <20091218144756.GA7211@pcpool00.mathematik.uni-freiburg.de>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de> <4B29106C.1040501@viscovery.net> <7vaaxhfcfe.fsf@alter.siamese.dyndns.org> <20091218130603.GA6193@pcpool00.mathematik.uni-freiburg.de> <4B2B8213.1090104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 15:53:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLe84-0003FO-EZ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 15:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbZLROsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 09:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754391AbZLROsB
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 09:48:01 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:46549
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754381AbZLROr7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 09:47:59 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLe7Z-0003tA-AK; Fri, 18 Dec 2009 15:47:57 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLe7Z-0001tz-8F; Fri, 18 Dec 2009 15:47:57 +0100
Mail-Followup-To: git@vger.kernel.org, j.sixt@viscovery.net
Content-Disposition: inline
In-Reply-To: <4B2B8213.1090104@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135411>

* Johannes Sixt <j.sixt@viscovery.net> [091218 14:22]:
> > format-patch has to choose a parent. Choosing the first one make the
> > most sense for me (as the first is the only real 'special' one).
> > In the workflows I envision the first parent would also be the one with
> > the clean history.
>
> Then use
>
>    git format-patch --first-parent upstream..

As already described in the thread my mail contained a link to, this
will miss patches if there were also real merges (which there will).

But the point that there is only a --first-parent and no --last-parent
shows that the first parent is special, so format-patch should choose
the first one.

Hochachtungsvoll,
	Bernhard R. Link
-- 
Please do not CC me if also sending to git@vger.kernel.org.
