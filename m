From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 14:41:13 -0700
Message-ID: <7v7huck1ae.fsf@alter.siamese.dyndns.org>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
 <7vaaz8lleg.fsf@alter.siamese.dyndns.org>
 <20091030194333.GA4551@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.de>,
	553296@bugs.debian.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:41:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zDv-0005s3-NX
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535AbZJ3VlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757475AbZJ3VlU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:41:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433AbZJ3VlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:41:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D89036D14E;
	Fri, 30 Oct 2009 17:41:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WM8vo2o708vPCFcN/H2TO+m3km0=; b=qS6igs
	X1/UFxREKPoLYOQAC+JjgJCTJqtS0HUYtNU1RS2EVtt2t1y7h8vz74+470EfO02t
	1CA6ssT1Q72Te7jEtdTMaUg9MJxqVXUN2axOSB0rjOJQ3074IWhZrftHNqOseic9
	5ZGrzdxnhv1NNig0rum2NbL+GxKQx2e2mF8Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eFIBGBOuwvVdA8t9K9VofwcpPa/yuWvA
	xAXyB14hf40U/q4GOYwQLOxqY6hovC/Pm1OpRLykQTtDjFNJ75QS5H5haZnK0Ceb
	AVQ/IAdCUxq+C9IiyE45tpTfBJaUfgZ6qRcFpvd7jZdxfxU3lik43kJQSYi0znbA
	oGPDkJysKLA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 999516D14C;
	Fri, 30 Oct 2009 17:41:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4ED06D147; Fri, 30 Oct
 2009 17:41:14 -0400 (EDT)
In-Reply-To: <20091030194333.GA4551@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 30 Oct 2009 15\:43\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6540D06-C59C-11DE-9D91-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131756>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 30, 2009 at 12:41:27PM -0700, Junio C Hamano wrote:
>
>> I've never understood the use of "ls-files -i" without -o, so in that
>> sense, I have done 2. myself already long time ago.
>> 
>> In other words, I do not really care that much, and the choice would be
>> between "0. do not do anything---the patch in question was a bugfix for
>> longstanding insanity" and your "4. -i without -o didn't make much sense
>> but now it does and here is the new meaning".
>
> OK, I think the patch I sent elsewhere in the thread should be applied,
> then, as it should make you, me, and Klaus happy.

Thanks; will queue on top of b5227d8.
