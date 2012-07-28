From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Bug: Recursive submodules fail when the repo path contains
	spaces
Date: Sat, 28 Jul 2012 18:21:32 +0200
Message-ID: <20120728162132.GC98893@book.hvoigt.net>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com> <500F00C7.4040209@web.de> <7va9yogb37.fsf@alter.siamese.dyndns.org> <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 18:21:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv9lz-0004Ax-3S
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 18:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab2G1QVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 12:21:41 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:59862 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab2G1QVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 12:21:41 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sv9ll-0004mv-K1; Sat, 28 Jul 2012 18:21:33 +0200
Content-Disposition: inline
In-Reply-To: <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202448>

On Tue, Jul 24, 2012 at 01:33:44PM -0700, Justin Spahr-Summers wrote:
> Here's some real output, with a couple specific names removed, starting from the root of the top-level repository (where External/twui is a submodule):
> 
> $ cd External/twui
> $ git submodule add git://github.com/petejkim/expecta.git TwUITests/expecta
> Cloning into 'TwUITests/expecta'...
> remote: Counting objects: 988, done.
> remote: Compressing objects: 100% (404/404), done.
> remote: Total 988 (delta 680), reused 842 (delta 535)
> Receiving objects: 100% (988/988), 156.30 KiB, done.
> Resolving deltas: 100% (680/680), done.
> fatal: Not a git repository: ../../../../../../../../Volumes/drive name with spaces/Users/justin/Documents/Programming/project name with spaces/.git/modules/External/twui/modules/TwUITests/expecta

Is this a copy&paste artefact or is the path in the error truncated?

Cheers Heiko
