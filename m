From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Tue, 21 May 2013 09:13:45 +0200
Message-ID: <87a9nobyae.fsf@linux-k42r.v.cablecom.net>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
	<CACsJy8Cr7AKxo9sUjMCVQ0=O91L8CRoxD3qrvZczCrBUq4TDzA@mail.gmail.com>
	<7vk3mtwrq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 09:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uegle-0000C2-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 09:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab3EUHNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 03:13:50 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39325 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480Ab3EUHNt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 03:13:49 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 21 May
 2013 09:13:42 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 21 May 2013 09:13:45 +0200
In-Reply-To: <7vk3mtwrq9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 May 2013 09:17:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225018>

Junio C Hamano <gitster@pobox.com> writes:

> In addition to your topic, it may be a good idea to notice this at
> the Porcelain level (e.g. "checkout -b" and "branch", but not at the
> "update-ref" level) and warn or even die if a Porcelain tries to
> create a branch with such a name.

But if we're going there and deprecating some ways of naming refs,
please also disallow some other funny things in the same go.  Michael
suggested this earlier in some thread: the fewer ways we have of legally
spelling refnames, the more syntax is available for revision syntax.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
