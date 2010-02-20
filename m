From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Re* [PATCH] Add `[decorate]' configuration section.
Date: Sat, 20 Feb 2010 18:49:03 +0100
Message-ID: <201002201849.03656.trast@student.ethz.ch>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz> <7vd403vhrn.fsf@alter.siamese.dyndns.org> <20100220171732.GA15561@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Drake <sdrake@xnet.co.nz>, <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 20:10:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NitSQ-0004dU-7u
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 18:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab0BTRt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 12:49:28 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:48851 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756742Ab0BTRt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 12:49:27 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 18:49:24 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 18:49:04 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <20100220171732.GA15561@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140542>

On Saturday 20 February 2010 18:17:44 Heiko Voigt wrote:
> On Wed, Feb 17, 2010 at 10:28:28AM -0800, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> 
> I have just seen this in Junios tree:
> 
> commit 8a3d203bd02bec48a02557961899d81da172fa23 writes:
> > Author: Junio C Hamano <gitster@pobox.com>
[...]
> >     Once a user has this configuration in ~/.gitconfig, there needs to be a
> >     way to override it from the command line.  Add --no-decorate option to
> >     log family and also allow --decorate=no to mean the same thing.  Since
> >     we allow setting log.decorate to 'true', the command line also should
> >     accept --decorate=yes and behave accordingly.
> 
> How about calling that option --plain, --porcelain or similar and have it
> disable all configs which change the current output? Because if we can go this
> way I would actually like to add more useful configurations. For example I
> always find me typing:
> 
> git log --decorate --abbrev-commit -p
> 
> which in most situations just gives you a nicer overview.

Since 66b2ed0 (Fix "log" family not to be too agressive about showing
notes, 2010-01-20), git log --pretty=... doesn't show notes.  Perhaps
at least the 'raw' format should also implicitly disable other user
configuration, including this?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
