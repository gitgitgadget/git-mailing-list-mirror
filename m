From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Sun, 03 Feb 2008 16:39:06 -0800
Message-ID: <7vfxw9pnbp.fsf@gitster.siamese.dyndns.org>
References: <prvd3i9e.fsf@blue.sea.net> <ir15399p.fsf@blue.sea.net>
	<m3lk6161jo.fsf@localhost.localdomain> <zluh1sxv.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:39:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLpNI-00088a-HL
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYBDAjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYBDAjT
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:39:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbYBDAjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:39:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C1F911B0;
	Sun,  3 Feb 2008 19:39:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C818B11AF;
	Sun,  3 Feb 2008 19:39:12 -0500 (EST)
In-Reply-To: <zluh1sxv.fsf@blue.sea.net> (Jari Aalto's message of "Mon, 04 Feb
	2008 02:11:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72437>

Jari Aalto <jari.aalto@cante.net> writes:

> * Sun 2008-02-03 Jakub Narebski <jnareb@gmail.com> INBOX
>> I would say "[--whitespace=<option>]" or "[--whitespace=<action>]"
>> instead of introducing yet not agreed upon notation (this has the
>> advantage of shortening synopisis, which should be short IMHO).
>
> The "{a|b|c}" is a used syntax. See cpio(1).
>  
>     cpio  {-o|--create} [-0acvABLV] ...

I do not think using {} for grouping is incorrect, and I think
there is at least a consensus on the list that it is Ok as long
as we consistently do so.

Unfortunately, the majority of, if not all of, our existing
documents use () instead for that purpose.

So pros-and-cons are that (1) changing all of them to use {} is
more politically correct (pro); (2) our use of (), as we
consistently use them, does not hurt readability (neutral); and
(3) it is a thankless makework to replace them all to {} _and
make sure the conversion is correct_ (large con).  (4) also if
other people make changes to documentation at the same time,
that would add more work in conflict resolution (slight con).

As you seem to have volunteered to do the conversion and
validation, I do not see much problem to move from () to {} in
principle.

About the part your patch touches, [--whitespace={a|b|c}] is
more precise than [--whitespace=a|b|c] Jakub suggested, but I
suspect most sane people would not misinterpret the latter as
"this part can be omitted but you could write '--whitespace=a',
'b' or 'c' here", so...
