From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2] Teach rebase to rebase even if upstream is up to 
 date
Date: Sat, 14 Feb 2009 11:56:58 -0800
Message-ID: <7vr620ssfp.fsf@gitster.siamese.dyndns.org>
References: <1234565281-20960-1-git-send-email-srabbelier@gmail.com>
 <alpine.DEB.1.00.0902140703540.10279@pacific.mpi-cbg.de>
 <bd6139dc0902140957pa5852d6m61211054b3f5e395@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQeq-0004jP-D4
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZBNT5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbZBNT5H
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:57:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbZBNT5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:57:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 69F702B21F;
	Sat, 14 Feb 2009 14:57:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A5BAF2B21E; Sat,
 14 Feb 2009 14:57:00 -0500 (EST)
In-Reply-To: <bd6139dc0902140957pa5852d6m61211054b3f5e395@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat, 14 Feb 2009 18:57:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6C76512-FAD1-11DD-82C5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109911>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sat, Feb 14, 2009 at 07:07, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> I know that you can turn it off with --whitespace=nowarn, but that's
>> such an outlier that we do not have to care about it, right?
>
> Well, actually, in the v1 thread Junio mentioned that it should not
> imply -f for --whitespace=nowarn.
>
>> Or if we really want to:
>>
>>        --whitespace=nowarn) ;;
>>        --whitespace=*) force_rebase=t ;;
>>
>> Hm?
>
> No strong opinion on my side, what does the gitster have to say about it?

"Fix" is obviously a request to "fix" things.  On the other hand, at least
to me, "warn" is more about "*if you were to* rewrite and find issues,
please notify me".  So I prefer what is queued already.
