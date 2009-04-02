From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 02 Apr 2009 13:52:48 -0700
Message-ID: <7vljqieq1r.fsf@gitster.siamese.dyndns.org>
References: <20090402123823.GA1756@pvv.org>
 <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
 <20090402134414.GB26699@coredump.intra.peff.net>
 <7vab6zexq7.fsf@gitster.siamese.dyndns.org> <20090402201803.GA5397@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:54:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpTvu-0004xz-Oh
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758952AbZDBUxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbZDBUxA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 16:53:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757609AbZDBUw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 16:52:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 66BB6A7F64;
	Thu,  2 Apr 2009 16:52:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B44E0A7F62; Thu,
  2 Apr 2009 16:52:50 -0400 (EDT)
In-Reply-To: <20090402201803.GA5397@pvv.org> (Finn Arne Gangstad's message of
 "Thu, 2 Apr 2009 22:18:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3E207BD6-1FC8-11DE-AF86-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115497>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Thu, Apr 02, 2009 at 11:06:56AM -0700, Junio C Hamano wrote:
>> [...]
>> 
>> I gave the patch an only cursory look, so I wouldn't comment on the
>> implementation; two things I would look at in the code would be if it
>> makes two connections to the remote to learn the same information (which
>> would be bad)
>
> How bad?

I'd say only "could be improved later" bad.
