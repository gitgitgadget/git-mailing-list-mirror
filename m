From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Sat, 21 Feb 2009 11:29:58 -0800
Message-ID: <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marius Storm-Olsen <git@storm-olsen.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaxZY-00070Z-7k
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 20:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbZBUTaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 14:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbZBUTaH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 14:30:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbZBUTaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 14:30:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DAD979A123;
	Sat, 21 Feb 2009 14:30:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 934D19A122; Sat,
 21 Feb 2009 14:30:00 -0500 (EST)
In-Reply-To: <1235227723-11471-1-git-send-email-git@storm-olsen.com> (Marius
 Storm-Olsen's message of "Sat, 21 Feb 2009 15:48:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0A589994-004E-11DE-BB6B-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110976>

Marius Storm-Olsen <git@storm-olsen.com> writes:

> Prefixes the branch name with "BARE:" if you're in a
> bare repository.

The updated code may correctly detect when you are in such a situation,
but I have to wonder why anybody would even want to be reminded that he is
in a bare repository to begin with.

For doing any usual work of growing history, you would work inside a
repository with an work tree.  The only occasion you would *go* to a bare
repository would be to tweak, futz with and fix one that is used as a
distribution point, isn't it?  You usually update such a repository by
pushing into it, so your being there would be a result of very conscious
act of chdir'ing into it yourself, and you wouldn't be spending too much
time in there anyway.

There may be a different workflow where you would stay in a bare
repository for an extended period of time and you would benefit from such
a reminder like this patch adds, but I do not think of one.

Care to enlighten?
