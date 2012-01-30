From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Mon, 30 Jan 2012 10:17:20 -0800
Message-ID: <7vd3a1caxb.fsf@alter.siamese.dyndns.org>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
 <87hazdazmb.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:17:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrvnD-0007UN-Mf
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab2A3SRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:17:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab2A3SRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:17:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11CBE6708;
	Mon, 30 Jan 2012 13:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X57h6sCXeioTW/GyH5i+CzheDB8=; b=oXEZBR
	AxBzMwJuSWNs0MMgC/ZHfT533+J+famucd9K8/428S4PneZCGtxUM+eXug0JVU06
	5tEFcXJfS3gPS/X+wbcvX2Vuq+J7xiSqlLMw5aHjh3dXSrcw80m6EoEwuuCBlr4J
	soVfltReItJdA9w0W+KfsVSjkmTDEr76PIZbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sl6oU1dSGjirfd3wkngAMB67LEg1mn4H
	RoOtfPk6Xx2zPObxxHZO/mtSi16N9K8xhumV9sKytTFUywpThopNtMDD3ZXVcp3g
	P+PFlIB5A14xWULkPzXTS8+MHNCKUsvIRG2mg4M43XpY7Unn4Ujc0wEYe/iYoC9U
	E9c1N74zN5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 095BC6706;
	Mon, 30 Jan 2012 13:17:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9374D6705; Mon, 30 Jan 2012
 13:17:21 -0500 (EST)
In-Reply-To: <87hazdazmb.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 30 Jan 2012 18:06:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6E202D2-4B6E-11E1-B473-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189388>

Thomas Rast <trast@student.ethz.ch> writes:

> I would suggest something like
>
> # Please enter the commit message for your merge commit.  Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
>
> or if you feel comfortable with educating the user in a
> workflow-specific way, even
>
> # Please enter the commit message for your merge commit.  You should
> # justify it especially if it merges an updated upstream into a topic
> # branch.
> # 
> # Lines starting with '#' will be ignored, and an empty message aborts
> # the commit.

Sounds like a good thing to do.
Please make it so.
