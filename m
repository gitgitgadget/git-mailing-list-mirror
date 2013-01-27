From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [feature request] git add completion should exclude staged
 content
Date: Sun, 27 Jan 2013 15:00:02 -0800
Message-ID: <7vip6iteod.fsf@alter.siamese.dyndns.org>
References: <20130126172137.GB5852@mobster.11n_AP_Router>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>
To: wookietreiber <kizkizzbangbang@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzbDB-0002Mk-CL
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816Ab3A0XAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:00:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755920Ab3A0XAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:00:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF56FB4F3;
	Sun, 27 Jan 2013 18:00:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qWYXwIOyxjvGSNUViKvsGrpGzKI=; b=cT37ix
	Vbimo6qsjkooUqoB7EuPqT5nEzh5SE2Wt+4aCDl8yx+xAaIUrZ4nXI6xxXF0gxd7
	/+XNAo5MuedFTOvPNreEmKep4yk0lkbe/ddTI1vwM77tVKGdk9AiwP6S5qxBuJC1
	QDbyz2JmQNKkh6Jdt1KRcHU/XqOAbCBGE16Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ai/MxM2U1BqgFVyyrm7pyQj3a+YmooLU
	jNEhr/5qsUfrDFn+LqzPKdV34YJo3Ozo0wTwmzV5OKCOP/suKY/x0W5+rvdPqTT3
	LzZuwW3KsDmSX2+L6ahwRiFZQzjVPrsDF8OoO7lrNHVZcTRHlmd4jkX5P37WjJze
	yBMoKMXPCCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E37D0B4F1;
	Sun, 27 Jan 2013 18:00:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C5D6B4F0; Sun, 27 Jan 2013
 18:00:03 -0500 (EST)
In-Reply-To: <20130126172137.GB5852@mobster.11n_AP_Router> (wookietreiber's
 message of "Sat, 26 Jan 2013 18:21:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4973C254-68D5-11E2-8F0D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214747>

wookietreiber <kizkizzbangbang@googlemail.com> writes:

> I have a feature request for `git add` auto completion:
>
> `git add` auto completion suggests all files / directories,
> filtered by nothing. I guess it would be much nicer (as in
> increasing productivity) if it would only suggest unstaged
> content, as reported by `git status`, because that would be the
> only content one would be able to add.

I think that is what Manlio Perillo tried to do with the stalled
mp/complete-paths topic that is queued in 'pu'.

Manlio, any progress?
