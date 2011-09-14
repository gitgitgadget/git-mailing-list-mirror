From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 12:45:58 +0200
Message-ID: <4E7085E6.3060509@alum.mit.edu>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com> <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 12:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3mz4-00021V-PN
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 12:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387Ab1INKqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 06:46:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54362 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab1INKqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 06:46:18 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8EAjwIq021165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Sep 2011 12:45:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181350>

On 09/14/2011 09:06 AM, Linus Torvalds wrote:
> So I'm not against signed pushes, but quite frankly, if you add some
> per-branch signature, I would argue against it unless that signature
> also comes with information that allows us to do a better job of human
> communication too. Like a branch description.
> 
> Imagine, for example, than when you do a
> 
>   git push -s ..
> 
> git would *require* you to actually write a message about what you are
> pushing. And when somebody pulls it, and creates a merge commit, that
> explanation would become part of the merge message. The "signature"
> part of the "-s" should be thought of as the *much* less interesting
> part - that's just a small detail that git can use to verify
> something, but it doesn't actually matter for the contents of the
> pull. Not like the actual human-readable message would.
> 
> Now *that* would be lovely. No?

Instead of "like a branch description", why not implement branch
descriptions directly?

I wish that one could annotate a branch (e.g., at creation) and have the
annotation follow the branch around.  This would be a useful place to
record *why* you created the branch, your plans for it, etc.  The
annotation should be modifiable, because often a branch evolves in
unforeseen ways during its lifetime.  Anybody could read the annotation
to get a quick idea of what kind of work is in progress.

Such a branch annotation could be used in pull requests, the cover
letter of patch series emails, merge commit log messages, etc.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
