From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re* [PATCH] Add `[decorate]' configuration section.
Date: Sat, 20 Feb 2010 18:17:44 +0100
Message-ID: <20100220171732.GA15561@book.hvoigt.net>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz> <7vr5ojwy38.fsf@alter.siamese.dyndns.org> <7vd403vhrn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 18:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nisxl-00011x-0p
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 18:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab0BTRRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 12:17:48 -0500
Received: from darksea.de ([83.133.111.250]:58669 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753942Ab0BTRRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 12:17:47 -0500
Received: (qmail 2643 invoked from network); 20 Feb 2010 18:17:44 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2010 18:17:44 +0100
Content-Disposition: inline
In-Reply-To: <7vd403vhrn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140536>

On Wed, Feb 17, 2010 at 10:28:28AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

I have just seen this in Junios tree:

commit 8a3d203bd02bec48a02557961899d81da172fa23 writes:
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Wed Feb 17 10:20:49 2010 -0800
> 
>     log.decorate: usability fixes
>     
>     The configuration is meant to suppliment --decorate command line option
>     that can be used as a boolean to turn the feature on, so it is natural
>     to expect
>     
>         [log]
>                 decorate
>                 decorate = yes
>     
>     to work.  The original commit would segfault with the first one, and
>     would not understand the second one.
>     
>     Once a user has this configuration in ~/.gitconfig, there needs to be a
>     way to override it from the command line.  Add --no-decorate option to
>     log family and also allow --decorate=no to mean the same thing.  Since
>     we allow setting log.decorate to 'true', the command line also should
>     accept --decorate=yes and behave accordingly.

How about calling that option --plain, --porcelain or similar and have it
disable all configs which change the current output? Because if we can go this
way I would actually like to add more useful configurations. For example I
always find me typing:

git log --decorate --abbrev-commit -p

which in most situations just gives you a nicer overview.

cheers Heiko
