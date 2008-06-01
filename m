From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sat, 31 May 2008 18:06:43 -0700
Message-ID: <7v7idadkv0.fsf@gitster.siamese.dyndns.org>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de>
 <20080531182555.1646.47950.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>,
	Kay Sievers <kay.sievers@suse.de>
X-From: git-owner@vger.kernel.org Sun Jun 01 03:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2c3k-000544-U2
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 03:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYFABHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2008 21:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbYFABHF
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 21:07:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYFABHE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 May 2008 21:07:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A0174A65;
	Sat, 31 May 2008 21:07:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 960AF4A64; Sat, 31 May 2008 21:06:52 -0400 (EDT)
In-Reply-To: <20080531182555.1646.47950.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Sat, 31 May 2008 20:28:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B0644C0-2F77-11DD-8792-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83420>

Jakub Narebski <jnareb@gmail.com> writes:

> Testing if gitweb handles filenames with spaces, filenames with plus
> sign ('+') which encodes spaces in CGI parameters (in URLs), and
> filenames with Unicode characters should be handled by gitweb tests.
>
> Those files are remainder of the time when gitweb was project on its
> own, not a part of git (with its testsuite).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> ...
>  "gitweb/test/M\303\244rchen" |    2 --
>  gitweb/test/file with spaces |    4 ----
>  gitweb/test/file+plus+sign   |    6 ------
>  3 files changed, 0 insertions(+), 12 deletions(-)
>  delete mode 100644 gitweb/test/M=C3=A4rchen
>  delete mode 100644 gitweb/test/file with spaces
>  delete mode 100644 gitweb/test/file+plus+sign

I do not think Kay minds, but it would not hurt to give him a courtesy
copy of this before finally applying such a patch.

-jc
