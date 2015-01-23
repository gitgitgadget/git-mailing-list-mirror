From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull not ignoring the file which has been sent to the temporary ignore list
Date: Fri, 23 Jan 2015 14:26:15 -0800
Message-ID: <xmqq4mrhqgl4.fsf@gitster.dls.corp.google.com>
References: <3278910.5D06XWKxyS@linux-wzza.site>
	<xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
	<4004424.cytMaov38D@linux-wzza.site>
	<CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com>
	<xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaJkDjr7uPScKgO=P5nVZ4sQgn1aQNf9MwVuHMcA4a2NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Arup Rakshit <aruprakshit@rocketmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmgI-00080W-JN
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbbAWW0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 17:26:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751726AbbAWW0R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 17:26:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D827231895;
	Fri, 23 Jan 2015 17:26:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nNQgwG6F3HLzx4ruVXURWnBWmPI=; b=ci12Tw
	Khf7k3ZQJK1y8XjPuv99LSQYHRRMl5pv6zyd5PQDnex6cRTNjW3v8fEp9Uru4GRk
	2Ml716GG5eu0wB0xF+Q8q7tmFP2gscMFJpwVrDZtMDtdtzS5Da08F6J85/bd3MAL
	6/xUFjKBECByx0wYGwUS8vr18JBMncteCHk+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xlOeLgqMWp5XkgRwgOaKtKtcW3dfM7NX
	jsVbtulKVntCJWoJBIz548KBrC7XcuIMGlnyXDKfDqORPPu93x0HzPfLCuJu7r/H
	3OYJHZGJCXp2O12mji8KX7ciKQ/L+lWORirvO7nkXr9ay9SlpQuA+mJhTZ77AbBh
	4GLaZK91Wu8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD1D331894;
	Fri, 23 Jan 2015 17:26:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44A2E31892;
	Fri, 23 Jan 2015 17:26:16 -0500 (EST)
In-Reply-To: <CAGZ79kaJkDjr7uPScKgO=P5nVZ4sQgn1aQNf9MwVuHMcA4a2NQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 23 Jan 2015 13:38:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D87E92DE-A34E-11E4-9430-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262968>

Stefan Beller <sbeller@google.com> writes:

> Assuming you want to ignore less than the upstream project (delete some
> lines from .gitignore) it get's tricky in my opinion.

Why?  Doesn't info/exclude allow negative ignore patterns?
