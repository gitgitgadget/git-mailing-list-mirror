From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something weird is happening...
Date: Sat, 31 Jan 2009 17:31:42 -0800
Message-ID: <7vk58b0wox.fsf@gitster.siamese.dyndns.org>
References: <49814BA4.6030705@zytor.com>
 <7vr62mha7a.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0901290545s1a5ba310u549338e823762ae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRD3-0003cs-Iz
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbZBABbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbZBABbv
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:31:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZBABbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:31:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EFBC95857;
	Sat, 31 Jan 2009 20:31:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9720095854; Sat,
 31 Jan 2009 20:31:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18F6FA6C-F000-11DD-9E96-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107962>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Thu, Jan 29, 2009 at 07:56, Junio C Hamano <gitster@pobox.com> wrote:
>>> Okay, what is going on here?
>
> Is this perhaps related to the problem the github guys were having,
> its sounds similar, problem not showing up until after upgrade,
> missing objects, no?

I do not think so.  The push problem does not lead to any repository
corruption, and does not have anything to do with the fsck misreporting a
blob that exists in an alternate object store as missing, either.

.
