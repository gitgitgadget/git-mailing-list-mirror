From: Sergei Organov <osv@javad.com>
Subject: Re: Surprising 'git-describe --all --match' behavior.
Date: Fri, 20 Jun 2014 00:12:11 +0400
Message-ID: <8761jwd5gk.fsf@osv.gnss.ru>
References: <87ionxxbz8.fsf@osv.gnss.ru>
	<xmqqr42khl3l.fsf@gitster.dls.corp.google.com>
	<87d2e4d8w7.fsf@osv.gnss.ru>
	<xmqq38f0hg0h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:12:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxih6-0005ap-V7
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138AbaFSUMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:12:15 -0400
Received: from mail.javad.com ([54.86.164.124]:43598 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112AbaFSUMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:12:14 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id B9C1F615BB;
	Thu, 19 Jun 2014 20:12:12 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1Wxigt-000705-3X; Fri, 20 Jun 2014 00:12:11 +0400
In-Reply-To: <xmqq38f0hg0h.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 Jun 2014 12:10:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252174>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Will something break if it won't helpfully prepend refs/tags/ once
>> --all is given?
>
> "describe --all --match 'v*'" will no longer match a tag v1.2.3, and
> forces the users to say "describe --match 'refs/tags/v*'",

No,

descirbe --match 'v*'

or

describe --tags --match 'v*'

depending on what they actually meant. Notice my "once --all is given"
above. 

Those who used --all meant to match against all the refs, no?

> and these users will probably see it as a new breakage, I would imagine.

But why would anybody use --all --match if they only meant --tags
--match or even just --match alone? Was it historically --all that was
first introduced, maybe? 

-- 
Sergei.
