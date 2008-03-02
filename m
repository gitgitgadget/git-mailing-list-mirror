From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin clone: support bundles
Date: Sun, 02 Mar 2008 09:54:16 -0800
Message-ID: <7vd4qdnh9z.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <200802260321.14038.johan@herland.net>
 <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
 <alpine.LSU.1.00.0803020556380.22527@racer.site>
 <alpine.LSU.1.00.0803020622190.22527@racer.site>
 <alpine.LSU.1.00.0803020743170.22527@racer.site>
 <alpine.LNX.1.00.0803021128510.19665@iabervon.org>
 <alpine.LSU.1.00.0803021731400.22527@racer.site>
 <7vhcfpnhfk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Kristian =?utf-8?Q?H=C3=B8gsb?= =?utf-8?Q?erg?= 
	<krh@redhat.com>, Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsP2-0003rI-63
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbYCBRyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412AbYCBRyf
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:54:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbYCBRye (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:54:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D6502570;
	Sun,  2 Mar 2008 12:54:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5588F2562; Sun,  2 Mar 2008 12:54:24 -0500 (EST)
In-Reply-To: <7vhcfpnhfk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 02 Mar 2008 09:50:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75820>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=d066bd60e5a93d69c47318cf6e71f77c84b737e6
>
> FYI, I already queued this for 'master'.

Clarification.

What I queued is _not_ the builtin-clone change, but the patch that your
gitweb URL shows, which is a fix for e5392c5 (Add is_absolute_path() and
make_absolute_path()).

