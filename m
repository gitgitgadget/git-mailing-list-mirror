From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Documentation: Mention that 'bisect' is reserved branch name
Date: Fri, 07 Nov 2008 12:13:30 +0200
Message-ID: <87wsff269h.fsf@iki.fi>
References: <2fcfa6df0811070201g75bfe659x38a4f14b1cf793c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Abhijit Bhopatkar" <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 11:17:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyOP4-0005uK-Ku
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 11:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbYKGKOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 05:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbYKGKOD
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 05:14:03 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:58003 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbYKGKOB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 05:14:01 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC900EFDF5E; Fri, 7 Nov 2008 12:13:37 +0200
In-Reply-To: <2fcfa6df0811070201g75bfe659x38a4f14b1cf793c6@mail.gmail.com> (Abhijit Bhopatkar's message of "Fri\, 7 Nov 2008 15\:31\:54 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100299>

Abhijit Bhopatkar (2008-11-07 15:31 +0530) wrote:

> "git bisect" uses 'bisect' branch to carry out it's operations.
> However "git branch" documentation does mention it.
> Add a note that 'bisect' can not be used as generic branch
> name by the user.

Hmm...

    commit 634f246444e6a1675e351f31362e6a375dc44f70
    Author: Christian Couder <chriscool@tuxfamily.org>
    Date:   2008-05-23 01:28:57 +0200

        bisect: use a detached HEAD to bisect
