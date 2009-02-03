From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Tue, 03 Feb 2009 01:22:05 -0800
Message-ID: <7v4ozbdgea.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
 <20090202124148.GB8325@sigio.peff.net>
 <7vskmwc5js.fsf@gitster.siamese.dyndns.org>
 <20090203080734.GA27251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 10:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUHVN-0003sR-II
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 10:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZBCJWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 04:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbZBCJWQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 04:22:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbZBCJWP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 04:22:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56FD395325;
	Tue,  3 Feb 2009 04:22:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1A13695323; Tue,
  3 Feb 2009 04:22:06 -0500 (EST)
In-Reply-To: <20090203080734.GA27251@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Feb 2009 03:07:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 24C639A4-F1D4-11DD-817D-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108170>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 03, 2009 at 12:01:43AM -0800, Junio C Hamano wrote:
>
>>  	"To allow pushing into the current branch, you can set it to 'ignore';",
>> -	"but this is not recommended unless you really know what you are doing.",
>> +	"but this is not recommended unless you arranged its work tree to get",
>> +	"updated to match what you pushed in some other way.",
>
> This is much better, but I believe it needs to be "...arranged _for_
> its work tree to get updated..." to be grammatically correct.
>
> And as a nit (which I seem to be full of tonight), you can get rid of
> the passive voice by saying:
>
>  but this is not recommended unless you arranged to update its work
>  tree to match what you pushed in some other way.
>
> which is slightly more clear, IMHO.

Much more clear.  I overuse the passive voice, I know it is a bad habit I
somehow cannot shake off.

Thanks.
