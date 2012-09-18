From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Tue, 18 Sep 2012 12:47:36 -0700
Message-ID: <7vboh3m7tz.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
 <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
 <20120918001522.GA10283@sigill.intra.peff.net>
 <7v7grsqi98.fsf@alter.siamese.dyndns.org>
 <20120918185530.GB20498@sigill.intra.peff.net>
 <7vsjafm9hd.fsf@alter.siamese.dyndns.org>
 <20120918191653.GA21187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3ls-00080Q-V2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab2IRTrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:47:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab2IRTrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:47:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 151AD9E95;
	Tue, 18 Sep 2012 15:47:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y4ebvZgjQNblpbcjI+y5mHrjdQo=; b=mpX6lU
	agTgkfdGd0jaV14OL5WxxB8mppW7Tgx4XKrj/clLVMSvhKhyNvpQLNJMHFqDJjGN
	ezxHTjGSQc7chjFZ8lSCOt23BT+RsaHHi3muDKfZn+Wd8GrBvfG0dKHKMInQFzgo
	QpyPmHShEAE8/j/OG3hBCVnRs283M8nTC78Og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dlCEL8dymZ2SAtUVqeKWwOkPHCFYvX1i
	ZJyRV/LS1V8c6US1JLr4k0VhnPIhipHfV64WMfTtvHO798YAV9Y8JOqAomA0jhoc
	9yBJgnqaYjas1McpsOZELNTc9aAU/QWC1HywiokZyvjHzM6FO8rYt/C/jGcCf/9i
	/BTYDgPigTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 031B09E94;
	Tue, 18 Sep 2012 15:47:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 404E39E93; Tue, 18 Sep 2012
 15:47:38 -0400 (EDT)
In-Reply-To: <20120918191653.GA21187@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 18 Sep 2012 15:16:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B34C39F4-01C9-11E2-925E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205859>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 18, 2012 at 12:11:58PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > But even without that, I still think format-patch is a reasonable time
>> > to do it. It is the time when I proof-read my commit message and patch
>> > in its final form, and think "do I really want to send this?".
>> 
>> But it is not like "I cannot sign off because I think it is still
>> iffy".
>
> No, that is not the particular reason in my case, but I think I
> explained other reasons why "format-patch -s" is not a wrong workflow.

Then I didn't read it.  What does "do I really want to send this?"
have anything to do with DCO in any case?
