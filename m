From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Pull is Evil
Date: Fri, 2 May 2014 09:40:27 +0200
Message-ID: <20140502074027.GB6288@inner.h.apk.li>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> <xmqqoazlqot4.fsf@gitster.dls.corp.google.com> <536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <xmqqa9b2egcy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 09:41:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg85d-00013h-OF
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 09:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbaEBHk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 03:40:58 -0400
Received: from continuum.iocl.org ([217.140.74.2]:46425 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaEBHk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 03:40:57 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s427eRe08079;
	Fri, 2 May 2014 09:40:27 +0200
Content-Disposition: inline
In-Reply-To: <xmqqa9b2egcy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247927>

On Wed, 30 Apr 2014 13:01:49 +0000, Junio C Hamano wrote:
...
> I didn't mean "replace 'pull' with 'update' everywhere".  I meant
> "Introduce 'update' that lets integrate your history into that from
> the remote, which is to integrate in a direction opposite from how
> 'pull' does".  

That still doesn't quite solve my problem. If I'm tracking origin/master
in a local master branch, I can just use 'git pull' to get my 'feature'
branch (which is named master) updated to the current state of the origin.
This amounts to 'integrating' origin/master into my master.

When I finally want to deliver and push to origin/master, I put on the
integrator's hat, and I cat do a 'git update' that will do the merge
in reverse, and push the result to origin/master. The result will look
like origin pulled my master branch into his.

Problem is that whether to use pull or update depends on whether I
intend to push afterwards; and additionally, if I can push fast-forward
without needing to 'git update' the integration into origin/master will
look weird.

(Oh, and please don't name it 'update' - we have an important alias
of that name.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
