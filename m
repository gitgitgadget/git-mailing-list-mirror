From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 16:14:56 +0200
Message-ID: <20080723141456.GA13556@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723174140.b749191a.vsu@altlinux.ru> <20080723140959.GB9537@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLf8T-0000it-5o
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbYGWOPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbYGWOPJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:15:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:50904 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbYGWOPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:15:08 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KLf7K-0000Vg-TY
	from <mingo@elte.hu>; Wed, 23 Jul 2008 16:15:07 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 21A693E21AB; Wed, 23 Jul 2008 16:14:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723140959.GB9537@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.2.3
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0342]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89662>


* Ingo Molnar <mingo@elte.hu> wrote:

> Even assuming that the filesystem is sane, is my merge-cache 
> implementation semantically equivalent to a git-merge? One detail is 
> that i suspect it is not equivalent in the git-merge --no-ff case. 
> (but that is a not too interesting non-default case anyway)

actually, since --no-ff creates a merge commit and thus propagates the 
head sha1, this should work fine as well.

(besides the small detail that my script has $1 hardcoded so parameters 
are not properly passed onto.)

	Ingo
