From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Thu, 23 May 2013 21:27:25 +0200
Message-ID: <20130523192725.GS9448@inner.h.apk.li>
References: <7v38tgno2k.fsf@alter.siamese.dyndns.org> <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com> <7vppwkm682.fsf@alter.siamese.dyndns.org> <CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com> <7v7girks4s.fsf@alter.siamese.dyndns.org> <CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com> <7vppwjj5ws.fsf@alter.siamese.dyndns.org> <CALkWK0mfGWA3aBntQQU5fkCJDPx+MUOScvMRJjS+JzjNucFzPw@mail.gmail.com> <20130523085359.GA23933@inner.h.apk.li> <7vmwrlhi0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 21:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfbAn-0002Zq-5g
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421Ab3EWT1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:27:33 -0400
Received: from continuum.iocl.org ([217.140.74.2]:39259 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab3EWT1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:27:33 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4NJRPm20207;
	Thu, 23 May 2013 21:27:25 +0200
Content-Disposition: inline
In-Reply-To: <7vmwrlhi0h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225286>

On Thu, 23 May 2013 07:45:34 +0000, Junio C Hamano wrote:
...
> Even with 'mv', between the time the main in mv starts and the
> process finally issues rename(2) on the directory, you can start
> running what competes and interferes with it in another terminal,
> so it does not fundamentally change anything, I would have to say.

Not fundamentally, it's just that the mv is fast enough you wouldn't
even think of switch to another term/backgrounding it.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
