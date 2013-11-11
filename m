From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 12/10] git-remote-testgit: support the new 'force' option
Date: Mon, 11 Nov 2013 10:28:34 -0800
Message-ID: <xmqqwqkelrn1.fsf@gitster.dls.corp.google.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
	<1382908589-7000-1-git-send-email-rhansen@bbn.com>
	<526f74cf8307f_37cdfb1e7c31@nysa.notmuch> <52800CB7.7080905@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	srabbelier@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwE6-0001Pj-BW
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab3KKS2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:28:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab3KKS2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:28:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EE6F5009C;
	Mon, 11 Nov 2013 13:28:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LoOcLFCZuQcvWZcT6ScyW4Sela8=; b=beYD/r
	qrCzEBDY0Rgyxmmq/egwyWnBmpePbnpHEXwx+U31uoBau2ZN2P9k7WBN8kdtUaCx
	Ui0Ph7m7lCCcUTRB8i9wMayYRnvb05RIxsWsPx+taf9+wjqzpOndSpe8AWS8NeFG
	HrztdOdf27IDAOzJJ0hLWoV3eGT/+b5zp2dFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vQavjdklcMrYKmhUl61byKqrZnNFjGGI
	knA32j+f2eL5tK0TAnxNGE7xOxY3lUiQvNjjaRQ2vqAOlRLCtWuj6WObewvRIddH
	DmgmvgSE1H01wFuyVZMUQkjcIiWeELHaD5EQ6xw/kqnBrpCea4vDeHFvR6UM9Ehy
	sVVj1RKbYJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E50A95009A;
	Mon, 11 Nov 2013 13:28:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 467BD50098;
	Mon, 11 Nov 2013 13:28:36 -0500 (EST)
In-Reply-To: <52800CB7.7080905@bbn.com> (Richard Hansen's message of "Sun, 10
	Nov 2013 17:46:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 13F23B1C-4AFF-11E3-8228-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237626>

Richard Hansen <rhansen@bbn.com> writes:

>> I think the convention is to align these:
>> 
>> case $opt in
>> force)
>
> The existing case statement in this file indents the patterns the same
> amount as the case statement, so this should be aligned to match.
>
> In general I rarely see the case patterns indented at the same level as
> the case statement,

What you see does not matter in the context of this project ;-)
This is what we have in Documentation/CodingGuidelines:

    For shell scripts specifically (not exhaustive):

     - Case arms are indented at the same depth as case and esac lines.

Thanks.
