From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] remote: simplify remote_is_configured()
Date: Mon, 15 Feb 2016 13:37:44 -0800
Message-ID: <xmqqwpq5psd3.fsf@gitster.mtv.corp.google.com>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
	<1455558150-30267-3-git-send-email-t.gummerer@gmail.com>
	<20160215182113.GF26443@sigill.intra.peff.net>
	<20160215203846.GD13775@hank>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:37:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQq7-0006Qp-Qc
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbcBOVhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:37:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751120AbcBOVhr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:37:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2886345ED4;
	Mon, 15 Feb 2016 16:37:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dHTzm5TIOedznAD5YUE9YNtJZi8=; b=JLl85h
	5kgNMh4+F16UXDemMf6lSGCszYRfLgnoWMCFGARdzisHH+aDtrRIyR/qfuOMMXTS
	iPeB3j3ryYAMvWq1YnIXc5ZOS64ZS09bFTXDcCDSAEa2LBp5yuRG6YdvKE3nkPwp
	D31vF3HNLqp8al6ZcwcymBIHbjE38YsP11/y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FforWZ7fAOGj/yCN0UfLPN6ybSewdJw0
	toDIkUOhVe90qsCdbmaSarb0F7JI/mgXHLkW4f34bDsmCK4owqjlZsrTdzEhOyrr
	Jd3TKuqNaJ/I3D0UrpEACxKZygTdzivYIKBdFpvKK/Hi3YCOD4jtBGDKEuOLf0vB
	k68hNqol4K4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E1A845ED3;
	Mon, 15 Feb 2016 16:37:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 81B4045ED2;
	Mon, 15 Feb 2016 16:37:46 -0500 (EST)
In-Reply-To: <20160215203846.GD13775@hank> (Thomas Gummerer's message of "Mon,
	15 Feb 2016 21:38:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A6DB950-D42C-11E5-AD84-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286247>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Agreed, will change.  Thanks.

Thanks for working on this, and thanks reviewers for helping.
