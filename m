From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 02 Oct 2012 12:08:02 -0700
Message-ID: <7vtxuc7kvh.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
 <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com>
 <7vbogk90zk.fsf@alter.siamese.dyndns.org>
 <CAN7QDoLD+igYqVCgtKQsnW7f1Ntpk-RyaP8cn24cBrMjOO6NEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: David Glasser <glasser@davidglasser.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:08:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7pL-0005x4-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab2JBTIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:08:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab2JBTIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:08:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D0F88194;
	Tue,  2 Oct 2012 15:08:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gWydKU7ok6WEG/gafdfv4bp5ZC4=; b=e6TSYT
	Taoj0iIiYUkX63mYAZgW8OBl0lzA53nhE979h5et9uvllX/HN9EDSKLUPVgL8nPO
	5VnE/HuA2S7wbZ7LXd+v/RXrGvnxdjqyegl/feNsCstjNqKPl4a+CYs7WtiUJoNK
	LziUKChqf6wdRWv9xdsbnhKwgVUnS/c8YFpis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ncn37EFq1lL7gR/6g8HWGs5Rli9hSoA7
	m0yeJqz22BO2BkpIBwWYvsnh9q9IDdXDHDKK9aAyt/EAdURK2LFibJ5SYjxHzxfb
	1+CVn7WXVnfg4D1d3TSWAN9SrKLP8zFDpszioQEXRD0l/1rj2NCuN7gcDWNuO+sq
	dTFEVWV1yRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 798628193;
	Tue,  2 Oct 2012 15:08:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C15C68191; Tue,  2 Oct 2012
 15:08:03 -0400 (EDT)
In-Reply-To: <CAN7QDoLD+igYqVCgtKQsnW7f1Ntpk-RyaP8cn24cBrMjOO6NEg@mail.gmail.com> (David
 Glasser's message of "Tue, 2 Oct 2012 12:00:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DC935C4-0CC4-11E2-88D6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206835>

David Glasser <glasser@davidglasser.net> writes:

> Thanks Junio! Note that I think the word is usually spelled
> "controlled" not "controled".

Thanks; I cannot spelll...
