From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/2] Smart-http tests: Break test t5560-http-backend 
 into pieces
Date: Thu, 31 Dec 2009 21:15:28 -0800
Message-ID: <7viqbmo173.fsf@alter.siamese.dyndns.org>
References: <1262037899-16786-1-git-send-email-tarmigan+git@gmail.com>
 <7veimc2vq0.fsf@alter.siamese.dyndns.org>
 <905315640912301009x491f957al839f66de7aba56ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 06:15:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQZrT-0000yi-AC
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 06:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab0AAFPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 00:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827Ab0AAFPi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 00:15:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0AAFPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 00:15:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E75C8CCB4;
	Fri,  1 Jan 2010 00:15:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3vHynCcr2zmifXjp4L85VNYjzrs=; b=OltpY1QjK/7ahBRw7wryMV9
	1dwLyeM00y5WuZHEQx+lscdOhn5SW1LbaXDV2fd6P68qstlhIFv08wnfEQ/NnGko
	bhSSUbez65zxjkFyllLXRctk1xnYe7jUYQqukyWNw8fRbmIgBKxlTg6BSLLwmLoq
	tH9RKWFWTfBpZt3qKeuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PaiU9EmGX7xMAd11m4MKvkbm436kD4fWntX/HBOtgOc/HKNvU
	eMkRE1Q1LxJEm1pKOr4KjEn+v2Nq+8N0m6eRZqaZUGZvzATqHuGbzkEyGDBvc9ht
	M/vdsjLdD4uduAvG4R0YmoRsL3INNWOLHp9bm3+0W/ZJhQyB4NoLfPSS8s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28DFE8CCB0;
	Fri,  1 Jan 2010 00:15:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 580628CCAF; Fri,  1 Jan
 2010 00:15:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0510F2E-F694-11DE-A2B6-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136000>

Tarmigan <tarmigan+git@gmail.com> writes:

> One reason it's labeled RFC is that I'm not very confident in my
> ability to write portable shell script.  It works for me with bash,
> but I'm not completely confident that is would work on ksh or dash.
> So it would be nice if you could specifically take a look at the new
> POST() and GET() and see if you notice anything obviously wrong there.

Looked Ok to me from a cursory reading, even though I wonder what the
first argument to run_backend function is good for...
