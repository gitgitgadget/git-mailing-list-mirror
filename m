From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git mv` has ambiguous error message for non-existing target
Date: Sat, 17 Nov 2012 11:35:09 -0800
Message-ID: <7vpq3cja4y.fsf@alter.siamese.dyndns.org>
References: <50A53A80.4080203@gmx.de>
 <7vehju8h5j.fsf@alter.siamese.dyndns.org> <50A5E6D2.5060609@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Lehner <lehner.patrick@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:35:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZoAs-0005EC-M2
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 20:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab2KQTfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 14:35:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab2KQTfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 14:35:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 138F0A2E5;
	Sat, 17 Nov 2012 14:35:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YSviXdl6G1sFgvdaxzWhkY6+XHo=; b=DkVRrN
	a6reFHGJipNTrnFAAGJdv9ypInze0iqODlh6Xrb/m3NzmzlYIY0K6qUXiHdLcyyG
	QzqgQiC3MJXj+vy8P43Y6huwpEEXpoUSAFWjEDwKEy/Omi3bxenfVvaFT6/OZQEh
	KgGbKKntlCtNhlkcvRHXCvTCy/K75E0OJ1flI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tyyzr0699yZDR1w/6lwPUmtxIq1c7NzT
	av+nPx9pfcsPGe9sR1ILoZ4B6NZpaXwARO8SYV9zCAHeJVDlx70YVE5bbgUdC7if
	ufSMrZ7C3NNuVcAsBSVmbxAY0cMYYJPaPyl7IXlh27MXLYGz4OdKS+deZxSbXBJg
	dGERozWZCSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F26A2E4;
	Sat, 17 Nov 2012 14:35:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71836A2E3; Sat, 17 Nov 2012
 14:35:11 -0500 (EST)
In-Reply-To: <50A5E6D2.5060609@gmx.de> (Patrick Lehner's message of "Fri, 16
 Nov 2012 08:10:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6F4E06E-30ED-11E2-8A4E-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209972>

Patrick Lehner <lehner.patrick@gmx.de> writes:

> But just because mv's error essage isnt very good, does that mean git
> mv's error message mustn't be better?

Did I say the error message from 'mv' was not very good in the
message you are responding to (by the way, this is why you should
never top-post when you are responding to a message on this list)?

I meant to say that the message from 'mv' is good enough, so is the
one given by 'git mv'.

I wouldn't reject a patch that updates our message to something more
informative without looking at it, though.
