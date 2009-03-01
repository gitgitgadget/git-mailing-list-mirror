From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Changing the defaults for send-email / suppress-cc ?
Date: Sun, 01 Mar 2009 07:49:00 +0200
Message-ID: <87ljrphjxv.fsf@iki.fi>
References: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 06:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdeZS-0000ty-RW
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 06:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbZCAFtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 00:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbZCAFtI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 00:49:08 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:46013 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbZCAFtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 00:49:08 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A8805AA5A79; Sun, 1 Mar 2009 07:49:01 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LdeXs-0000zp-HF; Sun, 01 Mar 2009 07:49:00 +0200
In-Reply-To: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com> (Paul Gortmaker's message of "Sat\, 28 Feb 2009 14\:29\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111816>

On 2009-02-28 14:29 (-0500), Paul Gortmaker wrote:

> I've been involved in helping people who are new git users, and the
> one thing that seems to violate the principle of least surprise for
> them is the default setting for the sendemail.suppresscc -- in that
> the new users don't expect the additional CC lines to be automatically
> added based on what is present in the content of the mbox
> (format-patch output).

> In light of this, I've simply advised new users to run something like:
>
> git config --global sendemail.suppresscc all
>
> ...just so that they won't accidentally do what I've described in the
> above.

Agreed. In the past I have sent a couple of test patches to wrong places
because of these automatic CCs. I think that send-email or any e-mail
client should only send mail for addresses which user has explicitly
selected or otherwise confirmed.

With a time machine I would make the opposite option for send-email:
something like sendemail.autocc and --autocc=. Then user would configure
different recipient categories who she wants to send automatic CCs. It's
easier to think this way. But we don't have a time machine so at least
some kind confirm message would be nice.
