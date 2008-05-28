From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Tue, 27 May 2008 23:12:03 -0700
Message-ID: <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
References: <483AC2CE.7090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 08:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Euh-0005ER-6g
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 08:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbYE1GMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 02:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbYE1GMV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 02:12:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYE1GMU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 02:12:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 684B924DA;
	Wed, 28 May 2008 02:12:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C2C9E24D9; Wed, 28 May 2008 02:12:12 -0400 (EDT)
In-Reply-To: <483AC2CE.7090801@gmail.com> (Mark Levedahl's message of "Mon,
 26 May 2008 10:01:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 069805CE-2C7D-11DD-969B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83072>

Mark Levedahl <mlevedahl@gmail.com> writes:

> As this commit is part of the published master branch, I am not sure
> the correct resolution: leaving this commit in place means that any
> commit between it and a commit fixing this will always cause an error
> on Cygwin / Windows. Of course, it *is* on the published master branc=
h.

Some broken filesystems may not be capable of checking out and using
project files.  Too bad.

It's not a big deal.  It is not limited to this project.  We just fix t=
hem
or work them around and move on.

Perhaps we should remove the infamous gitweb/test/M=C3=A4rchen file whi=
le we
are at it?  I do not think the file is ever used.
