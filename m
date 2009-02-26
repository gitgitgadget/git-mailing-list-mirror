From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 15:29:39 -0800
Message-ID: <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
 <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
 <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
 <7veixkrfif.fsf@gitster.siamese.dyndns.org>
 <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcphL-0000Hp-1t
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbZBZX3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbZBZX3s
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:29:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbZBZX3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:29:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 637219DE7E;
	Thu, 26 Feb 2009 18:29:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1C12C9DE79; Thu,
 26 Feb 2009 18:29:40 -0500 (EST)
In-Reply-To: <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com>
 (Jay Soffian's message of "Thu, 26 Feb 2009 17:40:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59DD19F0-045D-11DE-8F75-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111610>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Thu, Feb 26, 2009 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I don't mind Perl as we already depend on it; the looseness of the regexp
>> stil bothers me somewhat, though...
>
> I think you're letting the perfect be the enemy of the good. The point
> of the test is merely to check for the SHA-1 has suffix in PUT/MOVE
> operations. Any of my suggestions so far are better than what is there
> now. Why so much fuss?
>
> I'll send one more iteration, and if that's not good enough, I give up.
>
> j.

Heh, at least with /a-z/a-f/, I think it is usable.

Or is there a reason I am missing that we want to allow g-z there?
