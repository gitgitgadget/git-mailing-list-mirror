From: Johan Herland <johan@herland.net>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 18:14:04 +0200
Message-ID: <201109141814.04752.johan@herland.net>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <vpqfwjzxu6i.fsf@bauges.imag.fr> <CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 18:14:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3s6y-0000W4-MT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 18:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab1INQOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 12:14:52 -0400
Received: from smtp.opera.com ([213.236.208.81]:42864 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756357Ab1INQOv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 12:14:51 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p8EGECGE026538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Sep 2011 16:14:13 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181366>

On Wednesday 14. September 2011, Linus Torvalds wrote:
> On Wed, Sep 14, 2011 at 4:03 AM, Matthieu Moy
> 
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Would the notes mechanism be able to annotate ref names instead of
> > commit sha1?
> 
> That would be a horrible, horrible notion.
> 
> It's quite common to have multiple branches with the same SHA1. It
> might be in the "experimental-development" branch, but it got through
> testing with flying colors and deemed to be stable, so it got
> upgraded to the "for-linus" branch, and there hasn't been any other
> development since. So now both "for-linus" and
> "experimental-development" are the same commit, but they are very
> much not the same branch!
> 
> So no, don't confuse branch *contents* with branch *descriptions*.

I don't think the suggestion was about annotating the branch tip as a 
way of describing the branch. Rather, you create a _new_ SHA1 that 
identifies the branch (e.g. SHA1(branch_name) ), and then annotate 
_that_ SHA1. As I said, that _can_ be done with the notes 
infrastructure, but - as Ted noted - there might be better solutions to 
storing branch descriptions.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
